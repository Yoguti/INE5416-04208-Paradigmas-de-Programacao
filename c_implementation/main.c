#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "grid.h"

int destroyGrid(Grid* grid) {
    if (!grid) {
        perror("Erro ao iniciar grid object");
        return -1;  // Return -1 if grid is NULL
    }

    // Free each row of the grid
    for (int i = 0; i < grid->size; i++) {
        if (grid->grid[i]) {
            free(grid->grid[i]);  // Free the memory allocated for each row
        } else {
            perror("Erro ao liberar grid->grid[i]");
            return -1;
        }
    }

    if (grid->grid) {
        free(grid->grid);  // Free the memory allocated for the grid array
    } else {
        perror("Erro ao liberar grid->grid");
        return -1;
    }

    if (grid) {
        free(grid);  // Free the memory allocated for the Grid structure
    } else {
        perror("Erro ao liberar grid");
        return -1;
    }

    return 0;
}


Grid* initializeGrid(int size) {
    Grid* grid = malloc(sizeof(Grid));
    if (!grid) {
        perror("Erro ao iniciar grid object");
        return NULL;
    }

    grid->size = size;
    grid->grid = malloc(grid->size * sizeof(Cell*));
    if (!grid->grid) {
        perror("Erro ao iniciar grid->grid");
        free(grid);
        return NULL;
    }

    for (int i = 0; i < grid->size; i++) {
        grid->grid[i] = malloc(grid->size * sizeof(Cell));
        if (!grid->grid[i]) {
            perror("Erro ao iniciar grid->grid[i]");
            // Cleanup previously allocated rows
            for (int j = 0; j < i; j++) free(grid->grid[j]);
            free(grid->grid);
            free(grid);
            return NULL;
        }

        // Initialize all cells
        for (int j = 0; j < grid->size; j++) {
            grid->grid[i][j].value = 0;
            for (int k = 0; k < 4; k++) {
                grid->grid[i][j].comparisons[k] = '-';
            }
        }
    }

    return grid;
}

Grid* parseGrid(FILE *file, char c) {
    Grid* grid = NULL;

    char line[100];
    int signal;

    // Read SIZE line
    while (fgets(line, sizeof(line), file)) {
        if (strncmp(line, "SIZE:", 5) == 0) {
            int size;
            sscanf(line, "SIZE: %d", &size);  // read just the first number before 'X'
            grid = initializeGrid(size); // INITIALIZE GRID OBJECT
            if (!grid) return NULL;
            grid->id = c - '0'; // setting grid id (came from the first parse call)
            break;
        }
    }

    // Read REGION_SIZE line
    while (fgets(line, sizeof(line), file)) {
        if (strncmp(line, "REGION_SIZE:", 12) == 0) {
            int r, c;
            sscanf(line, "REGION_SIZE: %dX%d", &r, &c);
            grid->region_rows = r;
            grid->region_cols = c;
            break;
        }
    }

    //POPULATING THE CELLS
    while (fgets(line, sizeof(line), file)) {
        if (strncmp(line, "BEGIN", 5) == 0) {
            // Now read the lines containing 4-tuples until "END"
            int row = 0;
            
            while (fgets(line, sizeof(line), file) && strncmp(line, "END", 3) != 0) {
                if (row >= grid->size) {
                    fprintf(stderr, "Error: Too many rows in the grid data\n");
                    destroyGrid(grid);
                    return NULL;
                }
                
                // Parse the line, which contains 4-tuples separated by commas
                char *token = strtok(line, ",");
                int col = 0;
                
                while (token != NULL && col < grid->size) {
                    // Each token is a 4-tuple like "<--<"
                    if (strlen(token) >= 4) {
                        // Store the comparison characters if they're not '-'
                        if (token[0] != '-') grid->grid[row][col].comparisons[0] = token[0]; // Right
                        if (token[1] != '-') grid->grid[row][col].comparisons[1] = token[1]; // Up
                        if (token[2] != '-') grid->grid[row][col].comparisons[2] = token[2]; // Left
                        if (token[3] != '-') grid->grid[row][col].comparisons[3] = token[3]; // Down
                    }
                    
                    token = strtok(NULL, ",");
                    col++;
                }
                
                // Check if we have enough columns
                if (col < grid->size) {
                    fprintf(stderr, "Error: Not enough columns in row %d\n", row);
                    destroyGrid(grid);
                    return NULL;
                }
                
                row++;
            }
            
            // Check if we have enough rows
            if (row < grid->size) {
                fprintf(stderr, "Error: Not enough rows in the grid data\n");
                destroyGrid(grid);
                return NULL;
            }
            
            break; // We've finished parsing the grid
        }
    }

    return grid;
}


int main(int argc, char *argv[]) {
    Grid* grid;

    if (argc != 2) {
        printf("Erro. Uso: %s <sudoku_file> \n", argv[0]);
    }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Erro ao abrir o arquivo");
        return EXIT_FAILURE;
    }

    int check = 0;
    int sudoku_number;
    
    while (!check) {
        printf("Select a grid sudoku_number: ");
        if (scanf("%d", &sudoku_number) != 1) {
            while (getchar() != '\n'); // clean buffer
            printf("Input inválido. Tente novamente: \n");
        } else {
            check = 1;
        }
    }

    int c;
    while ((c = fgetc(file)) != EOF) {
        if (c == '#') {
            c = fgetc(file);  // get the number after #
            if (c - '0' == sudoku_number) {
                grid = parseGrid(file, c);  // we found our section, go parse it (continues at the same parsed point)
                break;
            }
        }
    }

    printf("grid ID: %d\n", grid->id);
    printf("grid SIZE: %dx%d\n", grid->size, grid->size);
    printf("grid REGION SIZE: %dx%d\n", grid->region_rows, grid->region_cols);

    
    return 0;
}