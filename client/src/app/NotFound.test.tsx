import React from 'react';
import { render } from '@testing-library/react';
import { Provider } from 'react-redux';
import { ConnectedRouter as Router } from 'connected-react-router';

import { history, store } from './store';
import { NotFound } from './NotFound';

describe('NotFound', () => {
  test('renders NotFound component', () => {
    render(
      <Provider store={store}>
        <Router history={history}>
          <NotFound />
        </Router>
      </Provider>
    );
  });
});
