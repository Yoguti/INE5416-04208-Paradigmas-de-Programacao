main :: IO()

let mysum x y = x + y

main = do
	input1 <- getLine
	input1 <- getLine
	putStrLn(mysum)
