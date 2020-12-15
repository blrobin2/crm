import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { EntityId } from '@reduxjs/toolkit';

import {
  fetchUsers,
  selectUserIds,
  selectUsersStatus,
  selectUsersError
} from './usersSlice';
import { Status } from '../../app/status';
import { UserListItem } from './UserListItem';

const UsersTable = ({ userIds } : { userIds: EntityId[] }) => {
  const content = userIds.map(userId => (
    <UserListItem key={userId} userId={userId} />
  ));
  return (
    <table className="table table-striped">
      <thead>
        <tr>
          <th>User ID</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Email</th>
        </tr>
      </thead>
      <tbody>
        {content}
      </tbody>
    </table>
  );
}

const UsersListLayout = ({ children }: { children: JSX.Element }) => (
  <section className="users-list">
    <h2>Users</h2>
    {children}
  </section>
);

export const UsersList = () => {
  const dispatch = useDispatch();
  const userIds: EntityId[] = useSelector(selectUserIds);
  const usersStatus = useSelector(selectUsersStatus);
  const usersError = useSelector(selectUsersError);

  useEffect(() => {
    if (usersStatus === Status.IDLE) dispatch(fetchUsers());
  }, [usersStatus, dispatch]);

  const content = (() => {
    switch (usersStatus) {
      case Status.LOADING:
        return <div className="loader">Loading&hellip;</div>;
      case Status.SUCCEEDED:
        return <UsersTable userIds={userIds} />
      case Status.FAILED:
        return <div className="alert alert-danger">{usersError}</div>;
      default:
        return <></>;
    }
  })();

  return <UsersListLayout>{content}</UsersListLayout>;
}
