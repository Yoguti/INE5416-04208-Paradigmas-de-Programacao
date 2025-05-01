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


-- Definine Grid 
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
    let values = filter (/= 0) $ map value cells -- filter invalid cell values and map them to a list of values
    in length values /= length (nub values) -- compare if the lenght of values is != from the lenght of values - repeated values (nub)


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
        let values = filter (/= 0) $ map value region
        in length values == length (nub values)



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
getNeighbors :: [[Cell]] -> Int -> Int -> [Cell]
getNeighbors grid row col =
  let positions = [ (row - 1, col)    -- top
                  , (row, col + 1)    -- right
                  , (row + 1, col)    -- bottom
                  , (row, col - 1)    -- left
                  ]
  in [ cell | (r, c) <- positions, Just cell <- [getCell grid r c] ]


-- Check if a cell's comparisons match its actual relationships with neighbors
compareCardinals :: Grid -> Int -> Int -> Bool
compareCardinals grid row col =
    case getCell (cells grid) row col of
        Nothing -> False  -- Cell doesn't exist
        Just cell -> 
            let (right, top, left, down) = comparisons cell
                neighbors = [(row, col+1), (row-1, col), (row, col-1), (row+1, col)]
                comparisons' = [right, top, left, down]
            in all id $ zipWith (checkComparison cell (cells grid)) comparisons' neighbors

-- Helper function to check a single comparison
checkComparison :: Cell -> [[Cell]] -> Comparison -> (Int, Int) -> Bool
checkComparison cell grid comp (nRow, nCol) =
    case (comp, getCell grid nRow nCol) of
        (None, _) -> True  -- No comparison needed
        (_, Nothing) -> True  -- No neighbor in this direction, so no constraint
        (Greater, Just neighbor) -> value cell > value neighbor
        (Less, Just neighbor) -> value cell < value neighbor