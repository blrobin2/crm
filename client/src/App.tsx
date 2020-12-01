import React from 'react';
import { Switch, Route } from 'react-router-dom';
import { ConnectedRouter as Router } from 'connected-react-router';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

import { history } from './app/store';
import { NotFound } from './app/NotFound';
import { NavBar } from './app/NavBar';
import { ProtectedRoute } from './app/ProtectedRoute';

import { UsersList } from './features/users/UsersList';
import { SignInForm } from './features/auth/SignInForm';

function App() {
  return (
    <Router history={history}>
      <Container>
        <Row>
          <NavBar />
        </Row>
        <Row>
          <Col>
            <Switch>
              <Route exact path='/sign-in' component={SignInForm} />
              <ProtectedRoute exact path='/users' component={UsersList} />
              <Route component={NotFound} />
            </Switch>
          </Col>
        </Row>
      </Container>
    </Router>
  );
}

export default App;
