module MyFunctions
  (
    myUnion
  , myUnion'

  , mySplitAt
  , mySplitAt'

  , myIsDigit
  , myIsDigit'

  , myLookup

  , myDelete
  , myDelete'
  ) where

import qualified Data.List as L
import qualified Data.Map as M 
import qualified Data.Set as S

-- 1. Data.List.union 

-- Data.List.union xs ys возвращает объединение двух спсиков. 
-- Берёт xs как есть, а из ys удаляет дубликаты и элементы, уже встречающиеся в xs
--
--
-- Примеры:
--
-- Data.List.union [1,2,3] [2,3,4] == [1,2,3,4]
-- Data.List.union [1,2,2] [2,3] == [1,2,2,3]
-- Data.List.union [] [1,2] == [1,2]
-- Data.List.union [1,1] [1,2] == [1,1,2]

myUnion :: Eq a => [a] -> [a] -> [a]
myUnion xs ys = xs ++ foldl remove (myNub ys) xs
  where
    myNub [] = []
    myNub (z:zs) = z : myNub [w | w <- zs, w /= z]

    remove [] _ = []
    remove (z:zs) x
      | z == x    = zs
      | otherwise = z : remove zs x

-- Альтернативная реализация через L.nub и L.delete
myUnion' :: Eq a => [a] -> [a] -> [a]
myUnion' xs ys = xs ++ foldl (flip L.delete) (L.nub ys) xs



-- 2. Data.List.splitAt

-- Data.List.splitAt n xs делит список xs на два списка в позиции n.
-- Первый содержит первые n элементов, второй - остаток.
-- Если n <= 0, первый список пуст. Если n >= length xs, второй список пуст
--
--
-- Примеры:
--
-- Data.List.splitAt 2 "abcdef" == ("ab", "cdef")
-- Data.List.splitAt 0 [1,2,3] == ([], [1,2,3])
-- Data.List.splitAt 10 [1,2,3] == ([1,2,3], [])
-- Data.List.splitAt (-5) [1,2] == ([], [1,2])

mySplitAt :: Int -> [a] -> ([a], [a])
mySplitAt n xs
  | n <= 0    = ([], xs)
  | otherwise = go n xs []
  where
    go 0 rest acc = (reverse acc, rest)
    go _ [] acc   = (reverse acc, [])
    go k (y:ys) acc = go (k-1) ys (y:acc)

-- Альтернативная реализация через take и drop
mySplitAt' :: Int -> [a] -> ([a], [a])
mySplitAt' n xs = (take n xs, drop n xs)



-- 3. Data.Char.isDigit

-- Data.Char.isDigit c проверяет, является ли символ цифрой от 0 до 9
--
--
-- Примеры:
--
-- Data.Char.isDigit '7' == True
-- Data.Char.isDigit 'a' == False
-- Data.Char.isDigit ' ' == False

myIsDigit :: Char -> Bool
myIsDigit c = c >= '0' && c <= '9'

-- Альтернатива через список символов
myIsDigit' :: Char -> Bool
myIsDigit' c = c `elem` ['0'..'9']



-- 4. Data.Map.lookup
--
-- Data.Map.lookup k m ищет значение по ключу k в мапе m.
-- Если ключ есть, возвращает Just значение, иначе Nothing.
--
--
-- Примеры:
--
-- myMap :: Data.Map.Map String Int
-- myMap = Data.Map.fromList [("a",1), ("b",2)]
-- Data.Map.lookup "a" myMap == Just 1
-- Data.Map.lookup "c" myMap == Nothing
-- Data.Map.lookup "1" Data.Map.empty == Nothing
--
-- Собственная реализация: получаем отсортированный список пар
-- через Data.Map.toList и ищем в нём двоичным (точнее, линейным
-- с ранним выходом) поиском

myLookup :: Ord k => k -> M.Map k v -> Maybe v
myLookup k m = go (M.toList m)
  where
    go [] = Nothing
    go ((k', v):rest)
      | k == k'   = Just v
      | k < k'    = Nothing 
      | otherwise = go rest

-- 5. Data.Set.delete 

-- Data.Set.delete x s удаляет элемент x из множества s и возвращает новое множество. 
-- Если элемента нет, возвращает исходное множество
--
-- Примеры:
-- 
-- let mySet = Data.Set.fromList [1, 2, 3]
-- Data.Set.delete 2 mySet == Data.Set.fromList [1,3]
-- Data.Set.delete 5 mySet == Data.Set.fromList [1,2,3]
-- Data.Set.delete 1 Data.Set.empty == Data.Set.empty
--
-- Собственная реализация: преобразуем множество в отсортированный список через Data.List.toList,
-- удаляем первое вхождение x и собираем множество обратно через Data.List.fromList

myDelete :: Ord a => a -> S.Set a -> S.Set a
myDelete x s = S.fromList (go (S.toList s))
  where
    go [] = []
    go (y:ys)
      | x == y    = ys
      | x < y     = y : ys
      | otherwise = y : go ys

-- Альтернатива через S.filter: оставляем все элементы, кроме x
myDelete' :: Ord a => a -> S.Set a -> S.Set a
myDelete' x = S.filter (/= x)
