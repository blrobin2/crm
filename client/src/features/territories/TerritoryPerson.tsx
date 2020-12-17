import React from 'react';
import { useSelector } from 'react-redux';
import { EntityId } from '@reduxjs/toolkit';

import { RootState } from '../../app/store';
import { selectUserById } from '../users/usersSlice';

interface TerritoryPersonParams {
  userId: EntityId;
}

export const TerritoryPerson = ({ userId }: TerritoryPersonParams) => {
  const person = useSelector((state: RootState) => selectUserById(state, userId));

  if (!person) {
    return <></>;
  }

  return (
    <>
      {person.attributes.firstName} {person.attributes.lastName}
    </>
  )
}