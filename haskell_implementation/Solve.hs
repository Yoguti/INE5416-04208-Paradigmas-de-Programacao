module Solve (
    solve,
    futoshiki
) where

import Grid
import Data.Maybe
import Cell

-- Gera todas as posições (linha, coluna) de uma grade n x n
positions :: Int -> [(Int, Int)]
positions n = [ (r, c) | r <- [0..n-1], c <- [0..n-1] ]

-- Função principal que resolve o problema da grade usando backtracking
solve :: Grid -> [(Int, Int)] -> [Int] -> Maybe Grid
solve grid [] _ = Just grid  -- Caso base: se não há mais posições para preencher, retorna a grade
solve grid ((row, col):rest) values =
    case getCell (cells grid) row col of
        Just cell ->
            if value cell /= 0
            then solve grid rest values  -- Se a célula já tem valor, pula para a próxima posição
            else tryValues values  -- Tenta preencher com os valores possíveis
          where
            tryValues [] = Nothing  -- Nenhum valor possível serve, deve retroceder (backtrack)
            tryValues (v:vs) =
                let newCell = setValue cell v  -- Define valor v na célula
                    newGridCells = setCell (cells grid) row col newCell  -- Atualiza a célula na grade
                    newGrid = grid { cells = newGridCells }  -- Cria nova grade atualizada
                    valid = and
                      [ isValidRow (newGridCells !! row)  -- Verifica se a linha é válida
                      , all id (isValidColumn newGridCells)  -- Verifica todas as colunas
                      , all id (isValidRegions newGridCells (regionSize grid))  -- Verifica regiões
                      , compareCardinals newGrid row col  -- Verifica restrições de desigualdade do Futoshiki
                      ]
                in if valid
                   then case solve newGrid rest values of
                          Just g -> Just g  -- Solução encontrada
                          Nothing -> tryValues vs  -- Tenta próximo valor (backtrack)
                   else tryValues vs  -- Valor inválido, tenta outro
        _ -> Nothing  -- Célula inválida (acesso fora da grade)

-- Função que inicia o processo de resolução do Futoshiki
futoshiki :: Grid -> Maybe Grid
futoshiki grid =
    let n = size grid  -- Obtém o tamanho da grade
        values = [1..n]  -- Lista de valores possíveis (ex: 1 a 4 para uma grade 4x4)
        pos = positions n  -- Todas as posições da grade
    in solve grid pos values  -- Chama o solver
