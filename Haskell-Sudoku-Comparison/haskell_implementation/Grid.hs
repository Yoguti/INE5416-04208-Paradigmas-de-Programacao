module Grid (
    Grid(..),
    createGrid,
    isValidRow,
    isValidColumn,
    isValidRegions,
    setCell,
    getCell,
    getNeighbors,
    compareCardinals
) where

import Cell
import Data.List (transpose, nub)

-- Define o tipo Grid
data Grid = Grid
    { size :: Int               -- Tamanho da grade (NxN)
    , regionSize :: (Int, Int)  -- Tamanho das regiões (altura, largura)
    , cells :: [[Cell]]         -- Matriz de células
    }
    deriving (Show, Eq)

-- Cria uma nova grade vazia
createGrid :: Int -> (Int, Int) -> Grid
createGrid size regionSize = Grid size regionSize gridCells
  where
    emptyCell = createCell (None, None, None, None) 0
    -- replicate :: Int -> a -> [a], cria linhas e colunas preenchidas com células vazias
    gridCells = replicate size (replicate size emptyCell)

-- Verifica se os valores da linha são únicos (sem duplicatas e diferentes de 0)
isValidRow :: [Cell] -> Bool
isValidRow cells = 
    let values = filter (/= 0) $ map getValue cells -- Pega apenas os valores diferentes de 0
    in length values == length (nub values) -- Confere se não há duplicatas

-- Transpõe a grade e reutiliza isValidRow para verificar colunas
isValidColumn :: [[Cell]] -> [Bool]
isValidColumn grid = map isValidRow (transpose grid)

-- Divide a grade em regiões e verifica se cada uma tem valores únicos
isValidRegions :: [[Cell]] -> (Int, Int) -> [Bool]
isValidRegions grid (rH, rW) = 
    [ isValidRegion (getRegion y x) 
    | y <- [0, rH .. length grid - 1]
    , x <- [0, rW .. length (head grid) - 1]
    ]
  where
    -- Extrai uma região a partir da posição (startY, startX)
    getRegion startY startX =
        [ grid !! y !! x
        | y <- [startY .. startY + rH - 1]
        , x <- [startX .. startX + rW - 1]
        ]

    -- Verifica se a região não possui valores duplicados (exceto 0)
    isValidRegion region =
        let values = filter (/= 0) $ map getValue region
        in length values == length (nub values)

-- Retorna o número total de células da grade
getIntBoundry :: Grid -> Int
getIntBoundry (Grid _ (a, b) _) = a * b

-- Define o valor de uma célula específica na grade
setCell :: [[Cell]] -> Int -> Int -> Cell -> [[Cell]]
setCell grid row col newCellValue =
    if row >= 0 && row < length grid && col >= 0 && col < length (head grid)
    then take row grid ++ [take col (grid !! row) ++ [newCellValue] ++ drop (col + 1) (grid !! row)] ++ drop (row + 1) grid
    else grid  -- Retorna a grade original se os índices estiverem fora do intervalo

-- Acesso seguro a uma célula
getCell :: [[Cell]] -> Int -> Int -> Maybe Cell
getCell grid row col =
  if row >= 0 && row < length grid &&
     col >= 0 && col < length (head grid)
  then Just (grid !! row !! col)
  else Nothing

-- Retorna os vizinhos (direita, cima, esquerda, baixo) de uma célula
-- Ordem fixa para comparação com as restrições
getNeighbors :: [[Cell]] -> Int -> Int -> [Maybe Cell]
getNeighbors grid row col =
  let positions = [ (row, col + 1)    -- direita (0)
                  , (row - 1, col)    -- cima (1)
                  , (row, col - 1)    -- esquerda (2)
                  , (row + 1, col)    -- baixo (3)
                  ]
  in [ getCell grid r c | (r, c) <- positions ]

