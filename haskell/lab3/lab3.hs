module Lw3 where

-- 1 задание
listnums :: Int -> Maybe [Int]
listnums n 
    | n < 0 = Nothing
    | otherwise = Just (go n)
    where
        go 0 = [] 
        go x = x : go (x - 1)

-- 2 задание
secondlastlist :: [[a]] -> [a]
secondlastlist [] = []
secondlastlist (x:xs)   
    | null x = secondlastlist xs
    | otherwise = last x : secondlastlist xs

-- 3 задание
myunion :: Eq a => [a] -> [a] -> [a]
myunion xs ys = myunionHelper xs (myunionHelper ys [])

myunionHelper :: Eq a => [a] -> [a] -> [a]
myunionHelper [] acc = acc
myunionHelper (x:xs) acc
    | x `elem` acc = myunionHelper xs acc 
    | otherwise    = myunionHelper xs (acc ++ [x]) 

-- 4 задание
mysubst :: Eq a => [a] -> [a] -> [a]
mysubst [] _ = []
mysubst (x:xs) ys
    | x `elem` ys = mysubst xs ys
    | otherwise = x : mysubst xs ys

-- 5 задание
nposlist :: Int -> [[a]] -> Maybe [a]
nposlist n xss
  | n < 0 =  Nothing
  | any (\xs -> length xs <= n) xss = Nothing
  | otherwise = Just (map (!! n) xss)

main :: IO ()
main = do

    -- 1 задание: listnums. Она берет численный аргумент n  и возвращает 
    --список всех чисел от n до 1, включительно. 
    putStrLn "1 задание:"
    print $ listnums 5           
    print $ listnums 0            
    print $ listnums $ -1


    -- 2 задание: secondlastlist. Эта функция берет список  списков и 
    -- возвращает последние элементы каждого, объединенные  в список.  
    putStrLn "2 задание:"
    print $ secondlastlist [[1,2], [3,4], [5,6]]  
    print $ secondlastlist [[1,2], [], [5,6]]    
    print $ secondlastlist [[], [], ['a'], ['a', 'b']]
    -- print $ secondlastlist ([] :: [[Int]])


    -- 3 задание: myunion, которая находит объединение двух  списков. 
    -- Объединением двух списков будет список содержащий элементы,  
    -- которые есть по крайней мере в одном из списков.  
    putStrLn "3 задание:"
    print $ myunion [1, 2, 3] [3, 4, 5]   
    print $ myunion [1,2,3] []
    print $ myunion [1,2,2,2,2,2,3] [4,4,4,4,4,4,4,5,101,101,101]
    print $ myunion [145, 145, 12] [21, 21, 12, -5]

    -- 4 задание: mysubst. Получив два списка, она возвращает их разность. 
    -- Разность двух списков называется список, состоящий из элементов  
    -- первого списка, которые не принадлежат второму списку.  
    putStrLn "4 задание:"
    print $ mysubst [1, 2, 3, 4] [2, 4]
    print $ mysubst [1, 2, 3, 4, 5, 10] [3, 4, 5]
    print $ mysubst [1,2,3] [1,2,3]
    print $ mysubst [] [1,2,3]
    print $ mysubst [1,2,3] []


    -- 5 задание: nposlist, берущую список списков и возвращающую список 
    -- из N -х элементов подсписков с помощью функций map и (!!)  
    putStrLn "5 задание:"
    print $ nposlist 1 [[1, 2], [3, 4], [5, 6]]      
    print $ nposlist 3 [[1, 2], [3, 4], [5, 6]]
    print $ nposlist 0 [[1, 2], [3, 4], [5, 6]]
    print $ nposlist (-1) [[1, 2], [3, 4], [5, 6]]