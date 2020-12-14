import { createBrowserHistory } from 'history';
import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import { combineReducers } from 'redux'
import { connectRouter, routerMiddleware } from 'connected-react-router';
import throttle from 'lodash/throttle';

import authReducer from '../features/auth/authSlice';
import usersReducer from '../features/users/usersSlice';
import { loadToken, saveToken } from './tokenStorage';

export const history = createBrowserHistory();

const reducers = combineReducers({
  router: connectRouter(history),
  auth: authReducer,
  users: usersReducer
});

const preloadedState = loadToken();
export const store = configureStore({
  reducer: reducers,
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(routerMiddleware(history)),
  preloadedState
});

store.subscribe(throttle(() => {
  saveToken(store.getState().auth.token);
}, 1000));

export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
export type AppDispatch = typeof store.dispatch