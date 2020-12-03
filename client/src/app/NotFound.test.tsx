import React from 'react';
import { render } from '@testing-library/react';
import { AppProvider } from './AppProvider';

import { NotFound } from './NotFound';

describe('NotFound', () => {
  test('renders NotFound component', () => {
    render(
      <AppProvider>
        <NotFound />
      </AppProvider>
    );
  });
});
