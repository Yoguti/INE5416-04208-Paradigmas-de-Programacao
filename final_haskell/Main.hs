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
    
    -- Check if filename was provided
    if length args /= 1
        then putStrLn "Error. Usage: ./main <sudoku_file>"
        else do
            let filename = head args
            fileExists <- doesFileExist filename
            
            if not fileExists
                then putStrLn "Error opening file"
                else do
                    -- Read file content
                    content <- readFile filename
                    
                    -- Ask user for grid number
                    putStrLn "Select a grid sudoku_number: "
                    input <- getLine
                    let gridNum = read input :: Int
                    
                    -- Parse the grid
                    case parseGrid content gridNum of
                        Nothing -> putStrLn "Failed to parse the grid."
                        Just grid -> do
                            -- Print original grid
                            putStrLn "Original Grid:"
                            printGrid grid
                            
                            -- Solve the grid
                            case futoshiki grid of
                                Nothing -> putStrLn "\nNo solution found for this puzzle."
                                Just solution -> do
                                    putStrLn "\nSolution Found:"
                                    printGrid solution
                                    
                                    -- Print solution values in readable format
                                    putStrLn "\nSolution Values:"
                                    printSolutionValues solution

-- Helper function to check if a file exists
doesFileExist :: FilePath -> IO Bool
doesFileExist path = do
    result <- try (openFile path ReadMode) :: IO (Either IOError Handle)
    case result of
        Left _ -> return False
        Right handle -> do
            hClose handle
            return True

-- Helper function to print solution values in a readable format
printSolutionValues :: Grid -> IO ()
printSolutionValues grid = do
    let gridSize = size grid
    let gridCells = cells grid
    
    -- Print each row
    mapM_ printRow gridCells
  where
    printRow row = do
        -- Print each cell value in the row
        mapM_ (\cell -> putStr $ show (value cell) ++ " ") row
        putStrLn ""