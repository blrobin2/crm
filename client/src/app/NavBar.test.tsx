import React from 'react';
import { render } from '@testing-library/react';
import { Provider } from 'react-redux';
import { ConnectedRouter as Router } from 'connected-react-router';

import { history, store } from './store';
import { NavBar } from './NavBar';

describe ('NavBar', () => {
  test('renders NavBar component', () => {
    render(
      <Provider store={store}>
        <Router history={history}>
          <NavBar />
        </Router>
      </Provider>
    );
  });
});
