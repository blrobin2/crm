import React from 'react';
import { useParams } from 'react-router';
import { useSelector, useDispatch } from 'react-redux';
import { push } from 'connected-react-router';

import {
  selectTerritoryById
} from './territoriesSlice';
import { RootState } from '../../app/store';

export const ManageTerritory = () => {
  const dispatch = useDispatch();
  const { territoryId } = useParams();
  const territory = useSelector((state: RootState) => selectTerritoryById(state, territoryId));

  if (!territory) {
    dispatch(push('/territories'));
    return <></>;
  }

  return (
    <h1>{territory.attributes.name} User Assignments</h1>
  );
};
