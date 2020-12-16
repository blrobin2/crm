import { PayloadAction, SerializedError, EntityId } from '@reduxjs/toolkit';
import normalize from '@disruptph/json-api-normalizer';

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

interface CallApiParams {
  endpoint: string;
  method: string;
  token: string | null;
  pageNumber?: number;
}

export const callApi = ({ endpoint, method, pageNumber, token }: CallApiParams) => {
  const headers: Record<string, string> = {
    'Content-Type': 'application/vnd.api+json',
    'Accept': 'application/vnd.api+json'
  };

  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  let url = `/api/v1/${endpoint}`;
  if (pageNumber) {
    url += `?page[number]=${pageNumber}`;
  }

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

export type ApiResponse<T> = {
  value: Record<EntityId, T>,
  meta: MetaState
};

export const normalizeApiResponse = async <T>(response: Response, key: string): Promise<ApiResponse<T>> => {
  const json = await response.json();
  const normalized = normalize(json);

  return { value: normalized[key], meta: json.meta } as unknown as ApiResponse<T>;
}
