import { EntityId, createEntityAdapter, createSlice, createAsyncThunk, createSelector } from '@reduxjs/toolkit';
import {
  CallApiQueryParams,
  AppState,
  ApiResponse,
  callApi,
  getApiError,
  normalizeApiResponse,
  handleApiFetchAll,
  handleApiRejection
} from '../../app/apiHelpers';
import { Status } from '../../app/status';
import { AppDispatch, RootState } from '../../app/store';
import { selectAuthToken } from '../auth/authSlice';

export interface Territory {
  id: EntityId;
  attributes: {
    name: string;
    parentId: EntityId;
    childIds: number[];
  },
  relationships: {
    advisor: {
      data?: {
        id: number;
        type: 'users';
      }
    },
    sales: {
      data?: {
        id: number;
        type: 'users';
      }
    }
  }
}

export const territoriesAdapter = createEntityAdapter<Territory>();

const initialState = territoriesAdapter.getInitialState<AppState>({
  status: Status.IDLE,
  error: null,
  meta: {}
});

interface FetchTerritoriesParams {
  pageNumber?: number;
  parentId?: number;
}

export const fetchTerritories = createAsyncThunk<
  ApiResponse<Territory>,
  FetchTerritoriesParams,
  {
    dispatch: AppDispatch,
    state: RootState
  }
>('territories/index', async ({ pageNumber, parentId }, { getState, rejectWithValue }) => {
  const token = selectAuthToken(getState());
  const params: CallApiQueryParams = {
    page: {
      number: pageNumber
    },
  };
  if (parentId) {
    params.where = {
      parent_id: parentId
    };
  } else {
    params.filter = {
      top_level: true
    };
  }

  const response = await callApi({
    endpoint: 'territories',
    method: 'get',
    params,
    token
  });

  if (response.status !== 200) {
    const error = await getApiError(response);
    return rejectWithValue(error);
  }
  const normalized = await normalizeApiResponse<Territory>(response, 'territories');
  return normalized;
});

const territoriesSlice = createSlice({
  name: 'territories',
  initialState,
  reducers: {},
  extraReducers: builder => {
    builder.addCase(fetchTerritories.pending, state => {
      state.status = Status.LOADING;
    });

    builder.addCase(fetchTerritories.fulfilled, (state, action) =>
      handleApiFetchAll(state, action, territoriesAdapter));

    builder.addCase(fetchTerritories.rejected, handleApiRejection);
  }
});

export default territoriesSlice.reducer;

export const {
  selectAll: selectAllTerritories,
  selectIds: selectTerritoryIds,
  selectById: selectTerritoryById
} = territoriesAdapter.getSelectors<RootState>(state => state.territories);

export const selectTerritoriesStatus = (state: RootState) => state.territories.status;
export const selectTerritoriesError = (state: RootState) => state.territories.error;
export const selectTerritoriesMeta = (state: RootState) => state.territories.meta;
export const selectTerritoryParentId = createSelector<RootState, Territory[], number>(
  selectAllTerritories,
  territories => territories.length > 0 ? territories[0].attributes.parentId as number : -1
);
export const selectTerritoryAdvisorLink = createSelector(
  selectTerritoryById,
  territory => {
    if (!territory) return undefined;

    const data = territory.relationships.advisor.data;
    if (!data) return undefined;

    return `/${data.type}/${data.id}`;
  }
);