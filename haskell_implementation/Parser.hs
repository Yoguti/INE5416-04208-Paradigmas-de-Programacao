module Parser
  ( parseNthGrid
  , printGrid
  , Grid
  ) where

-- Importa tipos e funções do módulo Cell.hs
import Cell (Comparison(..), Cell(..), createCell)

-- Imports padrão
import Data.Char (isDigit)
import Data.List (break, elemIndex, isPrefixOf)

-- Grade de células (matriz)
type Grid = [[Cell]]

------------------------------------------------------------
-- Função principal: seleciona e parseia uma grid por ID
------------------------------------------------------------

parseNthGrid :: Int -> String -> Maybe (Int, (Int, Int), Grid)
parseNthGrid gridId content =
  let blocks = splitOnGrids (lines content)
      matchIdHeader idLine =
        case idLine of
          ('#':n) -> (read n :: Int) == gridId
          _ -> False
  in case filter (\g -> not (null g) && matchIdHeader (head g)) blocks of
       (gridBlock:_) -> Just (parseGridBlock gridBlock)
       [] -> Nothing

------------------------------------------------------------
-- Funções auxiliares para parsing
------------------------------------------------------------

-- Divide todas as grids do arquivo
splitOnGrids :: [String] -> [[String]]
splitOnGrids [] = []
splitOnGrids (x:xs)
  | "#" `isPrefixOf` x =
      let (grid, rest) = break (\l -> "#" `isPrefixOf` l) xs
      in (x : takeWhile (/= "END") grid ++ ["END"]) : splitOnGrids rest
  | otherwise = splitOnGrids xs

-- Extrai os dados de uma grid individual
parseGridBlock :: [String] -> (Int, (Int, Int), Grid)
parseGridBlock block =
  let sizeLine = getLineStartingWith "SIZE:" block
      regionLine = getLineStartingWith "REGION_SIZE:" block
      beginIdx = case elemIndex "BEGIN" block of
        Just i -> i
        Nothing -> error "BEGIN não encontrado"
      n = read (dropWhile (not . isDigit) sizeLine)
      regionSize = parseRegionSize regionLine
      gridLines = take n (drop (beginIdx + 1) block)
      rawGrid = map parseLine gridLines
      grid = buildGrid rawGrid
  in (n, regionSize, grid)

getLineStartingWith :: String -> [String] -> String
getLineStartingWith prefix ls =
  case filter (prefix `isPrefixOf`) ls of
    (x:_) -> x
    _ -> error $ "Linha com prefixo \"" ++ prefix ++ "\" não encontrada"

parseRegionSize :: String -> (Int, Int)
parseRegionSize line =
  let digits = dropWhile (not . isDigit) line
      (aStr, _:bStr) = break (== 'x') digits
  in (read aStr, read bStr)

parseLine :: String -> [(Char, Char, Char, Char)]
parseLine line = map parseCell (splitOn ',' (filter (/= ' ') line))

parseCell :: String -> (Char, Char, Char, Char)
parseCell [a,b,c,d] = (a,b,c,d)
parseCell _ = error "Formato de célula inválido. Esperado exatamente 4 caracteres."

buildGrid :: [[(Char, Char, Char, Char)]] -> Grid
buildGrid rows = map (map toCell) rows
  where
    toCell (r, t, l, b) =
      let comps = (charToComparison r, charToComparison t, charToComparison l, charToComparison b)
      in createCell comps 0

charToComparison :: Char -> Comparison
charToComparison '<' = Less
charToComparison '>' = Greater
charToComparison '-' = None
charToComparison _   = error "Símbolo inválido. Use apenas '<', '>' ou '-'"

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn _ [] = []
splitOn delim xs =
  let (prefix, rest) = break (== delim) xs
  in case rest of
       [] -> [prefix]
       (_:suffix) -> prefix : splitOn delim suffix

------------------------------------------------------------
-- Impressão da Grid formatada
------------------------------------------------------------

printGrid :: Int -> (Int, Int) -> Grid -> IO ()
printGrid size (rRows, rCols) grid = do
  putStrLn $ "grid SIZE: " ++ show size ++ "x" ++ show size
  putStrLn $ "grid REGION SIZE: " ++ show rRows ++ "x" ++ show rCols
  putStrLn ""
  mapM_ printRow grid
  where
    showComp c = case c of
      Less    -> "<"
      Greater -> ">"
      None    -> "-"
    showCell (Cell _ (r, t, l, b)) = showComp r ++ showComp t ++ showComp l ++ showComp b
    printRow row = putStrLn $ unwords (map showCell row)
