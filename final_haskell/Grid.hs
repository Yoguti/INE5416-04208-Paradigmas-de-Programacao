`module Grid (Grid(..)) where

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
