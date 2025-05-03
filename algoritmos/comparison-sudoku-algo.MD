# Algoritmo de Resolução do Futoshiki (Sudoku de Comparação)

1. **Recebe a grade inicial** do Futoshiki com algumas células preenchidas e outras vazias.

2. **Gera todas as posições (linha, coluna)** da grade.

3. Para cada posição da lista:
   - Se a célula já estiver preenchida, **pula para a próxima posição**.
   - Se estiver vazia:
     - Tenta preencher com todos os **valores possíveis** (de 1 até N, onde N é o tamanho da grade).
     - Para cada valor tentado:
       - Coloca o valor na célula.
       - Verifica se a grade continua **válida**:
         - Linha não possui repetições.
         - Colunas estão corretas.
         - Regiões (se houver) seguem as regras.
         - Restrições de desigualdade (>, <) são respeitadas.
       - Se a grade ainda for válida:
         - Continua tentando preencher o restante da grade (chamada recursiva).
         - Se resolver, **retorna a solução**.
         - Se não resolver, **volta atrás** (backtrack) e tenta outro valor.
     - Se nenhum valor for válido, **retorna para posição anterior** (mais uma etapa de backtracking).

4. Quando todas as posições forem preenchidas corretamente, retorna a grade como solução final.

5. Se nenhuma combinação for válida, retorna "nenhuma solução possível".
