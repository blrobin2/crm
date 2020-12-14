import React from 'react';
import { EntityId } from '@reduxjs/toolkit';
import { useSelector } from 'react-redux';

import { RootState } from '../../app/store'
import { selectUserById } from './usersSlice';

export const UserListItem = ({ userId }: { userId: EntityId }) => {
  const user = useSelector((state: RootState) => selectUserById(state, userId));

  if (!user) {
    return (
      <></>
    );
  }

  return (
    <tr className="user-list-item">
      <td>{userId}</td>
      <td>{user.attributes.firstName}</td>
      <td>{user.attributes.lastName}</td>
      <td><a href={`mailto:${user.attributes.email}`}>{user.attributes.email}</a></td>
    </tr>
  )
}