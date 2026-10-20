module Main where

import MyFunctions
import qualified Data.Map as M
import qualified Data.Set as S

-- Функция для проверки: сравнивает ожидаемое и фактическое значения
myTest :: (Eq a, Show a) => a -> a -> IO ()
myTest expected actual
  | expected == actual = putStrLn $ "Test passed: " ++ show actual
  | otherwise          = putStrLn $ "Test failed: expected " ++ show expected ++ ", but got " ++ show actual

main :: IO ()
main = do
  putStrLn "=== Тесты myUnion ==="
  myTest [1,2,3,4] (myUnion [1,2,3] [2,3,4])
  myTest [1,2,2,3] (myUnion [1,2,2] [2,3])
  myTest [1,2]     (myUnion [] [1,2])
  myTest [1,1,2]   (myUnion [1,1] [1,2])

  putStrLn "\n=== Тесты myUnion' ==="
  myTest [1,2,3,4] (myUnion' [1,2,3] [2,3,4])
  myTest [1,2,2,3] (myUnion' [1,2,2] [2,3])
  myTest [1,2]     (myUnion' [] [1,2])
  myTest [1,1,2]   (myUnion' [1,1] [1,2])

  putStrLn "\n=== Тесты mySplitAt ==="
  myTest ("ab", "cdef") (mySplitAt 2 "abcdef")
  myTest ([], [1,2,3])  (mySplitAt 0 [1,2,3])
  myTest ([1,2,3], [])  (mySplitAt 10 [1,2,3])
  myTest ([], [1,2])    (mySplitAt (-5) [1,2])

  putStrLn "\n=== Тесты mySplitAt' ==="
  myTest ("ab", "cdef") (mySplitAt' 2 "abcdef")
  myTest ([], [1,2,3])  (mySplitAt' 0 [1,2,3])
  myTest ([1,2,3], [])  (mySplitAt' 10 [1,2,3])
  myTest ([], [1,2])    (mySplitAt' (-5) [1,2])

  putStrLn "\n=== Тесты myIsDigit ==="
  myTest True  (myIsDigit '7')
  myTest False (myIsDigit 'a')
  myTest False (myIsDigit ' ')

  putStrLn "\n=== Тесты myIsDigit' ==="
  myTest True  (myIsDigit' '7')
  myTest False (myIsDigit' 'a')
  myTest False (myIsDigit' ' ')

  putStrLn "\n=== Тесты myLookup ==="
  let map1 = M.fromList [("a",1), ("b",2)]
  myTest (Just 1)  (myLookup "a" map1)
  myTest Nothing   (myLookup "c" map1)
  myTest (Nothing :: Maybe Int) (myLookup "1" (M.empty :: M.Map String Int))

  putStrLn "\n=== Тесты myDelete ==="
  let set1 = S.fromList [1,2,3] :: S.Set Int
  myTest (S.fromList [1,3]) (myDelete 2 set1)
  myTest set1               (myDelete 5 set1)
  myTest S.empty            (myDelete 1 S.empty)

  putStrLn "\n=== Тесты myDelete' ==="
  myTest (S.fromList [1,3]) (myDelete' 2 set1)
  myTest set1               (myDelete' 5 set1)
  myTest S.empty            (myDelete' 1 S.empty)