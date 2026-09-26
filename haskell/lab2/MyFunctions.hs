module MyFunctions where

doMyList :: Int -> [Int]
doMyList n = [n .. (n * 2 -1)]
-- параметром является число N. функция генерирует список из N элементов, начиная с указанного элемента N


-- 1 задание:
oddEven :: [Int] -> [Int]
oddEven [] = []
oddEven [e] = [e] 
oddEven (x : y : xs) = y : x : (oddEven xs)


-- 2 задание
insert :: [a] -> a -> Int -> [a]
insert [] a p = [a]
insert xs a 1 = a : xs
insert (x:xs) a p =  x : insert xs a (p - 1)


-- 3 задание
listSum :: [Int] -> [Int] -> [Int]
listSum [] [] = []
listSum xs [] = xs
listSum [] ys = ys
listSum (x:xs) (y:ys) = (x + y) : listSum xs ys 


-- 4 задание
position :: [Int] -> Int -> Int
position [] a = 0
position (x:xs) a
    | x == a    = 1
    | otherwise = let p = position xs a
                  in if p == 0 then 0 else p + 1


-- 5 задание
sumF1 :: Int -> Int
sumF1 0 = 0
sumF1 n = n + sumF1 (n - 1)


-- 6 задание
sumF2 :: Int -> Int
sumF2 0 = 0
sumF2 n = (n - 1) + sumF2 (n - 1)