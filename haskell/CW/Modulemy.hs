module Modulemy
    (
        ex1,
        ex2,
        ex3,
        ex4
    ) where

import Data.List (groupBy, sortBy)
import Data.Char (isSpace, toLower)
import Control.Exception (IOException, catch)


ex1 :: [Int] -> [[Int]]
ex1 [] = []
ex1 (x:xs) = go [x] (even x) xs
    where
        go acc _ [] = [reverse acc]
        go acc p (y:ys)
            | even y == p = go (y:acc) p ys
            | otherwise = reverse acc : go [y] (even y) ys

isSquare :: Int -> Bool
isSquare n =
    let r = floor (sqrt (fromIntegral n :: Double))
    in r * r == n

pairs :: [(Int, Int)]
pairs =
    [ (a, b)
    | a <- [1..600]
    , b <- [a..600]
    , isSquare (a*a + b*b)
    ]

ex2 :: Int -> [[Int]]
ex2 n =
    sortBy compareSum
        [ [a, b, c, s]
        | (a, b) <- pairs
        , (x, c) <- pairs
        , x == a
        , b <= c
        , isSquare (b*b + c*c)
        , let s = a + b + c
        , s >= n
        ]
    where
        compareSum x y = compare (last x) (last y)

ex3 :: [Int] -> [Int] -> [Int]
ex3 xs ys
    | length xs /= length ys = error "error"
    | any (== 0) ys = error "error"
    | otherwise = go 0 xs ys
  where
    go _ [] [] = []

    go i (x:xs) (y:ys)
        | x `mod` y == 0 = i : go (i + 1) xs ys
        | otherwise = go (i + 1) xs ys

    go _ _ _ = error "error"
    
trimLine :: String -> String
trimLine s =
    dropWhile isSpace
        (reverse (dropWhile isSpace (reverse s)))


lowerChar :: Char -> Char
lowerChar c
    | c >= 'А' && c <= 'Я' = toEnum (fromEnum c + 32)
    | c == 'Ё' = 'ё'
    | otherwise = toLower c


normalizeLine :: String -> String
normalizeLine = map lowerChar . trimLine


duplicateLines :: [String] -> [String]
duplicateLines [] = []

duplicateLines (x:xs)
    | x `elem` xs = x : duplicateLines (filter (/= x) xs)
    | otherwise = duplicateLines xs


ex4 :: FilePath -> FilePath -> IO ()
ex4 inputFile outputFile =
    catch
        (do
            contents <- readFile inputFile
            let normalized = map normalizeLine (lines contents)
            writeFile outputFile
                (unlines (duplicateLines normalized))
        )
        handleIOError
    where
        handleIOError :: IOException -> IO ()
        handleIOError _ = putStrLn "error"