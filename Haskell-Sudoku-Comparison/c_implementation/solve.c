#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "grid.h"

// Verifica se colocar 'value' em grid[row][col] viola alguma regra do Sudoku
bool isValid(Grid* grid, int row, int col, int value) {
    int n = grid->size;
    int regionRows = grid->region_rows;
    int regionCols = grid->region_cols;
    
    // Verifica linha
    for (int j = 0; j < n; j++) {
        if (grid->grid[row][j].value == value) {
            return false;
        }
    }
    
    // Verifica coluna
    for (int i = 0; i < n; i++) {
        if (grid->grid[i][col].value == value) {
            return false;
        }
    }
    
    // Verifica região
    int startRow = (row / regionRows) * regionRows;
    int startCol = (col / regionCols) * regionCols;
    
    for (int i = 0; i < regionRows; i++) {
        for (int j = 0; j < regionCols; j++) {
            if (grid->grid[startRow + i][startCol + j].value == value) {
                return false;
            }
        }
    }
    
    return true;
}

// Verifica se colocar 'value' em grid[row][col] viola alguma restrição de comparação
bool satisfiesComparisons(Grid* grid, int row, int col, int value) {
    int n = grid->size;
    Cell* cell = &grid->grid[row][col];
    
    // Verifica comparação à direita
    if (col < n - 1 && cell->comparisons[0] != '-') {
        int rightValue = grid->grid[row][col + 1].value;
        if (rightValue != 0) { // Se a célula à direita tem um valor
            if (cell->comparisons[0] == '<' && value >= rightValue) {
                return false;
            }
            if (cell->comparisons[0] == '>' && value <= rightValue) {
                return false;
            }
        }
    }
    
    // Verifica comparação à esquerda
    if (col > 0 && grid->grid[row][col - 1].comparisons[0] != '-') {
        int leftValue = grid->grid[row][col - 1].value;
        if (leftValue != 0) { // Se a célula à esquerda tem um valor
            if (grid->grid[row][col - 1].comparisons[0] == '<' && leftValue >= value) {
                return false;
            }
            if (grid->grid[row][col - 1].comparisons[0] == '>' && leftValue <= value) {
                return false;
            }
        }
    }
    
    // Verifica comparação abaixo
    if (row < n - 1 && cell->comparisons[3] != '-') {
        int downValue = grid->grid[row + 1][col].value;
        if (downValue != 0) { // Se a célula abaixo tem um valor
            if (cell->comparisons[3] == '<' && value >= downValue) {
                return false;
            }
            if (cell->comparisons[3] == '>' && value <= downValue) {
                return false;
            }
        }
    }
    
    // Verifica comparação acima
    if (row > 0 && grid->grid[row - 1][col].comparisons[3] != '-') {
        int upValue = grid->grid[row - 1][col].value;
        if (upValue != 0) { // Se a célula acima tem um valor
            if (grid->grid[row - 1][col].comparisons[3] == '<' && upValue >= value) {
                return false;
            }
            if (grid->grid[row - 1][col].comparisons[3] == '>' && upValue <= value) {
                return false;
            }
        }
    }
    
    return true;
}

// Encontra uma célula vazia
bool findEmptyCell(Grid* grid, int* row, int* col) {
    int n = grid->size;
    
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid->grid[i][j].value == 0) {
                *row = i;
                *col = j;
                return true;
            }
        }
    }
    
    return false; // Nenhuma célula vazia encontrada
}

// Solucionador recursivo com backtracking
bool solveBacktrack(Grid* grid) {
    int row, col;
    
    // Se nenhuma célula vazia for encontrada, o quebra-cabeça está resolvido
    if (!findEmptyCell(grid, &row, &col)) {
        return true;
    }
    
    // Tenta cada valor possível
    for (int value = 1; value <= grid->size; value++) {
        // Verifica se o valor é válido para esta célula
        if (isValid(grid, row, col, value) && satisfiesComparisons(grid, row, col, value)) {
            // Coloca o valor
            grid->grid[row][col].value = value;
            
            // Tenta resolver o resto do quebra-cabeça recursivamente
            if (solveBacktrack(grid)) {
                return true;
            }
            
            // Se chegamos aqui, este valor não funcionou, então voltamos atrás
            grid->grid[row][col].value = 0;
        }
    }
    
    // Nenhuma solução encontrada com qualquer valor
    return false;
}

// Cria uma cópia profunda do grid
Grid* copyGrid(Grid* original) {
    if (!original) return NULL;
    
    Grid* copy = malloc(sizeof(Grid));
    if (!copy) return NULL;
    
    copy->id = original->id;
    copy->size = original->size;
    copy->region_rows = original->region_rows;
    copy->region_cols = original->region_cols;
    
    copy->grid = malloc(copy->size * sizeof(Cell*));
    if (!copy->grid) {
        free(copy);
        return NULL;
    }
    
    for (int i = 0; i < copy->size; i++) {
        copy->grid[i] = malloc(copy->size * sizeof(Cell));
        if (!copy->grid[i]) {
            // Limpa a memória alocada anteriormente
            for (int j = 0; j < i; j++) {
                free(copy->grid[j]);
            }
            free(copy->grid);
            free(copy);
            return NULL;
        }
        
        // Copia cada célula
        for (int j = 0; j < copy->size; j++) {
            copy->grid[i][j] = original->grid[i][j];
        }
    }
    
    return copy;
}

// Função principal de resolução
Grid* solve(Grid* grid) {
    if (!grid) return NULL;
    
    // Cria uma cópia profunda do grid para trabalhar
    Grid* workGrid = copyGrid(grid);
    if (!workGrid) return NULL;
    
    // Resolve o quebra-cabeça
    bool solved = solveBacktrack(workGrid);
    
    if (!solved) {
        // Libera memória se nenhuma solução for encontrada
        destroyGrid(workGrid);
        return NULL;
    }
    
    return workGrid;
}