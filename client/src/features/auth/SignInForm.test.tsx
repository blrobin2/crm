import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event'
import { act } from 'react-dom/test-utils';

import { renderTest, AppProvider } from '../../app/TestHelpers';
import { SignInForm } from './SignInForm'

describe('SignInForm', () => {
  renderTest('SignInForm', SignInForm)

  it('submits the inputted values', async () => {
    const mockHandleFormSubmit = jest.fn(_dispatch => (_stuff, _obj) => Promise.resolve());
    render(
      <AppProvider>
        <SignInForm handleFormSubmit={mockHandleFormSubmit} />
      </AppProvider>
    );

    await act(async () => {
      userEvent.type(screen.getByLabelText(/email/i), 'some@email.com');
      userEvent.type(screen.getByLabelText(/password/i), 'password');
      userEvent.click(screen.getByText(/submit/i));
    });
    expect(mockHandleFormSubmit).toHaveBeenCalledTimes(1);
  });
});
