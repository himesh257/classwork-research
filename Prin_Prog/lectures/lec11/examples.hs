ex01 = 3 + 2
ex02 = 19 - 27
ex03 = 2.35 * 8.6
ex04 = 8.7 / 3.1
ex05 = mod 19 3
ex06 = 19 `mod` 3 -- backticks make mod infix
ex07 = 7 ^ 222
ex08 = (-3) * (-7) -- negative numbers should be written with parentheses

i1, i2 :: Int
i1 = 3
i2 = 4

-- z = i1 / i2

ex09 = i1 `div` i2
ex10 = 12 `div` 5

ex11 = True && False
ex12 = not (False || True)

ex13 = ('a' == 'a')
ex14 = (16 /= 3)
ex15 = (5 > 3) && ('p' <= 'q')
ex16 = "Haskell" > "C++"

f :: Int -> Int -> Int -> Int
f x y z = x + y + z
ex17 = f 3 17 8

ex18 = 1 : []
ex19 = 3 : (1 : [])
ex20 = 2 : 3 : 4 : []

ex21 = [2,3,4] == 2 : 3 : 4 : []
