module Main where

import System.Environment (getArgs)
import Control.Exception (try, IOException)
import System.IO
import Parse
import Cell
import Grid
import Solve

main :: IO ()
main = do
    args <- getArgs
    
    -- Verifica se o nome do arquivo foi fornecido
    if length args /= 1
        then putStrLn "Erro. Uso: ./main <arquivo_sudoku>"
        else do
            let filename = head args
            fileExists <- doesFileExist filename
            
            -- Verifica se o arquivo existe
            if not fileExists
                then putStrLn "Erro ao abrir o arquivo"
                else do
                    -- Lê o conteúdo do arquivo
                    content <- readFile filename
                    
                    -- Pergunta ao usuário qual número de grade deseja
                    putStrLn "Selecione um número de grade sudoku: "
                    input <- getLine
                    let gridNum = read input :: Int
                    
                    -- Faz o parsing da grade
                    case parseGrid content gridNum of
                        Nothing -> putStrLn "Falha ao analisar a grade."
                        Just grid -> do
                            -- Imprime a grade original
                            putStrLn "Grade Original:"
                            printGrid grid
                            
                            -- Resolve a grade
                            case futoshiki grid of
                                Nothing -> putStrLn "\nNenhuma solução encontrada para este quebra-cabeça."
                                Just solution -> do
                                    putStrLn "\nSolução Encontrada:"
                                    printGrid solution
                                    
                                    -- Imprime os valores da solução de forma legível
                                    putStrLn "\nValores da Solução:"
                                    printSolutionValues solution

-- Função auxiliar para verificar se o arquivo existe
doesFileExist :: FilePath -> IO Bool
doesFileExist path = do
    result <- try (openFile path ReadMode) :: IO (Either IOError Handle)
    case result of
        Left _ -> return False
        Right handle -> do
            hClose handle
            return True

-- Função auxiliar para imprimir os valores da solução de forma legível
printSolutionValues :: Grid -> IO ()
printSolutionValues grid = do
    let gridSize = size grid
    let gridCells = cells grid
    
    -- Imprime cada linha
    mapM_ printRow gridCells
  where
    printRow row = do
        -- Imprime o valor de cada célula na linha
        mapM_ (\cell -> putStr $ show (value cell) ++ " ") row
        putStrLn ""
