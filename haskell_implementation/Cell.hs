module Cell (
    Comparison(..),
    Cell(..),
    createCell,
    getValue,
    setValue,
    getComparison,
    setComparison
) where

-- Define os tipos de comparação possíveis: Menor, Maior ou Nenhuma
data Comparison = Less | Greater | None
    deriving (Show, Eq, Ord)

-- Define o tipo Célula: contém um valor inteiro e 4 comparações (direita, cima, esquerda, baixo)
data Cell = Cell
    { value :: Int  -- Valor numérico da célula (0 se vazia)
    , comparisons :: (Comparison, Comparison, Comparison, Comparison)  -- Comparações com vizinhos
    }
    deriving (Show, Eq, Ord)

-- Cria uma nova célula a partir de uma tupla de comparações e um valor
createCell :: (Comparison, Comparison, Comparison, Comparison) -> Int -> Cell
createCell comps val = Cell val comps

-- Obtém o valor da célula
getValue :: Cell -> Int
getValue (Cell val _) = val

-- Define um novo valor para a célula (mantendo as comparações anteriores)
setValue :: Cell -> Int -> Cell
setValue (Cell _ comps) newVal = Cell newVal comps

-- Obtém uma comparação específica com base no índice:
-- 0 = direita, 1 = cima, 2 = esquerda, 3 = baixo
getComparison :: Int -> Cell -> Maybe Comparison
getComparison idx (Cell _ (right, top, left, down)) =
    case idx of
        0 -> Just right
        1 -> Just top
        2 -> Just left
        3 -> Just down
        _ -> Nothing  -- índice inválido

-- Define uma nova comparação para uma direção específica com base no índice:
-- 0 = direita, 1 = cima, 2 = esquerda, 3 = baixo
setComparison :: Int -> Comparison -> Cell -> Maybe Cell
setComparison idx comp (Cell val (right, top, left, down)) =
    case idx of
        0 -> Just (Cell val (comp, top, left, down))   -- define comparação à direita
        1 -> Just (Cell val (right, comp, left, down)) -- define comparação acima
        2 -> Just (Cell val (right, top, comp, down))  -- define comparação à esquerda
        3 -> Just (Cell val (right, top, left, comp))  -- define comparação abaixo
        _ -> Nothing  -- índice inválido
