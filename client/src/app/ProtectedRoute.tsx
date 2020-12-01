import React from 'react';
import { useSelector } from 'react-redux';
import { Route, Redirect, RouteProps } from 'react-router-dom';

import { selectAuthToken } from '../features/auth/authSlice';

export const ProtectedRoute = (props: RouteProps) => {
  const authToken = useSelector(selectAuthToken);
  const { component: Component, ...rest } = props;

  if (!Component) {
    throw new Error('Must pass component to Protected Route');
  }

  return (
    <Route {...rest} render={(props) => (
      !!authToken ? <Component {...props} /> : <Redirect to="/sign-in" />
    )} />
  )
}
