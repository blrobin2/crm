import configureMockStore from 'redux-mock-store';
import fetchMock from 'fetch-mock-jest';
import { getDefaultMiddleware } from '@reduxjs/toolkit';

import reducer, { fetchTerritories } from './territoriesSlice';
import { reducerErrorTest, reducerPendingTest } from '../../app/reducerTestHelpers';
import { Status } from '../../app/status';

const mockStore = configureMockStore(getDefaultMiddleware());

describe('territoriesSlice', () => {
  const initialState = {
    entities: {},
    error: null,
    ids: [],
    status: Status.IDLE,
    meta: {}
  };

  const territories = {
    '1': {
      id: 1,
      type: 'territories',
      attributes: {
        name: 'Test',
        parentId: 2,
        childIds: [3, 4, 5]
      }
    }
  };

  it('should return the initial state', () => {
    expect(reducer(undefined, {})).toEqual(initialState);
  });

  it('should handle fetchTerritories/pending', () => {
    reducerPendingTest(reducer, initialState, 'territories/index/pending');
  });

  it('should handle fetchTerritories/fulfilled', () => {
    expect(
      reducer(initialState, {
        type: 'territories/index/fulfilled',
        payload: {
          value: territories,
          meta: {}
        }
      })
    ).toEqual({
      ...initialState,
      status: Status.SUCCEEDED,
      ids: [1],
      entities: territories
    });
  });

  it('should handle fetchTerritories/rejected', () => {
    reducerErrorTest(reducer, initialState, 'territories/index/rejected');
  });

  describe('async actions', () => {
    afterEach(() => {
      fetchMock.restore();
    });

    it('populates territories from the fetchTerritories request', async () => {
      fetchMock.get('/api/v1/territories?filter%5Btop_level%5D=true', {
        status: 200,
        body: {
          data: [territories[1]]
        }
      });

      const expectedActions = [
        { type: 'territories/index/pending', payload: undefined },
        { type: 'territories/index/fulfilled', payload: { value: territories } }
      ];

      const store = mockStore({
        auth: { token: 'fake token' },
        territories: { entities: {}, ids: [] }
      });
      await store.dispatch(fetchTerritories({}));

      const actions = store.getActions();
      actions.forEach(action => {
        delete action.meta;
      });
      expect(actions).toEqual(expectedActions);
    });

    it('tells you that you are unauthorized if you do not have a token', async () => {
      const error = 'some error';
      fetchMock.get('/api/v1/territories?filter%5Btop_level%5D=true', {
        status: 301,
        body: {
          errors: [{ detail: error }]
        }
      });

      const expectedActions = [
        { type: 'territories/index/pending', payload: undefined },
        { type: 'territories/index/rejected', payload: error, error: { message: 'Rejected' } }
      ];

      const store = mockStore({
        auth: { token: null },
        territories: { entities: {}, ids: [] }
      });
      await store.dispatch(fetchTerritories({}));

      const actions = store.getActions();
      actions.forEach(action => {
        delete action.meta;
      });
      expect(actions).toEqual(expectedActions);
    });
  });
});