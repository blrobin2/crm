import React from 'react';
import { EntityId } from '@reduxjs/toolkit';
import { useSelector } from 'react-redux';
import ListGroup from 'react-bootstrap/ListGroup';

import { RootState } from '../../app/store';
import { selectTerritoryById } from './territoriesSlice';

interface TerritoryNodeParams {
  territoryId: EntityId;
  onTerritoryClick: (oldParentId: string, newParentId: string) => void;
}

export const TerritoryNode = ({ territoryId, onTerritoryClick }: TerritoryNodeParams) => {
  const territory = useSelector((state: RootState) => selectTerritoryById(state, territoryId));
  if (!territory) {
    return (
      <></>
    );
  }

  const eventKey = territoryId.toString();
  const parentId = territory.attributes.parentId?.toString();
  const content = (() => {
    if (territory.attributes.childIds.length > 0) {
      return (
        <div className="row">
          <div className="col">
            <button onClick={() => onTerritoryClick(parentId || '', eventKey)} className="btn btn-link" data-testid="territory-node">
              {territory.attributes.name}
            </button>
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