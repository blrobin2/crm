import React from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { unwrapResult } from '@reduxjs/toolkit';
import BNavBar from 'react-bootstrap/Navbar';
import { Link } from 'react-router-dom';
import { push } from 'connected-react-router';
import { selectAuthToken, logout } from '../features/auth/authSlice';
import { AppDispatch } from './store';


export const NavBar = () => {
  const dispatch: AppDispatch = useDispatch();
  const authToken = useSelector(selectAuthToken);

  const onLogoutButtonClick = async () => {
    try {
      const resultAction = await dispatch(logout())
      unwrapResult(resultAction)
      dispatch(push('/'))
    } catch (err) {
      console.error(err);
    }
  }

  const authenticatedNav = () => {
    if (!authToken) {
      return (<Link to="/sign-in" className="nav-link">Sign In</Link>);
    }

    return (
      <>
        <Link to="/users" className="nav-link">Users</Link>
        <button className="btn btn-sm btn-info" onClick={onLogoutButtonClick}>Logout</button>
      </>
    )
  }

  return (
    <BNavBar bg="light" expand="md">
      <BNavBar.Brand href="/">CRM</BNavBar.Brand>
      <BNavBar.Toggle aria-controls="navbar-nav" />
      <BNavBar.Collapse id="navbar-nav">
        {authenticatedNav()}
      </BNavBar.Collapse>
    </BNavBar>
  )
}