module Solve (
    parseGrid,
    printGrid
) where

import Grid
import Data.Maybe
import Cell

futoshiki :: Grid -> Maybe Grid
futoshiki grid =
    let (a, b) = regionSize grid
        n = a * b
        values = [1 .. n]
    in Just --newGrid must be declared here