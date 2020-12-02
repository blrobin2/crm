import React from 'react'
import { Formik, Form, Field, ErrorMessage, FormikHelpers } from 'formik';
import { useDispatch, useSelector } from 'react-redux';
import { unwrapResult } from '@reduxjs/toolkit';
import { push } from 'connected-react-router';
import Alert from 'react-bootstrap/Alert';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

import { AppDispatch } from '../../app/store';
import { login, selectAuthError } from './authSlice';

type SignInFormFields = {
  email: string;
  password: string;
}

type SignInValidationFields = Partial<SignInFormFields>;

const onFormSubmit = (dispatch: AppDispatch) => async (
  values: SignInFormFields,
  { setSubmitting }: FormikHelpers<SignInFormFields>
) => {
  try {
    const resultAction = await dispatch(login(values));
    unwrapResult(resultAction);
    dispatch(push('/'));
  } catch (err) {
    console.error(err);
  } finally {
    setSubmitting(false);
  }
};

type FormGroupArgs = {
  id: string;
  type: string;
  name: string;
  autoComplete?: string;
}

const FormGroup = ({ id, name, autoComplete, type = 'text' }: FormGroupArgs) => (
  <div className="form-group">
    <label htmlFor={id}>{name}</label>
    <Field type={type} name={id} id={id} autoComplete={autoComplete} className="form-control" />
    <ErrorMessage name={id} component="div" className="text-danger" />
  </div>
);

export const SignInForm = ({ handleFormSubmit = onFormSubmit }) => {
  const dispatch = useDispatch()
  const authError = useSelector(selectAuthError);

  const formValidation = (values: SignInValidationFields) => {
    const errors: SignInValidationFields = {};
    if (!values.email) {
      errors.email = 'Email Required';
    }
    if (!values.password) {
      errors.password = 'Password Required';
    }
    return errors;
  }

  return (
  <Row>
    <Col md={{ span: 6, offset: 3 }}>
      <h1>Sign In</h1>
      {authError && <Alert variant='danger'>{authError}</Alert>}
      <Formik
        initialValues={{ email: '', password: '' }}
        validate={formValidation}
        onSubmit={handleFormSubmit(dispatch)}
      >
        {({ isSubmitting }) => (
          <Form className="form">
            <FormGroup id="email" type="email" name="Email" autoComplete="username" />
            <FormGroup id="password" type="password" name="Password" autoComplete="current-password" />
            <button type="submit" disabled={isSubmitting} className="btn btn-success">
              Submit
            </button>
          </Form>
        )}
      </Formik>
    </Col>
  </Row>
  )
}