import React from 'react';
import { EntityId } from '@reduxjs/toolkit';
import { useSelector } from 'react-redux';
import ListGroup from 'react-bootstrap/ListGroup';
import { Link } from 'react-router-dom';

import { RootState } from '../../app/store';
import { selectTerritoryById } from './territoriesSlice';

interface TerritoryNodeParams {
  territoryId: EntityId;
}

export const TerritoryNode = ({ territoryId }: TerritoryNodeParams) => {
  const territory = useSelector((state: RootState) => selectTerritoryById(state, territoryId));
  if (!territory) {
    return (
      <></>
    );
  }

  const eventKey = territoryId.toString();
  const content = (() => {
    if (territory.attributes.childIds.length > 0) {
      return (
        <div className="row">
          <div className="col">
            <Link to={`/territories/${eventKey}`}>
              {territory.attributes.name}
            </Link>
          </div>
        </div>
      );
    }
    return <span>{territory.attributes.name}</span>
  })();

  return (
    <ListGroup.Item>
      {content}
    </ListGroup.Item>
  );
}