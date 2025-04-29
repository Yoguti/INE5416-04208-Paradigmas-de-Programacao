module Grid (
    Grid,
    emptyGrid,
    getCell,
    setCell,
    setAllCells,
    validateGrid,
    solveGrid,
    isPossibleValue,
    isValidPosition,
    checkComparisons,
    getCandidates
) where

import Cell (Cell(..), Comparison(..), createCell, getComparison)
import Data.List (nub)
import Data.Maybe (fromJust, isJust, catMaybes)

-- Grid type definition (a 2D array of Cells)
type Grid = [[Cell]]

-- Create an empty grid of given size
emptyGrid :: Int -> Grid
-- replicate :: Int -> a -> [a]
emptyGrid n = replicate n (replicate n emptyCell)
  where
    emptyCell = createCell (None, None, None, None) 0

-- Get a cell at a specific position
getCell :: Grid -> (Int, Int) -> Maybe Cell
getCell grid (row, col)
  | isValidPosition grid (row, col) = Just (grid !! row !! col)
  | otherwise = Nothing

-- Set a cell at a specific position
setCell :: Grid -> (Int, Int) -> Cell -> Grid
setCell grid (row, col) newCell
  | isValidPosition grid (row, col) =
      take row grid ++
      [take col (grid !! row) ++ [newCell] ++ drop (col + 1) (grid !! row)] ++
      drop (row + 1) grid
  | otherwise = grid

-- Set all cells in the grid at once
setAllCells :: Grid -> [((Int, Int), Cell)] -> Grid
setAllCells = foldl (\g ((r, c), cell) -> setCell g (r, c) cell)

-- Check if a position is valid within the grid bounds
isValidPosition :: Grid -> (Int, Int) -> Bool
isValidPosition grid (row, col) =
  row >= 0 && row < length grid && col >= 0 && col < length (head grid)

-- Get all possible values for a given size
allValues :: Int -> [Int]
allValues size = [1..size]

-- Get row values for a given position
getRowValues :: Grid -> Int -> [Int]
getRowValues grid row = [value cell | cell <- grid !! row, value cell /= 0]

-- Get column values for a given position
getColValues :: Grid -> Int -> [Int]
getColValues grid col = [value (grid !! r !! col) | r <- [0..length grid - 1], value (grid !! r !! col) /= 0]

-- Get region values for a given position
getRegionValues :: Grid -> (Int, Int) -> (Int, Int) -> [Int]
getRegionValues grid (row, col) (regRows, regCols) =
  let regRow = (row `div` regRows) * regRows
      regCol = (col `div` regCols) * regCols
      regPositions = [(r, c) | r <- [regRow..regRow + regRows - 1], 
                               c <- [regCol..regCol + regCols - 1]]
  in [value (grid !! r !! c) | (r, c) <- regPositions, value (grid !! r !! c) /= 0]

-- Check if a value is valid for a given position
isPossibleValue :: Grid -> (Int, Int) -> (Int, Int) -> Int -> Bool
isPossibleValue grid (row, col) regionSize val =
  val `notElem` getRowValues grid row &&
  val `notElem` getColValues grid col &&
  val `notElem` getRegionValues grid (row, col) regionSize &&
  checkComparisons grid (row, col) val

