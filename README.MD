# 🧩 Solver de Comparison Sudoku

**algoritmo de retro‐propagação com backtracking** que resolve Sudokus de Comparação (aqueles com símbolos `<` e `>` entre as células).  
Ele restringe os valores possíveis já na leitura do tabuleiro, propaga comparações para reduzir domínios e, quando necessário, retrocede tentando novas escolhas — até encontrar (ou provar que não existe) solução.

> O mesmo algoritmo foi escrito em **Haskell** e em **C** para fins de estudo.

---

## 📄 Leituras recomendadas

| Tópico | Arquivo |
|--------|---------|
| Detalhes passo-a-passo do algoritmo (filtragem, escolha da célula, retrocesso) | [Algoritmo Comparison-Sudoku](algoritmos/comparison-sudoku-algo.MD) |
| Especificação do formato de arquivo usado para descrever o tabuleiro e os símbolos de comparação | [Formato de leitura](algoritmos/parsing-sudoku.md) |

---

## 📂 Estrutura do repositório (visão rápida)

    algoritmos/          ← documentos acima  
    c_implementation/    ← código em C 
    haskell_implementation/             ← código em Haskell  

Cada implementação lê um arquivo texto no formato descrito no *parsing-sudoku.md* e devolve a grade resolvida no console.
