import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event'
import { act } from 'react-dom/test-utils';
import { Provider } from 'react-redux';
import { ConnectedRouter as Router } from 'connected-react-router';

import { history, store } from '../../app/store';
import { SignInForm } from './SignInForm'

describe('SignInForm', () => {
  it('renders SignInForm component', () => {
    render(
      <Provider store={store}>
        <Router history={history}>
          <SignInForm />
        </Router>
      </Provider>
    );
  });

  it('submits the inputted values', async () => {
    const mockHandleFormSubmit = jest.fn(_dispatch => _stuff => {});
    render(
      <Provider store={store}>
        <Router history={history}>
          <SignInForm handleFormSubmit={mockHandleFormSubmit} />
        </Router>
      </Provider>
    );

    await act(async () => {
      userEvent.type(screen.getByLabelText(/email/i), 'some@email.com');
      userEvent.type(screen.getByLabelText(/password/i), 'password');
      userEvent.click(screen.getByText(/submit/i));
    });
    expect(mockHandleFormSubmit).toHaveBeenCalledTimes(1);
  });
});
