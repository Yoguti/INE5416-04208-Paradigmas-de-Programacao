#include "parsing.c"
#include "solve.c"

int main(int argc, char *argv[]) {
    Grid* grid;

    if (argc != 2) {
        printf("Erro. Uso: %s <sudoku_file> \n", argv[0]);
        return EXIT_FAILURE;
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
            while (getchar() != '\n'); // limpa o buffer
            printf("Input inválido. Tente novamente: \n");
        } else {
            check = 1;
        }
    }

    int c;
    while ((c = fgetc(file)) != EOF) {
        if (c == '#') {
            c = fgetc(file);  // obtém o número após #
            if (c - '0' == sudoku_number) {
                grid = parseGrid(file, c);  // encontramos nossa seção, vamos analisá-la (continua no mesmo ponto analisado)
                break;
            }
        }
    }
    
    fclose(file);
    
    if (!grid) {
        printf("Falha ao analisar o grid.\n");
        return EXIT_FAILURE;
    }
    
    printf("Original Grid:\n");
    printGrid(grid);
    
    Grid* solution = solve(grid);
    
    if (solution) {
        printf("\nSolution Found:\n");
        printGrid(solution);
        
        // Imprime os valores da solução em um formato mais legível
        printf("\nSolution Values:\n");
        for (int i = 0; i < solution->size; i++) {
            for (int j = 0; j < solution->size; j++) {
                printf("%2d ", solution->grid[i][j].value);
            }
            printf("\n");
        }
        
        // Libera o grid de solução primeiro
        destroyGrid(solution);
    } else {
        printf("\nNo solution found for this puzzle.\n");
    }
    
    // Libera o grid original
    destroyGrid(grid);
    
    return 0;
}