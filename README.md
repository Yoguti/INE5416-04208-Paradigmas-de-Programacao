# 📄 Formato de Arquivo - Comparison Sudoku

Este formato de arquivo serve para **descrever Sudokus de Comparação** (Comparison Sudoku), indicando o **tamanho da grade**, as **regras de regiões** e onde ficam os **símbolos de comparação** (como `<`, `>`, `-`).

---

## 🔹 Cabeçalho (3 primeiras linhas de cada sudoku individual no arquivo)

1. **`#ID`**: Um número que **identifica** aquela grid.  
   Exemplo: `#ID: 1`

2. **`N`**: O **tamanho da grid**.  
   Exemplo: uma grade 6x6 tem `N=6` e usa números de **1 a 6**.

3. **`TIPO_REGIAO`**: Diz como a grid está **dividida em regiões**, o que é importante para a regra do Sudoku (cada número aparece **uma vez por região**).

   Exemplos:
   - `STANDARD_3X3` → Sudoku 9x9 com blocos 3x3.
   - `STANDARD_2X2` → Sudoku 4x4 com blocos 2x2.
   - Outros formatos podem existir, como `REGIAO_3X2` para blocos 3x2 em um 6x6.

---

## 🔸 Símbolos de Comparação

Cada célula pode ter **símbolos ao redor**, mostrando comparações com as células vizinhas.

- **Ordem dos símbolos (em cada célula)**:
  1. Direita
  2. Acima
  3. Esquerda
  4. Abaixo

- **Regras obrigatórias para bordas da grid**:
  - Célula na **primeira coluna**: o **3º símbolo (esquerda)** **deve ser** `-`.
  - Célula na **última coluna**: o **1º símbolo (direita)** **deve ser** `-`.
  - Célula na **primeira linha**: o **2º símbolo (acima)** **deve ser** `-`.
  - Célula na **última linha**: o **4º símbolo (abaixo)** **deve ser** `-`.
  - Célula na **última coluna de uma região**: o **1º símbolo (direita)** **deve ser** `-`.
  - Célula na **primeira coluna de uma região**: o **3º símbolo (esquerda)** **deve ser** `-`.  
  

---

## 📌 Exemplo com N = 4 e regiões 2x2

#1
SIZE:4 (represents 4x4)
REGION_SIZE: 2x2

>-->,--<>,<--<,--><,
><--,-<<-,<>--,->>-,
<--<,-->>,<--<,-->>,
>>--,-<<-,>>--,-<<-,

