import React from 'react';
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event'
import { act } from 'react-dom/test-utils';

import { renderTest, AppProvider } from '../../app/TestHelpers';
import { TerritoriesTree } from './TerritoriesTree';

describe('TerritoriesTree', () => {
  renderTest('TerritoriesTree', TerritoriesTree);

  it.skip('Figure out how to render children', async () => {
    const mockOnTerritoryClick = jest.fn(_dispatch => _stuff => { });
    render(
      <AppProvider>
        <TerritoriesTree
          onTerritoryClick={mockOnTerritoryClick}
        />
      </AppProvider>
    );

    await act(async () => {
      userEvent.click(screen.getByTestId('territory-node'));
    });
    expect(mockOnTerritoryClick).toHaveBeenCalledTimes(1);
  });

  it.skip('figure out how to simulate back button', async () => {
    const mockOnGoBackButtonClick = jest.fn((_dispatch, _parentChain, _setParentChain) => () => { });
    render(
      <AppProvider>
        <TerritoriesTree
          onGoBackButtonClick={mockOnGoBackButtonClick}
        />
      </AppProvider>
    );

    await act(async () => {
      userEvent.click(screen.getByTestId('back-button'));
    });
    expect(mockOnGoBackButtonClick).toHaveBeenCalledTimes(1);
  });
});
