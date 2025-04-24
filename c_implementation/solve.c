#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "grid.h"

// Structure to represent a set of possibilities for a cell
typedef struct {
    bool values[10]; // For a 9x9 grid, we need values 1-9 (index 0 is unused)
    int count;       // Number of possibilities
} PossibilitySet;

// Structure to track the state for backtracking
typedef struct {
    int row;
    int col;
    int value;
} Assignment;

// Initialize a possibility set with all values from 1 to n
void initPossibilitySet(PossibilitySet* set, int n) {
    memset(set->values, true, sizeof(set->values));
    set->values[0] = false; // 0 is not a valid value
    set->count = n;
}

// Remove a value from a possibility set
bool removeValue(PossibilitySet* set, int value) {
    if (value <= 0 || !set->values[value]) return false;
    
    set->values[value] = false;
    set->count--;
    return true;
}

// Get the smallest value in the set
int getMinValue(PossibilitySet* set) {
    for (int i = 1; i < 10; i++) {
        if (set->values[i]) return i;
    }
    return 0; // Empty set
}

// Get the largest value in the set
int getMaxValue(PossibilitySet* set) {
    for (int i = 9; i >= 1; i--) {
        if (set->values[i]) return i;
    }
    return 0; // Empty set
}

// Find the cell with the smallest non-empty possibility set
bool findMostConstrainedCell(Grid* grid, PossibilitySet** possibilities, int* row, int* col) {
    int minCount = 10; // More than maximum possible
    bool found = false;
    
    for (int i = 0; i < grid->size; i++) {
        for (int j = 0; j < grid->size; j++) {
            if (grid->grid[i][j].value == 0 && possibilities[i * grid->size + j]->count > 0 && 
                possibilities[i * grid->size + j]->count < minCount) {
                minCount = possibilities[i * grid->size + j]->count;
                *row = i;
                *col = j;
                found = true;
            }
        }
    }
    
    return found;
}

// Check if all cells are assigned
bool isComplete(Grid* grid) {
    for (int i = 0; i < grid->size; i++) {
        for (int j = 0; j < grid->size; j++) {
            if (grid->grid[i][j].value == 0) return false;
        }
    }
    return true;
}

// Apply comparison constraints between cells
bool applyComparisonConstraints(Grid* grid, PossibilitySet** possibilities) {
    bool changed = false;
    
    for (int i = 0; i < grid->size; i++) {
        for (int j = 0; j < grid->size; j++) {
            Cell* cell = &grid->grid[i][j];
            
            // Right comparison
            if (j < grid->size - 1 && cell->comparisons[0] != '-') {
                int neighborIdx = i * grid->size + (j + 1);
                int currentIdx = i * grid->size + j;
                
                if (cell->comparisons[0] == '<') {
                    // Current cell < Right cell
                    int maxRight = getMaxValue(possibilities[neighborIdx]);
                    for (int val = maxRight; val <= grid->size; val++) {
                        if (removeValue(possibilities[currentIdx], val)) changed = true;
                    }
                    
                    int minCurrent = getMinValue(possibilities[currentIdx]);
                    for (int val = 1; val <= minCurrent; val++) {
                        if (removeValue(possibilities[neighborIdx], val)) changed = true;
                    }
                } else if (cell->comparisons[0] == '>') {
                    // Current cell > Right cell
                    int minRight = getMinValue(possibilities[neighborIdx]);
                    for (int val = 1; val <= minRight; val++) {
                        if (removeValue(possibilities[currentIdx], val)) changed = true;
                    }
                    
                    int maxCurrent = getMaxValue(possibilities[currentIdx]);
                    for (int val = maxCurrent; val <= grid->size; val++) {
                        if (removeValue(possibilities[neighborIdx], val)) changed = true;
                    }
                }
            }
            
            // Down comparison
            if (i < grid->size - 1 && cell->comparisons[3] != '-') {
                int neighborIdx = (i + 1) * grid->size + j;
                int currentIdx = i * grid->size + j;
                
                if (cell->comparisons[3] == '<') {
                    // Current cell < Down cell
                    int maxDown = getMaxValue(possibilities[neighborIdx]);
                    for (int val = maxDown; val <= grid->size; val++) {
                        if (removeValue(possibilities[currentIdx], val)) changed = true;
                    }
                    
                    int minCurrent = getMinValue(possibilities[currentIdx]);
                    for (int val = 1; val <= minCurrent; val++) {
                        if (removeValue(possibilities[neighborIdx], val)) changed = true;
                    }
                } else if (cell->comparisons[3] == '>') {
                    // Current cell > Down cell
                    int minDown = getMinValue(possibilities[neighborIdx]);
                    for (int val = 1; val <= minDown; val++) {
                        if (removeValue(possibilities[currentIdx], val)) changed = true;
                    }
                    
                    int maxCurrent = getMaxValue(possibilities[currentIdx]);
                    for (int val = maxCurrent; val <= grid->size; val++) {
                        if (removeValue(possibilities[neighborIdx], val)) changed = true;
                    }
                }
            }
        }
    }
    
    return changed;
}

