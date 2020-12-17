import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useParams } from 'react-router';
import { EntityId } from '@reduxjs/toolkit';
import ListGroup from 'react-bootstrap/ListGroup';

import { Status } from '../../app/status';
import {
  selectTerritoryIds,
  selectTerritoriesStatus,
  selectTerritoriesError,
  fetchTerritories
} from './territoriesSlice';
import { TerritoryNode } from './TerritoryNode';

export const TerritoriesTree = () => {
  const dispatch = useDispatch();
  const territoryIds: EntityId[] = useSelector(selectTerritoryIds);
  const territoriesStatus = useSelector(selectTerritoriesStatus);
  const territoriesError = useSelector(selectTerritoriesError);
  const { parentId } = useParams();

  useEffect(() => {
    if (territoriesStatus === Status.IDLE) {
      dispatch(fetchTerritories({
        parentId: parentId ? parseInt(parentId, 10) : undefined
      }));
    }
  }, [territoriesStatus, dispatch, parentId]);

  const content = (() => {
    switch (territoriesStatus) {
      case Status.LOADING:
        return <div className="loader">Loading&hellip;</div>;
      case Status.SUCCEEDED:
        return territoryIds.map(tId => (
          <TerritoryNode key={tId} territoryId={tId} />
        ));
      case Status.FAILED:
        return <div className="alert alert-danger">{territoriesError}</div>;
      default:
        return <></>;
    }
  })();

  return (
    <>
      <h2>Territories</h2>
      <ListGroup>
        {content}
      </ListGroup>
    </>
  )
};
