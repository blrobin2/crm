import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { EntityId } from '@reduxjs/toolkit';
import ListGroup from 'react-bootstrap/ListGroup';

import { Status } from '../../app/status';
import {
  selectTerritoryIds,
  selectTerritoriesStatus,
  selectTerritoriesError,
  selectTerritoriesMeta,
  selectTerritoryParentId,
  fetchTerritories,
} from './territoriesSlice';
import { AppDispatch } from '../../app/store';
import { MetaState } from '../../app/apiHelpers';

import { TerritoryNode } from './TerritoryNode';
import { Pagination, OnPaginationPageChange, withPageChange } from '../../app/Pagination';

const handleTerritoryClick = (dispatch: AppDispatch, parentChain: string[], setParentChain: (arr: string[]) => void) =>
  (oldParentId: string, newParentId: string) => {
    setParentChain(parentChain.concat(oldParentId));
    dispatch(fetchTerritories({ parentId: parseInt(newParentId, 10) }));
};

const popLastIdFromParentChain = (parentChain: string[], setParentChain: (arr: string[]) => void): number => {
  setParentChain(parentChain.slice(0, -1));
  return parseInt(parentChain[parentChain.length - 1], 10);
}

const handleGoBackButtonClick = (dispatch: AppDispatch, parentChain: string[], setParentChain: (arr: string[]) => void) =>
  () => {
    const parentId = popLastIdFromParentChain(parentChain, setParentChain);
    dispatch(fetchTerritories({ parentId }));
};

const renderTerritoryNode = (territoryId: EntityId, onTerritoryClick: (oldParentId: string, newParentId: string) => void) => (
  <TerritoryNode
    key={territoryId}
    territoryId={territoryId}
    onTerritoryClick={onTerritoryClick}
  />
);

const BackButton = ({ onBackButtonClick }: { onBackButtonClick: () => void }) => (
  <button className="btn btn-info" onClick={onBackButtonClick}>&uarr; Back</button>
);

interface TerritoriesTreeLayoutParams {
  children: JSX.Element | JSX.Element[];
  onPageChange: (parentId: number) => OnPaginationPageChange;
  showBackButton: boolean;
  onBackButtonClick: () => void
}

const TerritoriesTreeLayout = ({
  children,
  onPageChange,
  showBackButton,
  onBackButtonClick
}: TerritoriesTreeLayoutParams) => {
  const meta: MetaState = useSelector(selectTerritoriesMeta);
  const currentTerritoryId = useSelector(selectTerritoryParentId);
  const totalPages = meta.total_pages || 0;
  const currentPage = meta.current_page || 1;
  const totalCount = meta.total_count || 1;

  return (
    <section className="territories-tree">
      <h2>Territories {showBackButton && <BackButton onBackButtonClick={onBackButtonClick} />}</h2>
      <Pagination
        pageCount={totalPages}
        currentPage={currentPage}
        totalCount={totalCount}
        onPageChange={onPageChange(currentTerritoryId)}
      />
      <ListGroup>
        {children}
      </ListGroup>
      <Pagination
        pageCount={totalPages}
        currentPage={currentPage}
        totalCount={totalCount}
        onPageChange={onPageChange(currentTerritoryId)}
      />
    </section>
  );
}

export const TerritoriesTree = ({
  onTerritoryClick = handleTerritoryClick,
  onGoBackButtonClick = handleGoBackButtonClick
}) => {
  const dispatch = useDispatch();
  const territoryIds: EntityId[] = useSelector(selectTerritoryIds);
  const territoriesStatus = useSelector(selectTerritoriesStatus);
  const territoriesError = useSelector(selectTerritoriesError);
  const [parentChain, setParentChain] = useState<string[]>([]);

  useEffect(() => {
    if (territoriesStatus === Status.IDLE) {
      dispatch(fetchTerritories({}));
    }
  }, [territoriesStatus, dispatch]);

  const handlePageChange: (parentId: number) => OnPaginationPageChange = parentId =>
    withPageChange((pageNumber: number) => dispatch(fetchTerritories({ parentId, pageNumber })));

  const content = (() => {
    switch (territoriesStatus) {
      case Status.LOADING:
        return <div className="loader">Loading&hellip;</div>;
      case Status.SUCCEEDED: {
        const onClick = onTerritoryClick(dispatch, parentChain, setParentChain);
        return territoryIds.map(tId => renderTerritoryNode(tId, onClick));
      }
      case Status.FAILED:
        return <div className="alert alert-danger">{territoriesError}</div>;
      default:
        return <></>;
    }
  })();

  return (
    <TerritoriesTreeLayout
      onPageChange={handlePageChange}
      onBackButtonClick={onGoBackButtonClick(dispatch, parentChain, setParentChain)}
      showBackButton={parentChain.length > 0}
    >
      {content}
    </TerritoriesTreeLayout>
  );
};
