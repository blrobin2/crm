import React from 'react';
import { render } from '@testing-library/react';

import { AppProvider } from './AppProvider';
import { NavBar } from './NavBar';

describe ('NavBar', () => {
  test('renders NavBar component', () => {
    render(
      <AppProvider>
        <NavBar />
      </AppProvider>
    );
  });
});
