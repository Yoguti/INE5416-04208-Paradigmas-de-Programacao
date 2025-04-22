#ifndef GRID_H
#define GRID_H

#include "cell.h"

typedef struct {
    int id;
    int size;
    int region_rows;
    int region_cols;
    Cell** grid;  // Array 2D de Cells
} Grid;

#endif // GRID_H