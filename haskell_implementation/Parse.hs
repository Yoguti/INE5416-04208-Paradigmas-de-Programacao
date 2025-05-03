module Parse (
    parseGrid,
    printGrid
) where

import Data.List.Split (splitOn)
import Data.List (isPrefixOf)
import Data.Maybe (fromMaybe)
import Cell
import Grid

-- Faz o parsing (análise) de uma grade a partir do conteúdo de um arquivo e o número da grade
parseGrid :: String -> Int -> Maybe Grid
parseGrid content gridNum = do
    -- Encontra a seção referente ao número da grade solicitado
    let sections = splitOn ("#" ++ show gridNum) content
    if length sections <= 1
        then Nothing
        else do
            let gridSection = sections !! 1
            -- Extrai o tamanho da grade
            size <- extractSize gridSection
            -- Extrai o tamanho da região
            (regionRows, regionCols) <- extractRegionSize gridSection
            -- Extrai os dados das células
            cellData <- extractCellData gridSection size
            
            -- Cria e retorna a grade
            return $ Grid size (regionRows, regionCols) cellData

-- Extrai o tamanho da grade a partir do texto
extractSize :: String -> Maybe Int
extractSize content = do
    let sizeLine = filter (isPrefixOf "SIZE:") (lines content)
    if null sizeLine
        then Nothing
        else do
            let sizeText = head sizeLine
            let sizeStr = drop 5 sizeText  -- Remove "SIZE:"
            return (read (takeWhile (/= 'X') sizeStr) :: Int)

-- Extrai o tamanho da região a partir do texto
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

-- Extrai os dados das células a partir do texto
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

-- Encontra o índice de uma linha com determinado prefixo
findIndex :: String -> [String] -> Maybe Int
findIndex prefix list = findIndexHelper prefix list 0
  where
    findIndexHelper _ [] _ = Nothing
    findIndexHelper p (x:xs) idx
        | isPrefixOf p x = Just idx
        | otherwise = findIndexHelper p xs (idx + 1)

-- Faz o parsing de todas as linhas da grade
parseRows :: [String] -> Int -> [[Cell]]
parseRows lines size = map (parseRow size) lines

-- Faz o parsing de uma única linha de células
-- CORRIGIDO: Divide corretamente por vírgulas, como definido no formato do arquivo
parseRow :: Int -> String -> [Cell]
parseRow size line = 
    let tokens = splitOn "," (filter (/= ' ') line)
        -- Garante que temos tokens suficientes para o tamanho esperado
        validTokens = take size tokens
    in map parseCell validTokens

-- Faz o parsing de uma única célula
parseCell :: String -> Cell
parseCell token =
    let right = charToComparison (safeIndex token 0)
        top = charToComparison (safeIndex token 1)
        left = charToComparison (safeIndex token 2)
        down = charToComparison (safeIndex token 3)
    in createCell (right, top, left, down) 0  -- Inicializa com valor 0

-- Acessa com segurança um caractere em uma string
safeIndex :: String -> Int -> Char
safeIndex s i = if i < length s then s !! i else '-'

-- Converte um caractere em um tipo de comparação
charToComparison :: Char -> Comparison
charToComparison '>' = Greater
charToComparison '<' = Less
charToComparison _ = None

-- Imprime a grade no console
printGrid :: Grid -> IO ()
printGrid grid = do
    putStrLn $ "Grid SIZE: " ++ show (size grid) ++ "x" ++ show (size grid)
    let (regionRows, regionCols) = regionSize grid
    putStrLn $ "Grid REGION SIZE: " ++ show regionRows ++ "x" ++ show regionCols ++ "\n"
    
    -- Imprime cada linha de células
    mapM_ printRow (cells grid)
  where
    printRow row = do
        -- Imprime cada célula da linha
        mapM_ printCell row
        putStrLn ""
    
    printCell cell = do
        let (right, top, left, down) = comparisons cell
        putStr $ compToChar right : compToChar top : compToChar left : compToChar down : "  "
    
    compToChar Greater = '>'
    compToChar Less = '<'
    compToChar None = '-'
