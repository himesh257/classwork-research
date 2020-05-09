intListLength :: [Integer] -> Integer
intListLength []     = 0
intListLength (_:xs) = 1 + intListLength xs

isEven :: Integer -> Bool
isEven n = n `mod` 2 == 0

collatz :: Integer -> Integer
collatz n
  | isEven n  = n `div` 2
  | otherwise = 3*n + 1

collatzSeq :: Integer -> [Integer]
collatzSeq 1 = [1]
collatzSeq n = n : collatzSeq (collatz n)

collatzLen :: Integer -> Integer
collatzLen n = intListLength (collatzSeq n) - 1
