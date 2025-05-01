module Parse (
    parseGrid,
    printGrid
) where

import Data.List.Split (splitOn)
import Data.List (isPrefixOf)
import Data.Maybe (fromMaybe)
import Cell
import Grid

-- Parse a grid from file content and grid number
parseGrid :: String -> Int -> Maybe Grid
parseGrid content gridNum = do
    -- Find the section for the requested grid number
    let sections = splitOn ("#" ++ show gridNum) content
    if length sections <= 1
        then Nothing
        else do
            let gridSection = sections !! 1
            -- Extract size
            size <- extractSize gridSection
            -- Extract region size
            (regionRows, regionCols) <- extractRegionSize gridSection
            -- Extract cell data
            cellData <- extractCellData gridSection size
            
            -- Create the grid
            return $ Grid size (regionRows, regionCols) cellData

-- Extract grid size from text
extractSize :: String -> Maybe Int
extractSize content = do
    let sizeLine = filter (isPrefixOf "SIZE:") (lines content)
    if null sizeLine
        then Nothing
        else do
            let sizeText = head sizeLine
            let sizeStr = drop 5 sizeText  -- Remove "SIZE:"
            return (read (takeWhile (/= 'X') sizeStr) :: Int)

-- Extract region size from text
extractRegionSize :: String -> Maybe (Int, Int)
extractRegionSize content = do
    let regionLine = filter (isPrefixOf "REGION_SIZE:") (lines content)
    if null regionLine
        then Nothing
        else do
            let regionText = head regionLine
            let regionParts = splitOn "X" (drop 12 regionText)  -- Remove "REGION_SIZE:"
            if length regionParts < 2
                then Nothing
                else return (read (regionParts !! 0), read (regionParts !! 1))

-- Extract cell data from text
extractCellData :: String -> Int -> Maybe [[Cell]]
extractCellData content size = do
    let contentLines = lines content
    let beginIdx = findIndex "BEGIN" contentLines
    let endIdx = findIndex "END" contentLines
    
    case (beginIdx, endIdx) of
        (Just begin, Just end) -> do
            let dataLines = take (end - begin - 1) (drop (begin + 1) contentLines)
            if length dataLines /= size
                then Nothing
                else Just (parseRows dataLines size)
        _ -> Nothing

-- Find index of a line with prefix
findIndex :: String -> [String] -> Maybe Int
findIndex prefix list = findIndexHelper prefix list 0
  where
    findIndexHelper _ [] _ = Nothing
    findIndexHelper p (x:xs) idx
        | isPrefixOf p x = Just idx
        | otherwise = findIndexHelper p xs (idx + 1)

-- Parse all rows
parseRows :: [String] -> Int -> [[Cell]]
parseRows lines size = map (parseRow size) lines

-- Parse a single row of cells
-- FIXED: Properly split by commas as defined in the file format
parseRow :: Int -> String -> [Cell]
parseRow size line = 
    let tokens = splitOn "," (filter (/= ' ') line)
        -- Make sure we have enough tokens for the size
        validTokens = take size tokens
    in map parseCell validTokens

-- Parse a single cell
parseCell :: String -> Cell
parseCell token =
    let right = charToComparison (safeIndex token 0)
        top = charToComparison (safeIndex token 1)
        left = charToComparison (safeIndex token 2)
        down = charToComparison (safeIndex token 3)
    in createCell (right, top, left, down) 0  -- Initialize with value 0

-- Safely access a character in a string
safeIndex :: String -> Int -> Char
safeIndex s i = if i < length s then s !! i else '-'

-- Convert character to Comparison
charToComparison :: Char -> Comparison
charToComparison '>' = Greater
charToComparison '<' = Less
charToComparison _ = None

-- Print a grid to console
printGrid :: Grid -> IO ()
printGrid grid = do
    putStrLn $ "Grid SIZE: " ++ show (size grid) ++ "x" ++ show (size grid)
    let (regionRows, regionCols) = regionSize grid
    putStrLn $ "Grid REGION SIZE: " ++ show regionRows ++ "x" ++ show regionCols ++ "\n"
    
    -- Print each row of cells
    mapM_ printRow (cells grid)
  where
    printRow row = do
        -- Print each cell in the row
        mapM_ printCell row
        putStrLn ""
    
    printCell cell = do
        let (right, top, left, down) = comparisons cell
        putStr $ compToChar right : compToChar top : compToChar left : compToChar down : "  "
    
    compToChar Greater = '>'
    compToChar Less = '<'
    compToChar None = '-'