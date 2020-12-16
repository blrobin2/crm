import { AnyAction } from '@reduxjs/toolkit';
import { Status } from './status';

type ReducerType<T> = (state: T | undefined, action: AnyAction) => T;

export const reducerErrorTest = <T>(reducer: ReducerType<T>, initialState: any, type: string) => {
  const error = new Error('Some Error');
  expect(
    reducer(initialState, {
      type,
      payload: error
    })
  ).toEqual({
    ...initialState,
    status: Status.FAILED,
    error: error
  });
}

export const reducerPendingTest =<T>(reducer: ReducerType<T>, initialState: any, type: string) => {
  expect(
    reducer(initialState, {
      type
    })
  ).toEqual({
    ...initialState,
    status: Status.LOADING
  });
}