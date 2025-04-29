# Algoritmo Simplificado de Sudoku com Comparações

## Inicialização
1. Identifique o tamanho do quebra-cabeça `n × m` (por exemplo, 9×9 para Sudoku padrão).
2. Crie uma cópia da grade original para trabalhar sem modificar a entrada.
3. Identifique as dimensões das regiões (por exemplo, 3×3 para Sudoku padrão).
4. Prepare a estrutura para armazenar os símbolos de comparação entre células adjacentes (`<`, `>` ou `-`).

## Processo de Resolução
5. Procure uma célula vazia na grade.
   - Se não houver células vazias, o quebra-cabeça está resolvido. Vá para o passo 10.
6. Para cada valor possível de **1** até **n**:
   - Verifique se o valor respeita as regras básicas do Sudoku:
     - O valor não pode se repetir na mesma linha.
     - O valor não pode se repetir na mesma coluna.
     - O valor não pode se repetir na mesma região.
   - Verifique se o valor respeita as restrições de comparação:
     - Se a célula atual tem símbolo **<** com a célula à direita, o valor deve ser menor que o valor da célula à direita (se já preenchida).
     - Se a célula atual tem símbolo **>** com a célula à direita, o valor deve ser maior que o valor da célula à direita (se já preenchida).
     - Verifique as mesmas condições para as células à esquerda, acima e abaixo.
   - Se o valor for válido, coloque-o na célula vazia e continue para o próximo passo.
   - Se nenhum valor for válido, vá para o passo 8 (retrocesso).
7. Avance recursivamente para a próxima célula vazia (volte ao passo 5).
   - Se a recursão retornar sucesso, mantenha o valor e continue.
   - Se a recursão retornar falha, tente o próximo valor possível.

## Retrocesso (Backtracking)
8. Se nenhum valor válido for encontrado para a célula atual, ou se a recursão falhar para todos os valores:
   - Limpe a célula atual (defina seu valor como 0).
   - Retorne à célula anterior (retroceda).
9. Se todas as possibilidades foram esgotadas e não foi possível encontrar uma solução, o quebra-cabeça não tem solução.

## Encerramento
10. Verifique se a solução encontrada satisfaz todas as restrições do Sudoku e os símbolos de comparação.
11. Retorne a grade preenchida como solução.

## Explicação em Linguagem Comum

Este algoritmo resolve o Sudoku com comparações usando uma abordagem de "tentativa e erro" sistemática chamada backtracking (retrocesso). Funciona assim:

1. **Encontre um espaço vazio**: O algoritmo procura uma célula vazia no quebra-cabeça.

2. **Tente um número**: Para cada célula vazia, o algoritmo tenta colocar um número de 1 até n.

3. **Verifique se o número é válido**: Antes de confirmar o número, o algoritmo verifica:
   - Se o número já existe na mesma linha, coluna ou região (regras básicas do Sudoku).
   - Se o número respeita os símbolos de comparação (`<` ou `>`) com as células vizinhas.

4. **Avance ou retroceda**:
   - Se o número for válido, o algoritmo avança para a próxima célula vazia.
   - Se nenhum número for válido, ou se uma escolha anterior levou a um beco sem saída, o algoritmo "desfaz" a última escolha e tenta outro número.

5. **Repita até resolver**: O processo continua até que todas as células estejam preenchidas corretamente ou até que se determine que não há solução.

A beleza deste método é sua simplicidade. Ele não requer estruturas de dados complexas ou pré-processamento elaborado. O algoritmo simplesmente tenta valores, verifica se funcionam, e muda de direção quando necessário até encontrar a solução.