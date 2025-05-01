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


-- Define Grid 
data Grid = Grid
    { size :: Int
    , regionSize :: (Int, Int)
    , cells :: [[Cell]]
    }
    deriving (Show, Eq)


createGrid :: Int -> (Int, Int) -> Grid
createGrid size regionSize = Grid size regionSize gridCells
  where
    emptyCell = createCell (None, None, None, None) 0
    -- replicate :: Int -> a -> [a]
    gridCells = replicate size (replicate size emptyCell)
 

isValidRow :: [Cell] -> Bool
isValidRow cells = 
    let values = filter (/= 0) $ map getValue cells -- Use getValue accessor instead of direct pattern matching
    in length values == length (nub values) -- FIXED: Check if all values are unique (no duplicates)


-- Transpose the grid and reuse isValidRow on each column
isValidColumn :: [[Cell]] -> [Bool]
isValidColumn grid = map isValidRow (transpose grid)

-- Break grid into regions and checks each region for uniqueness
isValidRegions :: [[Cell]] -> (Int, Int) -> [Bool]
isValidRegions grid (rH, rW) = 
    [ isValidRegion (getRegion y x) 
    | y <- [0, rH .. length grid - 1]
    , x <- [0, rW .. length (head grid) - 1]
    ]
  where
    -- Extract a region starting at (startY, startX)
    getRegion startY startX =
        [ grid !! y !! x
        | y <- [startY .. startY + rH - 1]
        , x <- [startX .. startX + rW - 1]
        ]

    -- Check if region has no duplicate non-zero values
    isValidRegion region =
        let values = filter (/= 0) $ map getValue region -- Use getValue accessor
        in length values == length (nub values) -- FIXED: Check if all values are unique


-- Helper funcs
getIntBoundry :: Grid -> Int
getIntBoundry (Grid _ (a, b) _) = a * b

-- Set the value of a specific cell in the grid
setCell :: [[Cell]] -> Int -> Int -> Cell -> [[Cell]]
setCell grid row col newCellValue =
    if row >= 0 && row < length grid && col >= 0 && col < length (head grid)
    then take row grid ++ [take col (grid !! row) ++ [newCellValue] ++ drop (col + 1) (grid !! row)] ++ drop (row + 1) grid
    else grid  -- Return the grid unchanged if the position is out of bounds

-- Safe access to a cell
getCell :: [[Cell]] -> Int -> Int -> Maybe Cell
getCell grid row col =
  if row >= 0 && row < length grid &&
     col >= 0 && col < length (head grid)
  then Just (grid !! row !! col)
  else Nothing

-- Get neighbors (top, right, bottom, left) of a given cell
-- FIXED: Order of neighbors to match comparison order in cells
getNeighbors :: [[Cell]] -> Int -> Int -> [Maybe Cell]
getNeighbors grid row col =
  let positions = [ (row, col + 1)    -- right (0)
                  , (row - 1, col)    -- top (1)
                  , (row, col - 1)    -- left (2)
                  , (row + 1, col)    -- bottom (3)
                  ]
  in [ getCell grid r c | (r, c) <- positions ]


-- Check if a cell's comparisons match its actual relationships with neighbors
compareCardinals :: Grid -> Int -> Int -> Bool
compareCardinals grid row col =
    case getCell (cells grid) row col of
        Nothing -> False  -- Cell doesn't exist
        Just cell -> 
            let cellValue = getValue cell
                (right, top, left, down) = comparisons cell
                n = size grid
            in
                -- Check right comparison
                (col >= n - 1 || right == None || 
                    case getCell (cells grid) row (col + 1) of
                        Nothing -> True
                        Just rightCell -> 
                            let rightValue = getValue rightCell
                            in rightValue == 0 || 
                               (right == Greater && cellValue > rightValue) ||
                               (right == Less && cellValue < rightValue)) &&
                
                -- Check top comparison
                (row <= 0 || top == None || 
                    case getCell (cells grid) (row - 1) col of
                        Nothing -> True
                        Just topCell -> 
                            let topValue = getValue topCell
                            in topValue == 0 ||
                               (top == Greater && cellValue > topValue) ||
                               (top == Less && cellValue < topValue)) &&
                
                -- Check left comparison
                (col <= 0 || left == None || 
                    case getCell (cells grid) row (col - 1) of
                        Nothing -> True
                        Just leftCell -> 
                            let leftValue = getValue leftCell
                            in leftValue == 0 ||
                               (left == Greater && cellValue > leftValue) ||
                               (left == Less && cellValue < leftValue)) &&
                
                -- Check down comparison
                (row >= n - 1 || down == None || 
                    case getCell (cells grid) (row + 1) col of
                        Nothing -> True
                        Just downCell -> 
                            let downValue = getValue downCell
                            in downValue == 0 ||
                               (down == Greater && cellValue > downValue) ||
                               (down == Less && cellValue < downValue)) &&
                
                -- Additional checks for neighboring cells' constraints pointing to this cell
                -- Check if left neighbor has right comparison pointing to this cell
                (col <= 0 || 
                    case getCell (cells grid) row (col - 1) of
                        Nothing -> True
                        Just leftCell ->
                            let leftValue = getValue leftCell
                                (leftRight, _, _, _) = comparisons leftCell
                            in leftValue == 0 || leftRight == None ||
                               (leftRight == Greater && leftValue > cellValue) ||
                               (leftRight == Less && leftValue < cellValue)) &&
                
                -- Check if top neighbor has down comparison pointing to this cell
                (row <= 0 || 
                    case getCell (cells grid) (row - 1) col of
                        Nothing -> True
                        Just topCell ->
                            let topValue = getValue topCell
                                (_, _, _, topDown) = comparisons topCell
                            in topValue == 0 || topDown == None ||
                               (topDown == Greater && topValue > cellValue) ||
                               (topDown == Less && topValue < cellValue)) &&
                
                -- Check if right neighbor has left comparison pointing to this cell  
                (col >= n - 1 || 
                    case getCell (cells grid) row (col + 1) of
                        Nothing -> True
                        Just rightCell ->
                            let rightValue = getValue rightCell
                                (_, _, rightLeft, _) = comparisons rightCell
                            in rightValue == 0 || rightLeft == None ||
                               (rightLeft == Greater && rightValue > cellValue) ||
                               (rightLeft == Less && rightValue < cellValue)) &&
                
                -- Check if bottom neighbor has top comparison pointing to this cell
                (row >= n - 1 || 
                    case getCell (cells grid) (row + 1) col of
                        Nothing -> True
                        Just downCell ->
                            let downValue = getValue downCell
                                (_, downTop, _, _) = comparisons downCell
                            in downValue == 0 || downTop == None ||
                               (downTop == Greater && downValue > cellValue) ||
                               (downTop == Less && downValue < cellValue))
                               
-- Simplified helper function to check a single comparison with a neighbor
checkNeighbor :: Int -> Comparison -> Maybe Cell -> Bool
checkNeighbor cellValue comp maybeNeighbor =
    case (comp, maybeNeighbor) of
        (None, _) -> True  -- No comparison needed
        (_, Nothing) -> True  -- No neighbor in this direction, so constraint is satisfied
        (Greater, Just neighbor) -> 
            let neighborValue = getValue neighbor
            in neighborValue == 0 || cellValue > neighborValue  -- Allow empty cells
        (Less, Just neighbor) -> 
            let neighborValue = getValue neighbor
            in neighborValue == 0 || cellValue < neighborValue  -- Allow empty cells