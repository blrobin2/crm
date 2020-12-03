import React from 'react';
import { Provider } from 'react-redux';
import { ConnectedRouter as Router } from 'connected-react-router';

import { history, store } from './store';

export const AppProvider = ({ children }) => (
  <Provider store={store}>
    <Router history={history}>
      {children}
    </Router>
  </Provider>
);
