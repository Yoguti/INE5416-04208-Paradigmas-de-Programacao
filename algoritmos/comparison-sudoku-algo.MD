# Algoritmo Sudoku com Comparações

## Inicialização
1. Calcule o intervalo `n = largura_região × altura_região` (por exemplo, 3×3 = 9).  
2. Crie uma grade vazia de tamanho `n × n`.  
3. Para cada célula na grade, crie um **conjunto de possibilidades** contendo todos os valores de **1** até **n**.  
4. Crie vetores de controle para **linhas**, **colunas** e **regiões** a fim de monitorar os valores já utilizados.  

## Pré‑processamento
5. Para cada símbolo de comparação presente na grade:  
   - Se a célula **A < B**, remova do conjunto de possibilidades de **A** todos os valores **≥** ao **maior valor possível** em **B**.  
   - Se a célula **A > B**, remova do conjunto de possibilidades de **A** todos os valores **≤** ao **menor valor possível** em **B**.  
6. Repita o passo 5 até que não ocorram mais reduções em nenhum conjunto de possibilidades.  

## Loop Principal de Resolução
7. Encontre a célula com o **menor** conjunto de possibilidades **não vazio**.  
   - Se todas as células estiverem atribuídas (tamanho do conjunto = 1 para todas), vá para o passo 14.  
8. Caso alguma célula tenha conjunto de possibilidades **vazio**, retroceda (vá para o passo 12).  
9. Selecione o **primeiro valor** do conjunto de possibilidades da célula atual e atribua‑o à célula.  
10. Atualize os vetores de controle da **linha**, **coluna** e **região** correspondentes.  
11. Para cada célula afetada por essa atribuição (mesma linha, coluna, região ou ligada por símbolo de comparação):  
    - Remova o valor atribuído de seus conjuntos de possibilidades.  
    - Se a célula atribuída possuir símbolo **\<** com um vizinho, remova do vizinho todos os valores **≥** ao valor atribuído.  
    - Se possuir símbolo **\>**, remova do vizinho todos os valores **≤** ao valor atribuído.  
    - Se algum conjunto ficar vazio, vá para o passo 12 (retrocesso).  
    - Se algum conjunto reduzir‑se a **um único valor**, considere‑o atribuído e repita o passo 11 para essa célula.  
    - Se não ocorrer contradição, retorne ao passo 7 para processar a próxima célula.  

## Retrocesso (Backtracking)
12. Desfaça a atribuição atual da célula e **restaure** todos os conjuntos de possibilidades ao estado anterior.  
13. Se o conjunto da célula ainda possuir valores não tentados:  
    - Remova o último valor testado do conjunto.  
    - Retorne ao passo 9 para tentar o próximo valor.  
    - Caso não restem valores no conjunto, retroceda para a célula atribuída anterior (repita o passo 12).  
    - Se não houver célula anterior para retroceder, o quebra‑cabeça **não possui solução**. Saia.  

## Encerramento
14. Verifique se a solução satisfaz **todas** as restrições de Sudoku e os relacionamentos de comparação.  
15. Devolva a grade completa como solução.  
