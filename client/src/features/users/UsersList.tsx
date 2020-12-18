import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { EntityId } from '@reduxjs/toolkit';

import {
  fetchUsers,
  selectUserIds,
  selectUsersStatus,
  selectUsersError,
  selectUsersMeta
} from './usersSlice';
import { Status } from '../../app/status';
import { Pagination, OnPaginationPageChange, withPageChange } from '../../app/Pagination';
import { UserListItem } from './UserListItem';
import { MetaState } from '../../app/apiHelpers';

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

const UsersListLayout = ({ children, onPageChange }: { children: JSX.Element, onPageChange: OnPaginationPageChange }) => {
  const meta: MetaState = useSelector(selectUsersMeta);
  const totalPages = meta.total_pages || 0;
  const currentPage = meta.current_page || 1;
  const totalCount = meta.total_count || 1;

  return (
    <section className="users-list">
      <h2>Users</h2>
      <Pagination
        pageCount={totalPages}
        currentPage={currentPage}
        totalCount={totalCount}
        onPageChange={onPageChange}
      />
      {children}
      <Pagination
        pageCount={totalPages}
        currentPage={currentPage}
        totalCount={totalCount}
        onPageChange={onPageChange}
      />
    </section>
  );
};

export const UsersList = () => {
  const dispatch = useDispatch();
  const userIds: EntityId[] = useSelector(selectUserIds);
  const usersStatus = useSelector(selectUsersStatus);
  const usersError = useSelector(selectUsersError);

  useEffect(() => {
    if (usersStatus === Status.IDLE) dispatch(fetchUsers(1));
  }, [usersStatus, dispatch]);

  const handlePageChange: OnPaginationPageChange =
    withPageChange(pageNumber => dispatch(fetchUsers(pageNumber)));

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

  return <UsersListLayout onPageChange={handlePageChange}>{content}</UsersListLayout>;
}
