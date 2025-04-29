module Main where

import System.Environment (getArgs)
import System.Exit (exitFailure)
import Parser (parseNthGrid, printGrid)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [filename, idStr] -> do
      content <- readFile filename
      let gridId = read idStr :: Int
      case parseNthGrid gridId content of
        Just (size, region, grid) -> printGrid size region grid
        Nothing -> do
          putStrLn $ "Erro: Grid #" ++ show gridId ++ " não encontrada ou mal formatada."
          exitFailure
    _ -> do
      putStrLn "Uso: ./sudoku <arquivo> <id da grid>"
      exitFailure
