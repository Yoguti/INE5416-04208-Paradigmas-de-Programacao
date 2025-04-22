      
#ifndef CELL_H
#define CELL_H

// Definimos que comparisons[4] armazena as 4 restrições:
// comparisons[0]: Direita
// comparisons[1]: Acima
// comparisons[2]: Esquerda
// comparisons[3]: Abaixo
typedef struct cell
{
    int value; // Valor numérico (para a solução, inicialmente 0 ou algum valor de 'vazio')
    char comparisons[4]; // Armazena os caracteres '>', '<', ou '-' para os 4 vizinhos
} Cell;


#endif //CELL_H

    