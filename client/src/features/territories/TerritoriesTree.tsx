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
  selectCurrentParentId,
  fetchTerritories,
} from './territoriesSlice';
import { AppDispatch } from '../../app/store';
import { MetaState } from '../../app/apiHelpers';

import { TerritoryNode } from './TerritoryNode';
import { Pagination, OnPaginationPageChange } from '../../app/Pagination';

const BackButton = ({ onBackButtonClick }: { onBackButtonClick: () => void }) => (
  <button className="btn btn-info" onClick={onBackButtonClick}>&uarr; Back</button>
);

const handleTerritoryClick = (dispatch: AppDispatch, parentChain: string[], setParentChain: (arr: string[]) => void) =>
  (oldParentId: string, newParentId: string) => {
    setParentChain(parentChain.concat(oldParentId));
    dispatch(fetchTerritories({ parentId: parseInt(newParentId, 10) }));
};

const handleGoBackButtonClick = (dispatch: AppDispatch, parentChain: string[], setParentChain: (arr: string[]) => void) =>
  () => {
    setParentChain(parentChain.slice(0, -1));
    const id = parseInt(parentChain[parentChain.length - 1], 10);
    dispatch(fetchTerritories({ parentId: id }));
};

export const TerritoriesTree = ({
  onTerritoryClick = handleTerritoryClick,
  onGoBackButtonClick = handleGoBackButtonClick
}) => {
  const dispatch = useDispatch();
  const territoryIds: EntityId[] = useSelector(selectTerritoryIds);
  const territoriesStatus = useSelector(selectTerritoriesStatus);
  const territoriesError = useSelector(selectTerritoriesError);
  const meta: MetaState = useSelector(selectTerritoriesMeta);
  const currentParrentId = useSelector(selectCurrentParentId);
  const totalPages = meta.total_pages || 0;
  const currentPage = meta.current_page || 1;
  const totalCount = meta.total_count || 1;
  const [parentChain, setParentChain] = useState<string[]>([]);

  useEffect(() => {
    if (territoriesStatus === Status.IDLE) {
      dispatch(fetchTerritories({}));
    }
  }, [territoriesStatus, dispatch]);

  const handlePageChange: OnPaginationPageChange = ({ selected }) => {
    const pageNumber = selected + 1;
    dispatch(fetchTerritories({ parentId: currentParrentId, pageNumber }));
  };

  const content = (() => {
    switch (territoriesStatus) {
      case Status.LOADING:
        return <div className="loader">Loading&hellip;</div>;
      case Status.SUCCEEDED:
        return territoryIds.map(tId => (
          <TerritoryNode
            key={tId}
            territoryId={tId}
            onTerritoryClick={onTerritoryClick(dispatch, parentChain, setParentChain)}
          />
        ));
      case Status.FAILED:
        return <div className="alert alert-danger">{territoriesError}</div>;
      default:
        return <></>;
    }
  })();

  const backbuttonFn = onGoBackButtonClick(dispatch, parentChain, setParentChain);

  return (
    <section className="territories-tree">
      <h2>Territories {parentChain.length > 0 && <BackButton onBackButtonClick={backbuttonFn} />}</h2>
      <Pagination
        pageCount={totalPages}
        currentPage={currentPage}
        totalCount={totalCount}
        onPageChange={handlePageChange}
      />
      <ListGroup>
        {content}
      </ListGroup>
      <Pagination
        pageCount={totalPages}
        currentPage={currentPage}
        totalCount={totalCount}
        onPageChange={handlePageChange}
      />
    </section>
  );
};
