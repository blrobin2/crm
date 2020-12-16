import configureMockStore from 'redux-mock-store';
import fetchMock from 'fetch-mock-jest';
import { getDefaultMiddleware } from '@reduxjs/toolkit';

import reducer, { fetchUsers } from './usersSlice';
import { reducerErrorTest, reducerPendingTest } from '../../app/reducerTestHelpers';
import { Status } from '../../app/status';

const mockStore = configureMockStore(getDefaultMiddleware());

describe('usersSlice', () => {
  const initialState = {
    entities: {},
    error: null,
    ids: [],
    status: Status.IDLE,
    meta: {}
  };
  const users = {
    '1': {
      id: 1,
      type: 'users',
      attributes: {
        firstName: 'Jeff',
        lastName: 'Bozo',
        email: 'jeff@bozo.com'
      }
    }
  };

  it('should return the initial state', () => {
    expect(reducer(undefined, {})).toEqual(initialState);
  });

  it('should handle fetchUsers/pending', () => {
    reducerPendingTest(reducer, initialState, 'users/index/pending');
  });

  it('should handle fetchUsers/fulfilled', () => {
    expect(
      reducer(initialState, {
        type: 'users/index/fulfilled',
        payload: {
          value: users,
          meta: {}
        }
      })
    ).toEqual({
      ...initialState,
      status: Status.SUCCEEDED,
      ids: [1],
      entities: users
    });
  });

  it('should handle fetchUsers/rejected', () => {
    reducerErrorTest(reducer, initialState, 'users/index/rejected');
  });

  describe('async actions', () => {
    afterEach(() => {
      fetchMock.restore();
    });

    it('populates the users from the fetchUsers request', async () => {
      fetchMock.get('/api/v1/users', {
        status: 200,
        body: {
          data: [users[1]]
        }
      });

      const expectedActions = [
        { type: 'users/index/pending', payload: undefined },
        { type: 'users/index/fulfilled', payload: { value: users } }
      ];

      const store = mockStore({
        auth: { token: 'fake token' },
        users: { entities: {}, ids: [] }
      });
      await store.dispatch(fetchUsers());

      const actions = store.getActions();
      actions.forEach(action => {
        delete action.meta;
      });
      expect(actions).toEqual(expectedActions);
    });

    it('tells you that you are unauthorized if you do not have a token', async () => {
      const error = 'some error';
      fetchMock.get('/api/v1/users', {
        status: 301,
        body: {
          errors: [{ detail: error }]
        }
      });

      const expectedActions = [
        { type: 'users/index/pending', payload: undefined },
        { type: 'users/index/rejected', payload: error, error: { message: 'Rejected'} }
      ];

      const store = mockStore({
        auth: { token: null },
        users: { entities: {}, ids: [] }
      });
      await store.dispatch(fetchUsers());

      const actions = store.getActions();
      actions.forEach(action => {
        delete action.meta;
      });
      expect(actions).toEqual(expectedActions);
    });
  })
});