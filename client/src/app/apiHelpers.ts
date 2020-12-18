import { PayloadAction, SerializedError, EntityId, EntityAdapter, EntityState } from '@reduxjs/toolkit';
import normalize from '@disruptph/json-api-normalizer';
import { stringify as stringifyQuery } from 'qs';

import { Status } from './status';

export interface ApiError {
  title: string;
  detail: string;
  source: {
    parameter: string;
    pointer: string;
  }
}

export interface ApiErrors {
  errors: ApiError[]
}

export interface MetaState {
  current_page?: number;
  total_pages?: number;
  total_count?: number;
  max_page_size?: number;
}

export interface AppState {
  status: Status;
  error: string | null;
  meta: MetaState;
}

export interface CallApiQueryParams {
  page?: {
    number?: number;
  },
  where?: {
    [key: string]: any;
  },
  filter?: {
    [key: string]: boolean;
  }
}

export interface CallApiParams {
  endpoint: string;
  method: string;
  token: string | null;
  params?: CallApiQueryParams
}

export const callApi = ({ endpoint, method, params, token }: CallApiParams) => {
  const headers: Record<string, string> = {
    'Content-Type': 'application/vnd.api+json',
    'Accept': 'application/vnd.api+json'
  };

  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const url = `/api/v1/${endpoint}?${stringifyQuery(params)}`;

  return fetch(url, {
    method,
    credentials: 'include',
    headers
  });
}

export const getApiError = async (response: Response) => {
  const responseAsJson: ApiErrors = await response.json();
  return responseAsJson.errors[0].detail;
};

export const handleApiRejection = <T, U extends AppState>(
  state: U,
  action: PayloadAction<
    unknown,
    string,
    {
      arg: T;
      requestId: string;
      aborted: boolean;
      condition: boolean;
    },
    SerializedError
  >
) => {
  state.status = Status.FAILED;
  state.error = action.payload as string;
};

export const handleApiFetchAll = <U, T extends AppState & EntityState<U>>(
  state: T,
  action: PayloadAction<any>,
  adapter: EntityAdapter<U>
) => {
  state.status = Status.SUCCEEDED;
  state.meta = action.payload.meta;
  adapter.setAll(state as EntityState<U>, action.payload.value);
}

export type ApiResponse<T> = {
  value: Record<EntityId, T>,
  meta: MetaState
};

export const normalizeApiResponse = async <T>(response: Response, key: string): Promise<ApiResponse<T>> => {
  const json = await response.json();
  const normalized = normalize(json);

  return { value: normalized[key], meta: json.meta } as unknown as ApiResponse<T>;
}