-- Compara as restrições da célula com os valores reais dos vizinhos
compareCardinals :: Grid -> Int -> Int -> Bool
compareCardinals grid row col =
    case getCell (cells grid) row col of
        Nothing -> False  -- Célula não existe
        Just cell -> 
            let cellValue = getValue cell
                (right, top, left, down) = comparisons cell
                n = size grid
            in
                -- Verifica a comparação à direita
                (col >= n - 1 || right == None || 
                    case getCell (cells grid) row (col + 1) of
                        Nothing -> True
                        Just rightCell -> 
                            let rightValue = getValue rightCell
                            in rightValue == 0 || 
                               (right == Greater && cellValue > rightValue) ||
                               (right == Less && cellValue < rightValue)) &&

                -- Verifica a comparação acima
                (row <= 0 || top == None || 
                    case getCell (cells grid) (row - 1) col of
                        Nothing -> True
                        Just topCell -> 
                            let topValue = getValue topCell
                            in topValue == 0 ||
                               (top == Greater && cellValue > topValue) ||
                               (top == Less && cellValue < topValue)) &&

                -- Verifica a comparação à esquerda
                (col <= 0 || left == None || 
                    case getCell (cells grid) row (col - 1) of
                        Nothing -> True
                        Just leftCell -> 
                            let leftValue = getValue leftCell
                            in leftValue == 0 ||
                               (left == Greater && cellValue > leftValue) ||
                               (left == Less && cellValue < leftValue)) &&

                -- Verifica a comparação abaixo
                (row >= n - 1 || down == None || 
                    case getCell (cells grid) (row + 1) col of
                        Nothing -> True
                        Just downCell -> 
                            let downValue = getValue downCell
                            in downValue == 0 ||
                               (down == Greater && cellValue > downValue) ||
                               (down == Less && cellValue < downValue)) &&

                -- Verifica se o vizinho à esquerda impõe restrição sobre esta célula
                (col <= 0 || 
                    case getCell (cells grid) row (col - 1) of
                        Nothing -> True
                        Just leftCell ->
                            let leftValue = getValue leftCell
                                (leftRight, _, _, _) = comparisons leftCell
                            in leftValue == 0 || leftRight == None ||
                               (leftRight == Greater && leftValue > cellValue) ||
                               (leftRight == Less && leftValue < cellValue)) &&

                -- Verifica se o vizinho acima impõe restrição sobre esta célula
                (row <= 0 || 
                    case getCell (cells grid) (row - 1) col of
                        Nothing -> True
                        Just topCell ->
                            let topValue = getValue topCell
                                (_, _, _, topDown) = comparisons topCell
                            in topValue == 0 || topDown == None ||
                               (topDown == Greater && topValue > cellValue) ||
                               (topDown == Less && topValue < cellValue)) &&

                -- Verifica se o vizinho à direita impõe restrição sobre esta célula
                (col >= n - 1 || 
                    case getCell (cells grid) row (col + 1) of
                        Nothing -> True
                        Just rightCell ->
                            let rightValue = getValue rightCell
                                (_, _, rightLeft, _) = comparisons rightCell
                            in rightValue == 0 || rightLeft == None ||
                               (rightLeft == Greater && rightValue > cellValue) ||
                               (rightLeft == Less && rightValue < cellValue)) &&

                -- Verifica se o vizinho abaixo impõe restrição sobre esta célula
                (row >= n - 1 || 
                    case getCell (cells grid) (row + 1) col of
                        Nothing -> True
                        Just downCell ->
                            let downValue = getValue downCell
                                (_, downTop, _, _) = comparisons downCell
                            in downValue == 0 || downTop == None ||
                               (downTop == Greater && downValue > cellValue) ||
                               (downTop == Less && downValue < cellValue))

-- Função auxiliar simplificada para verificar uma única comparação
checkNeighbor :: Int -> Comparison -> Maybe Cell -> Bool
checkNeighbor cellValue comp maybeNeighbor =
    case (comp, maybeNeighbor) of
        (None, _) -> True  -- Sem comparação necessária
        (_, Nothing) -> True  -- Sem vizinho na direção, comparação satisfeita
        (Greater, Just neighbor) -> 
            let neighborValue = getValue neighbor
            in neighborValue == 0 || cellValue > neighborValue  -- Permite células vazias
        (Less, Just neighbor) -> 
            let neighborValue = getValue neighbor
            in neighborValue == 0 || cellValue < neighborValue  -- Permite células vazias
