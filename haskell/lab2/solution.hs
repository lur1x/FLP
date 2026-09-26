import System.IO 

doMyList :: Int -> [Int]
doMyList n = [n .. (n * 2 - 1)]

-- 1 задание:
oddEven :: [a] -> [a]
oddEven [] = []
oddEven [e] = [e] 
oddEven (x : y : xs) = y : x : (oddEven xs)


-- 2 задание
insert :: [a] -> a -> Int -> [a]
insert [] a _ = [a]
insert (x:xs) a p
    | p <= 0 = a : x : xs
    | otherwise = x : insert xs a (p - 1)

-- 3 задание
listSum :: [Int] -> [Int] -> [Int]
listSum [] [] = []
listSum xs [] = xs
listSum [] ys = ys
listSum (x:xs) (y:ys) = (x + y) : listSum xs ys 


-- 4 задание
position :: [Int] -> Int -> Int
position [] _ = -1
position (x:xs) a
    | x == a    = 0
    | otherwise = let p = position xs a
                  in if p == -1 then -1 else p + 1


-- 5 задание
sumF1 :: Int -> Int
sumF1 n
    | n == 0 = 0
    | n < 0 = -1
    | otherwise = n + sumF1 (n - 1)


-- 6 задание
sumF2 :: Int -> Int
sumF2 n
    | n == 0 = 0
    | n < 0 = -1
    | otherwise = (n - 1) + sumF2 (n - 1)



main :: IO ()
  
main = do

        -- 1 задание: 
        -- oddEven(L) -  функция перестановки местами соседних элементов списка L  
        -- (Например, список [2,5,7,9,1,8] после преобразования будет иметь вид [5,2,9,7,8,1])
        
        n <- readLn
        putStr "N1:"
        print (oddEven (doMyList n))



        -- 2 задание:
        -- insert (L,A,n) -  функция включения в список L заданного атома А на определенную позицию n.

        list2 <- readLn :: IO [Int]
        element <- readLn :: IO Int
        pos2 <- readLn :: IO Int
        putStr "N2:"
        print (insert list2 element pos2)



        -- 3 задание:
        -- listSumm(L1,L2) -  функция сложения элементов двух списков. Возвращает список , 
        -- составленный из сумм элементов списков - параметров L1, L2. Учесть, что переданные списки 
        -- могут быть разной длины. 

        list3_1 <- readLn :: IO [Int]
        list3_2 <- readLn :: IO [Int]
        putStr "N3:"
        print (listSum list3_1 list3_2)



        -- 4 задание
        -- position (L,A)- возвращает номер первого вхождения заданного атома  А в список L.
        list4 <- readLn :: IO [Int]
        element4 <- readLn :: IO Int
        putStr "N4:"
        print (position list4 element4)



        -- 5 задание
        -- Найти сумму F(n)=∑i=1n (i).
        n5 <- readLn :: IO Int
        putStr "N5:"
        print (sumF1 n5)



        -- 6 задание
        -- Найти  сумму F(n)=∑i=1n(n−i).
        n6 <- readLn :: IO Int
        putStr "N6:"
        print (sumF2 n6)