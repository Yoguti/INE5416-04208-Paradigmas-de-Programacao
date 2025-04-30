module Solve (solve) where

import Cell
import Grid
import Data.Maybe (isJust, fromJust)

-- Main solve function that takes a grid and returns the solved grid (if possible)
solve :: Grid -> Maybe Grid
solve grid = solveGrid grid

-- The main recursive backtracking function
solveGrid :: Grid -> Maybe Grid
solveGrid grid = 
    case findEmptyCell grid of
        Nothing -> Just grid  -- No empty cells, grid is solved
        Just (row, col) -> tryValues grid row col [1..size grid]

-- Try each possible value for a given cell
tryValues :: Grid -> Int -> Int -> [Int] -> Maybe Grid
tryValues _ _ _ [] = Nothing  -- No valid values found
tryValues grid row col (val:vals) = 
    let newCell = createCell (getComparisons grid row col) val
        newGrid = Grid (size grid) (regionSize grid) (setCell (cells grid) row col newCell)
    in if isValidPlacement newGrid row col
       then case solveGrid newGrid of
                Just solvedGrid -> Just solvedGrid  -- Solution found
                Nothing -> tryValues grid row col vals  -- Try next value
       else tryValues grid row col vals  -- Current value invalid, try next

-- Find the first empty cell (value = 0)
findEmptyCell :: Grid -> Maybe (Int, Int)
findEmptyCell grid = 
    let gridCells = cells grid
        indices = [(r, c) | r <- [0..size grid - 1], c <- [0..size grid - 1]]
    in findFirst (\(r, c) -> value (gridCells !! r !! c) == 0) indices

-- Helper function to find the first element that satisfies a predicate
findFirst :: (a -> Bool) -> [a] -> Maybe a
findFirst _ [] = Nothing
findFirst p (x:xs) = if p x then Just x else findFirst p xs

-- Get the current comparisons for a cell
getComparisons :: Grid -> Int -> Int -> (Comparison, Comparison, Comparison, Comparison)
getComparisons grid row col =
    case getCell (cells grid) row col of
        Just cell -> comparisons cell
        Nothing -> (None, None, None, None)  -- Default if cell doesn't exist

-- Check if placing a value at a specific position is valid
isValidPlacement :: Grid -> Int -> Int -> Bool
isValidPlacement grid row col =
    let gridCells = cells grid
    in all id [
        not (isValidRow (gridCells !! row)),  -- Check row
        not (any id (isValidColumn gridCells)),  -- Check columns
        not (any id (isValidRegions gridCells (regionSize grid))),  -- Check regions
        compareCardinals grid row col  -- Check cardinal comparisons
    ]