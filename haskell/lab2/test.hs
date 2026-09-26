module Main where

import MyFunctions

-- 1. oddEven
-- oddEven [2,5,7,9,1,8] вернет [5,2,9,7,8,1]
-- oddEven [1,2,3,4] вернет [2,1,4,3]
-- oddEven [1,2,3] вернет [2,1,3]
-- oddEven [1] вернет [1]
-- oddEven ([] :: [Int]) вернет []
testOddEven :: IO ()
testOddEven = do
    print $ oddEven [2,5,7,9,1,8]
    print $ oddEven [1,2,3,4]
    print $ oddEven [1,2,3]
    print $ oddEven [1]
    print $ oddEven ([] :: [Int])

-- 2. insert
-- insert [1,2,3,4] 10 2 вернет [1,10,2,3,4]
-- insert [1,2,3,4] 5 1  вернет [5,1,2,3,4]
-- insert [1,2,3,4] 6 5  вернет [1,2,3,4,6]
-- insert [] 3 4 вернут [3]
testInsert :: IO ()
testInsert = do
    print $ insert [1,2,3,4] 10 2
    print $ insert [1,2,3,4] 5 1
    print $ insert [1,2,3,4] 6 5
    print $ insert [] 3 4

-- 3. listSum
-- listSum [1,2,3] [4,5,6] вернет [5,7,9]
-- listSum [1,2] [4,5,6] вернет [5,7,6]
-- listSum [1,2,3] [4,5] вернет [5,7,3]
testListSum :: IO ()
testListSum = do
    print $ listSum [1,2,3] [4,5,6]
    print $ listSum [1,2] [4,5,6]
    print $ listSum [1,2,3] [4,5]

-- 4. position
-- position [1,2,3,4,2] 2 вернет 2
-- position [1,2,3,4] 5 вернет 0
-- position [1,2,3,4] 1 вернет 1
testPosition :: IO ()
testPosition = do
    print $ position [1,2,3,4,2] 2
    print $ position [1,2,3,4] 5
    print $ position [1,2,3,4] 1

-- 5. sumF1
-- sumF1 5 вернет 15
-- sumF1 10 вернет 55
-- sumF1 0 вернет 0
testSumF1 :: IO ()
testSumF1 = do
    print $ sumF1 5
    print $ sumF1 10
    print $ sumF1 0

-- 6. sumF2
-- sumF2 5 вернет 10
-- sumF2 10 вернет 45
-- sumF2 0 вернет 0
testSumF2 :: IO ()
testSumF2 = do
    print $ sumF2 5
    print $ sumF2 10
    print $ sumF2 0

main :: IO ()
main = do
    testOddEven
    putStrLn "--------"
    testInsert
    putStrLn "--------"
    testListSum
    putStrLn "--------"
    testPosition
    putStrLn "--------"
    testSumF1
    putStrLn "--------"
    testSumF2