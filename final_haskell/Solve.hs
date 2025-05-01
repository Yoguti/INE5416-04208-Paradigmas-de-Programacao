module Solve (
    solve,
    futoshiki
) where

import Grid
import Data.Maybe
import Cell

positions :: Int -> [(Int, Int)]
positions n = [ (r, c) | r <- [0..n-1], c <- [0..n-1] ]


solve :: Grid -> [(Int, Int)] -> [Int] -> Maybe Grid
solve grid [] _ = Just grid  -- All positions processed
solve grid ((row, col):rest) values =
    case getCell (cells grid) row col of
        Just cell ->
            if value cell /= 0
            then solve grid rest values  -- Skip filled cells
            else tryValues values
          where
            tryValues [] = Nothing  -- No value fits here, backtrack
            tryValues (v:vs) =
                let newCell = setValue cell v
                    newGridCells = setCell (cells grid) row col newCell
                    newGrid = grid { cells = newGridCells }
                    valid = and
                      [ isValidRow (newGridCells !! row)
                      , all id (isValidColumn newGridCells)
                      , all id (isValidRegions newGridCells (regionSize grid))
                      , compareCardinals newGrid row col
                      ]
                in if valid
                   then case solve newGrid rest values of
                          Just g -> Just g
                          Nothing -> tryValues vs  -- Backtrack
                   else tryValues vs  -- Try next value
        _ -> Nothing  -- Invalid access


futoshiki :: Grid -> Maybe Grid
futoshiki grid =
    let n = size grid
        values = [1..n]
        pos = positions n
    in solve grid pos values
