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
