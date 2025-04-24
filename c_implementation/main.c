#include "parsing.c"


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
    printGrid(grid);
    
    return 0;
}
