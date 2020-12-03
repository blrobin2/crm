import React from 'react';
import { Provider } from 'react-redux';
import { render } from '@testing-library/react';
import { ConnectedRouter as Router } from 'connected-react-router';

import { history, store } from './store';

export const AppProvider = ({ children }: React.PropsWithChildren<unknown>) => (
  <Provider store={store}>
    <Router history={history}>
      {children}
    </Router>
  </Provider>
);

export const renderTest = (componentName: string, MyComponent: (x: any) => JSX.Element) => {
  describe(componentName, () => {
    test(`renders ${componentName} component`, () => {
      render(
        <AppProvider>
          <MyComponent />
        </AppProvider>
      );
    });
  });
}