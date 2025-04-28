module Cell (
    Comparison(..),
    Cell(..),
    createCell,
    getComparison,
    setComparison
) where

-- Define possible comparisons: Less, Greater, or None
data Comparison = Less | Greater | None
    deriving (Show, Eq)

-- Define the Cell type: Int value and 4 comparisons (right, top, left, down)
data Cell = Cell
    { value :: Int
    , comparisons :: (Comparison, Comparison, Comparison, Comparison)
    }
    deriving (Show, Eq)

-- Create a new Cell
createCell :: (Comparison, Comparison, Comparison, Comparison) -> Int -> Cell
createCell comps val = Cell val comps

-- Get a cell value
getValue :: Cell -> Int
getValue (Cell val _) = val

-- Set a new value for a Cell
setValue :: Cell -> Int -> Cell
setValue (Cell _ comps) newVal = Cell newVal comps

-- Get a specific comparison
-- Index: 0 = right, 1 = top, 2 = left, 3 = down
getComparison :: Int -> Cell -> Maybe Comparison
getComparison idx (Cell _ (right, top, left, down)) =
    case idx of
        0 -> Just right
        1 -> Just top
        2 -> Just left
        3 -> Just down
        _ -> Nothing  -- invalid index

-- Set a specific comparison
-- Index: 0 = right, 1 = top, 2 = left, 3 = down
setComparison :: Int -> Comparison -> Cell -> Maybe Cell
setComparison idx comp (Cell val (right, top, left, down)) =
    case idx of
        0 -> Just (Cell val (comp, top, left, down))
        1 -> Just (Cell val (right, comp, left, down))
        2 -> Just (Cell val (right, top, comp, down))
        3 -> Just (Cell val (right, top, left, comp))
        _ -> Nothing  -- invalid index