-- Check if a comparison constraint is satisfied
checkComparisons :: Grid -> (Int, Int) -> Int -> Bool
checkComparisons grid (row, col) val =
  let cell = grid !! row !! col
      adjacentCells = [
          ((row, col+1), 0, Less),    -- right
          ((row-1, col), 1, Greater), -- top
          ((row, col-1), 2, Less),    -- left
          ((row+1, col), 3, Greater)  -- bottom
        ]
      
      checkAdjacent ((r, c), idx, expectedRelation) =
        if isValidPosition grid (r, c) then
          case getComparison idx cell of
            Just Less -> 
              let adjVal = value (grid !! r !! c)
              in adjVal == 0 || val < adjVal
            Just Greater -> 
              let adjVal = value (grid !! r !! c)
              in adjVal == 0 || val > adjVal
            Just None -> True
            Nothing -> False
        else True
      
      -- Also check the reverse comparison from adjacent cells
      reverseAdjacentCells = [
          ((row, col-1), 0, Greater), -- left cell's right comparison
          ((row+1, col), 1, Less),    -- bottom cell's top comparison
          ((row, col+1), 2, Greater), -- right cell's left comparison
          ((row-1, col), 3, Less)     -- top cell's bottom comparison
        ]
      
      checkReverseAdjacent ((r, c), idx, expectedRelation) =
        if isValidPosition grid (r, c) then
          case getComparison idx (grid !! r !! c) of
            Just Less -> 
              let adjVal = value (grid !! r !! c)
              in adjVal == 0 || adjVal < val
            Just Greater -> 
              let adjVal = value (grid !! r !! c)
              in adjVal == 0 || adjVal > val
            Just None -> True
            Nothing -> False
        else True
  in all checkAdjacent adjacentCells && all checkReverseAdjacent reverseAdjacentCells

-- Get candidate values for a given position
getCandidates :: Grid -> (Int, Int) -> (Int, Int) -> [Int]
getCandidates grid pos@(row, col) regionSize =
  let size = length grid
  in filter (\v -> isPossibleValue grid pos regionSize v) [1..size]

-- Validate if a grid is correctly filled
validateGrid :: Grid -> (Int, Int) -> Bool
validateGrid grid regionSize@(regRows, regCols) =
  let size = length grid
      -- Check rows
      rowsValid = all (\r -> length (nub [value cell | cell <- grid !! r, value cell /= 0]) == 
                             length [cell | cell <- grid !! r, value cell /= 0]) [0..size-1]
      
      -- Check columns
      colsValid = all (\c -> length (nub [value (grid !! r !! c) | r <- [0..size-1], 
                                          value (grid !! r !! c) /= 0]) == 
                             length [value (grid !! r !! c) | r <- [0..size-1], 
                                     value (grid !! r !! c) /= 0]) [0..size-1]
      
      -- Check regions
      regionsValid = all checkRegion [(regRow, regCol) | regRow <- [0,regRows..size-1], 
                                                          regCol <- [0,regCols..size-1]]
      checkRegion (startRow, startCol) =
        let regionCells = [grid !! r !! c | r <- [startRow..startRow+regRows-1], 
                                            c <- [startCol..startCol+regCols-1], 
                                            value (grid !! r !! c) /= 0]
        in length (nub [value cell | cell <- regionCells]) == length regionCells
      
      -- Check all comparisons
      comparisonsValid = and [checkPos (r, c) | r <- [0..size-1], c <- [0..size-1], 
                                              value (grid !! r !! c) /= 0]
      checkPos (r, c) = checkComparisons grid (r, c) (value (grid !! r !! c))
  in rowsValid && colsValid && regionsValid && comparisonsValid

-- Solve the grid using a backtracking algorithm
solveGrid :: Grid -> (Int, Int) -> Maybe Grid
solveGrid grid regionSize =
  let size = length grid
      emptyPositions = [(r, c) | r <- [0..size-1], c <- [0..size-1], 
                                value (grid !! r !! c) == 0]
  in solve grid regionSize emptyPositions

-- Helper function for solveGrid
solve :: Grid -> (Int, Int) -> [(Int, Int)] -> Maybe Grid
solve grid _ [] = Just grid  -- No empty positions left, puzzle solved!
solve grid regionSize (pos:rest) =
  let candidates = getCandidates grid pos regionSize
      -- Try each candidate
      tryCandidate [] = Nothing  -- No valid candidates
      tryCandidate (val:vals) =
        let cell = fromJust (getCell grid pos)
            newCell = cell { value = val }
            newGrid = setCell grid pos newCell
        in case solve newGrid regionSize rest of
             Just solvedGrid -> Just solvedGrid
             Nothing -> tryCandidate vals
  in tryCandidate candidates