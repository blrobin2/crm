import { createBrowserHistory } from 'history';
import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import { combineReducers } from 'redux'
import { connectRouter, routerMiddleware } from 'connected-react-router';

import authReducer from '../features/auth/authSlice';

export const history = createBrowserHistory();

const reducers = combineReducers({
  router: connectRouter(history),
  auth: authReducer
})

export const store = configureStore({
  reducer: reducers,
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(routerMiddleware(history))
});

export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
  ReturnType,
  RootState,
  unknown,
  Action<string>
>;
export type AppDispatch = typeof store.dispatch