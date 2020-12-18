import React from 'react';
import ReactPaginate from 'react-paginate';

export type OnPaginationPageChange = ({ selected }: { selected: number }) => void;

interface PaginationParams {
  pageCount: number;
  currentPage: number;
  totalCount: number;
  onPageChange: OnPaginationPageChange;
}

export const withPageChange = (cb: (pageNumber: number) => void) => ({ selected }: { selected: number }) => {
  const pageNumber = selected + 1;
  cb(pageNumber);
};

export const Pagination = ({ pageCount, currentPage, totalCount, onPageChange }: PaginationParams) => {
  const pageIndex = currentPage - 1;

  return (
    <>
      <p className="text-center">{totalCount} Record{totalCount === 1 ? '' : 's'}</p>
      <ReactPaginate
        pageCount={pageCount}
        pageRangeDisplayed={5}
        marginPagesDisplayed={2}
        onPageChange={onPageChange}
        forcePage={pageIndex}
        breakLabel="&hellip;"
        containerClassName={'pagination justify-content-center'}
        pageClassName={'page-item'}
        previousClassName={'page-item'}
        nextClassName={'page-item'}
        pageLinkClassName={'page-link'}
        previousLinkClassName={'page-link'}
        nextLinkClassName={'page-link'}
        activeClassName={'active'}
      />
    </>
  )
}