// Update possibilities after assigning a value
bool updatePossibilities(Grid* grid, PossibilitySet** possibilities, int row, int col, int value) {
    int n = grid->size;
    int regionRow = grid->region_rows;
    int regionCol = grid->region_cols;
    
    // Remove the value from the same row
    for (int j = 0; j < n; j++) {
        if (j != col) {
            int idx = row * n + j;
            removeValue(possibilities[idx], value);
            if (possibilities[idx]->count == 0 && grid->grid[row][j].value == 0) {
                return false; // Contradiction
            }
        }
    }
    
    // Remove the value from the same column
    for (int i = 0; i < n; i++) {
        if (i != row) {
            int idx = i * n + col;
            removeValue(possibilities[idx], value);
            if (possibilities[idx]->count == 0 && grid->grid[i][col].value == 0) {
                return false; // Contradiction
            }
        }
    }
    
    // Remove the value from the same region
    int regionStartRow = (row / regionRow) * regionRow;
    int regionStartCol = (col / regionCol) * regionCol;
    
    for (int i = 0; i < regionRow; i++) {
        for (int j = 0; j < regionCol; j++) {
            int r = regionStartRow + i;
            int c = regionStartCol + j;
            if (r != row || c != col) {
                int idx = r * n + c;
                removeValue(possibilities[idx], value);
                if (possibilities[idx]->count == 0 && grid->grid[r][c].value == 0) {
                    return false; // Contradiction
                }
            }
        }
    }
    
    // Apply comparison constraints
    Cell* cell = &grid->grid[row][col];
    
    // Right comparison
    if (col < n - 1 && cell->comparisons[0] != '-') {
        int neighborIdx = row * n + (col + 1);
        if (cell->comparisons[0] == '<') {
            // Current cell < Right cell
            for (int val = 1; val <= value; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        } else if (cell->comparisons[0] == '>') {
            // Current cell > Right cell
            for (int val = value; val <= n; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        }
        if (possibilities[neighborIdx]->count == 0 && grid->grid[row][col+1].value == 0) {
            return false; // Contradiction
        }
    }
    
    // Left comparison
    if (col > 0 && grid->grid[row][col-1].comparisons[0] != '-') {
        int neighborIdx = row * n + (col - 1);
        if (grid->grid[row][col-1].comparisons[0] == '<') {
            // Left cell < Current cell
            for (int val = value; val <= n; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        } else if (grid->grid[row][col-1].comparisons[0] == '>') {
            // Left cell > Current cell
            for (int val = 1; val <= value; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        }
        if (possibilities[neighborIdx]->count == 0 && grid->grid[row][col-1].value == 0) {
            return false; // Contradiction
        }
    }
    
    // Down comparison
    if (row < n - 1 && cell->comparisons[3] != '-') {
        int neighborIdx = (row + 1) * n + col;
        if (cell->comparisons[3] == '<') {
            // Current cell < Down cell
            for (int val = 1; val <= value; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        } else if (cell->comparisons[3] == '>') {
            // Current cell > Down cell
            for (int val = value; val <= n; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        }
        if (possibilities[neighborIdx]->count == 0 && grid->grid[row+1][col].value == 0) {
            return false; // Contradiction
        }
    }
    
    // Up comparison
    if (row > 0 && grid->grid[row-1][col].comparisons[3] != '-') {
        int neighborIdx = (row - 1) * n + col;
        if (grid->grid[row-1][col].comparisons[3] == '<') {
            // Up cell < Current cell
            for (int val = value; val <= n; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        } else if (grid->grid[row-1][col].comparisons[3] == '>') {
            // Up cell > Current cell
            for (int val = 1; val <= value; val++) {
                removeValue(possibilities[neighborIdx], val);
            }
        }
        if (possibilities[neighborIdx]->count == 0 && grid->grid[row-1][col].value == 0) {
            return false; // Contradiction
        }
    }
    
    return true;
}

// Recursive backtracking solver
bool solveBacktrack(Grid* grid, PossibilitySet** possibilities, Assignment* assignments, int assignmentCount) {
    if (isComplete(grid)) {
        return true;
    }
    
    int row, col;
    if (!findMostConstrainedCell(grid, possibilities, &row, &col)) {
        return false; // No valid cell found
    }
    
    int idx = row * grid->size + col;
    PossibilitySet* currentSet = possibilities[idx];
    
    // Try each possible value
    for (int val = 1; val <= grid->size; val++) {
        if (currentSet->values[val]) {
            // Save current state for backtracking
            PossibilitySet** savedPossibilities = malloc(grid->size * grid->size * sizeof(PossibilitySet*));
            for (int i = 0; i < grid->size * grid->size; i++) {
                savedPossibilities[i] = malloc(sizeof(PossibilitySet));
                memcpy(savedPossibilities[i], possibilities[i], sizeof(PossibilitySet));
            }
            
            // Assign the value
            grid->grid[row][col].value = val;
            
            // Update possibilities
            if (updatePossibilities(grid, possibilities, row, col, val)) {
                assignments[assignmentCount].row = row;
                assignments[assignmentCount].col = col;
                assignments[assignmentCount].value = val;
                
                if (solveBacktrack(grid, possibilities, assignments, assignmentCount + 1)) {
                    // Free saved possibilities
                    for (int i = 0; i < grid->size * grid->size; i++) {
                        free(savedPossibilities[i]);
                    }
                    free(savedPossibilities);
                    return true;
                }
            }
            
            // Backtrack
            grid->grid[row][col].value = 0;
            
            // Restore possibilities
            for (int i = 0; i < grid->size * grid->size; i++) {
                memcpy(possibilities[i], savedPossibilities[i], sizeof(PossibilitySet));
                free(savedPossibilities[i]);
            }
            free(savedPossibilities);
        }
    }
    
    return false;
}

// Main solve function
Grid* solve(Grid* grid) {
    if (!grid) return NULL;
    
    int n = grid->size;
    
    // Initialize possibility sets for each cell
    PossibilitySet** possibilities = malloc(n * n * sizeof(PossibilitySet*));
    for (int i = 0; i < n * n; i++) {
        possibilities[i] = malloc(sizeof(PossibilitySet));
        initPossibilitySet(possibilities[i], n);
    }
    
    // Pre-processing: Apply comparison constraints until no more changes
    bool changed;
    do {
        changed = applyComparisonConstraints(grid, possibilities);
    } while (changed);
    
    // Allocate memory for tracking assignments
    Assignment* assignments = malloc(n * n * sizeof(Assignment));
    
    // Solve using backtracking
    bool solved = solveBacktrack(grid, possibilities, assignments, 0);
    
    // Free memory
    for (int i = 0; i < n * n; i++) {
        free(possibilities[i]);
    }
    free(possibilities);
    free(assignments);
    
    return solved ? grid : NULL;
}