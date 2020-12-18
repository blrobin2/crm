import { createAsyncThunk, createSlice, createEntityAdapter, EntityId } from '@reduxjs/toolkit';

import { AppDispatch, RootState } from '../../app/store';
import {
  AppState,
  getApiError,
  callApi,
  handleApiRejection,
  handleApiFetchAll,
  normalizeApiResponse,
  ApiResponse
} from '../../app/apiHelpers';
import { selectAuthToken } from '../auth/authSlice';
import { Status } from '../../app/status';

export enum UserRole {
  ADMIN = 'admin',
  SALES = 'sales',
  ADVISOR = 'advisor'
}

export interface User {
  id: EntityId;
  attributes: {
    email: string;
    firstName?: string;
    lastName?: string;
  }
}

export const usersAdapter = createEntityAdapter<User>();

const initialState = usersAdapter.getInitialState<AppState>({
  status: Status.IDLE,
  error: null,
  meta: {}
});

export const fetchUsers = createAsyncThunk<
  ApiResponse<User>,
  number,
  {
    dispatch: AppDispatch,
    state: RootState
  }
>('users/index', async (pageNumber, { getState, rejectWithValue }) => {
  const token = selectAuthToken(getState());
  const response = await callApi({
    endpoint: 'users',
    method: 'get',
    params: {
      page: {
        number: pageNumber
      }
    },
    token
  });

  if (response.status !== 200) {
    const error = await getApiError(response);
    return rejectWithValue(error);
  }
  const normalized = await normalizeApiResponse<User>(response, 'users');
  return normalized;
});

const usersSlice = createSlice({
  name: 'users',
  initialState,
  reducers: {},
  extraReducers: builder => {
    builder.addCase(fetchUsers.pending, state => {
      state.status = Status.LOADING
    });

    builder.addCase(fetchUsers.fulfilled, (state, action) =>
      handleApiFetchAll(state, action, usersAdapter));

    builder.addCase(fetchUsers.rejected, handleApiRejection);
  }
});

export default usersSlice.reducer;

export const {
  selectAll: selectAllUsers,
  selectById: selectUserById,
  selectIds: selectUserIds
} = usersAdapter.getSelectors<RootState>(state => state.users)

export const selectUsersStatus = (state: RootState) => state.users.status;
export const selectUsersError = (state: RootState) => state.users.error;
export const selectUsersMeta = (state: RootState) => state.users.meta;