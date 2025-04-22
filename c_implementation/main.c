#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cell.h"

void free_grid(Cell **grid, int size) {
    if (grid == NULL) return;
    for (int i = 0; i < size; i++) {
        free(grid[i]);
    }
    free(grid);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Erro. Uso: %s <sudoku_file> \n", argv[0]);
    }

    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror("Erro ao abrir o arquivo");
        return EXIT_FAILURE;
    }

    int check = 0;
    int number;
    
    while (!check) {
        printf("Select a grid number: ");
        if (scanf("%d", &number) != 1) {
            while (getchar() != '\n'); // limpar buffer
            printf("Input inválido. Tente novamente: \n");
        } else {
            check = 1;
        }
    }
    


    
    return 0;
}