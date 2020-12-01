import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";

import { AppDispatch, RootState } from '../../app/store';
import { Status } from "../../app/status";

type Token = string;

export interface Auth {
  token: Token | null;
}

export interface AuthState extends Auth {
  status: Status;
  error: string | null;
}

export interface UserCredentials {
  email: string;
  password: string;
}

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

export const login = createAsyncThunk<Token, UserCredentials, {}>('auth/login', async (credentials: UserCredentials, { rejectWithValue }) => {
  const body = {
    data: {
      type: 'sessions',
      attributes: {
        ...credentials
      }
    }
  };
  const response = await fetch('/api/v1/sessions', {
    method: 'post',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/vnd.api+json'
    },
    body: JSON.stringify(body)
  });
  if (response.status !== 201) {
    const responseAsJson: ApiErrors = await response.json();
    return rejectWithValue(responseAsJson.errors[0].detail);
  }

  return response.headers.get('authorization') as Token
});

export const logout = createAsyncThunk<
  void,
  void,
  {
    dispatch: AppDispatch,
    state: RootState
  }
>('auth/logout', async (_, { getState, rejectWithValue }) => {
  const token = selectAuthToken(getState());
  const response = await fetch('/api/v1/sessions', {
    method: 'delete',
    credentials: 'include',
    headers: {
      'Content-Type': 'application/vnd.api+json',
      'Authorization': `Bearer ${token}`
    }
  });

  if (response.status !== 204) {
    const responseAsJson: ApiErrors = await response.json();
    return rejectWithValue(responseAsJson.errors[0].detail);
  }
});

const initialState: AuthState = {
  token: null,
  status: Status.IDLE,
  error: null
};

const authSlice = createSlice({
  name: 'auth',
  initialState,
  reducers: {},
  extraReducers: builder => {
    builder.addCase(login.pending, state => {
      state.status = Status.LOADING;
    });
    builder.addCase(login.fulfilled, (state: AuthState, action) => {
      state.status = Status.SUCCEEDED;
      state.error = null;
      state.token = action.payload;
    });
    builder.addCase(login.rejected, (state: AuthState, action) => {
      state.status = Status.FAILED;
      state.error = action.payload as string;
    });

    builder.addCase(logout.pending, state => {
      state.status = Status.LOADING;
    });
    builder.addCase(logout.fulfilled, (state: AuthState) => {
      state.status = Status.SUCCEEDED;
      state.error = null;
      state.token = null;
    });
    builder.addCase(logout.rejected, (state: AuthState, action) => {
      state.status = Status.FAILED;
      state.error = action.payload as string;
    });
  }
});

export default authSlice.reducer;

export const selectAuthToken = (state: RootState) => state.auth.token;
export const selectAuthError = (state: RootState) => state.auth.error;
