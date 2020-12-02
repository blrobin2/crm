import configureMockStore from 'redux-mock-store';
import fetchMock from 'fetch-mock-jest';
import { getDefaultMiddleware } from '@reduxjs/toolkit';
import reducer, { login, logout } from './authSlice';
import { Status } from '../../app/status';

const mockStore = configureMockStore(getDefaultMiddleware())

describe('authSlice', () => {
  describe('reducer', () => {
    const initialState = {
      token: null,
      status: Status.IDLE,
      error: null
    };

    it('should return the initial state', () => {
      expect(reducer(undefined, {})).toEqual(initialState);
    });

    it('should handle login/pending', () => {
      expect(
        reducer(initialState, {
          type: 'auth/login/pending'
        })
      ).toEqual({
        token: null,
        status: Status.LOADING,
        error: null
      });
    });

    it('should handle login/fulfilled', () => {
      const token = 'some_token';
      expect(
        reducer(initialState, {
          type: 'auth/login/fulfilled',
          payload: token
        })
      ).toEqual({
        token: token,
        status: Status.SUCCEEDED,
        error: null
      });
    });

    it('should handle login/rejected', () => {
      const error = new Error('Some Error');
      expect(
        reducer(initialState, {
          type: 'auth/login/rejected',
          payload: error
        })
      ).toEqual({
        token: null,
        status: Status.FAILED,
        error: error
      });
    });

    it('should handle logout/pending', () => {
      expect(
        reducer({
          token: 'some_token',
          status: Status.IDLE,
          error: null
        }, {
          type: 'auth/logout/pending'
        })
      ).toEqual({
        token: 'some_token',
        status: Status.LOADING,
        error: null
      });
    });

    it('should handle logout/fulfilled', () => {
      expect(
        reducer({
          token: 'some_token',
          status: Status.IDLE,
          error: null
        }, {
          type: 'auth/logout/fulfilled'
        })
      ).toEqual({
        token: null,
        status: Status.SUCCEEDED,
        error: null
      });
    });

    it('should handle logout/rejected', () => {
      const error = new Error('Some Error');
      expect(
        reducer({
          token: 'some_token',
          status: Status.IDLE,
          error: null
        }, {
          type: 'auth/logout/rejected',
          payload: error
        })
      ).toEqual({
        token: 'some_token',
        status: Status.FAILED,
        error: error
      });
    });
  });

  describe('async actions', () => {
    afterEach(() => {
      fetchMock.restore();
    });
    it('adds a token to the store when you successfully log in', async () => {
      const token = 'some_token';
      fetchMock.post('/api/v1/sessions', {
        headers: {
          'authorization': token
        },
        body: {},
        status: 201
      });

      const expectedActions = [
        { type: 'auth/login/pending', payload: undefined },
        { type: 'auth/login/fulfilled', payload: token }
      ];

      const store = mockStore({ auth: { token: null } });
      await store.dispatch(login({ email: 'doesnt matter', password: 'not real' }));

      const actions = store.getActions();
      actions.forEach(action => {
        delete action.meta;
      });
      expect(actions).toEqual(expectedActions);
    });

    it('yells at you when you pass invalid credentials', async () => {
      const error = 'some error'
      fetchMock.post('/api/v1/sessions', {
        status: 400,
        body: {
          errors: [{ detail: error }]
        }
      });

      const expectedActions = [
        { type: 'auth/login/pending', payload: undefined },
        { type: 'auth/login/rejected', payload: error, error: { message: 'Rejected' } }
      ];

      const store = mockStore({ auth: { token: null } });
      await store.dispatch(login({ email: 'doesnt matter', password: 'not real' }));
      const actions = store.getActions();
      actions.forEach(action => {
        delete action.meta;
      });
      expect(actions).toEqual(expectedActions);
    })

    it('removes a token when you log out', async () => {
      fetchMock.delete('/api/v1/sessions', 204);

      const expectedActions = [
        { type: 'auth/logout/pending', payload: undefined },
        { type: 'auth/logout/fulfilled', payload: undefined }
      ];

      const store = mockStore({ auth: { token: 'something' } });
      await store.dispatch(logout())

      const actions = store.getActions();
      actions.forEach(action => {
        delete action.meta;
      });
      expect(actions).toEqual(expectedActions);
    });
  });
});

