-- toDigits 1234 = [1, 2, 3, 4]
toDigits :: Integer -> [Integer]
toDigits n = reverse (toDigitsRev n)

-- toDigitsRev 1234 = [4, 3, 2, 1]
toDigitsRev :: Integer -> [Integer]
toDigitsRev n = if n < 10
             then [n]
             else n `mod` 10 : toDigitsRev (n `div` 10)

-- doubleEveryOther [1,2,3,4] = [2,2,6,4]
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther (x:[]) = [x]
doubleEveryOther lst@(x:y:zs) = if length lst `mod` 2 == 0
                                then 2 * x : y : doubleEveryOther zs
                                else x : 2 * y : doubleEveryOther zs


-- sumDigits [16, 4] = 1 + 6 + 4 = 11
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) = sum (toDigitsRev x) + sumDigits xs

validate :: Integer -> Bool
validate n = sumDigits (doubleEveryOther (toDigits n)) `mod` 10 == 0

main = do
  print (validate 4012888888881881 == True)
  print (validate 4012888888881882 == False)
