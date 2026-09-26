module Main where

triangular50 :: [Integer]
triangular50 = go 1 1 50
  where
    go :: Integer -> Integer -> Integer -> [Integer]
    go _ _ 0 = []
    go k t m = t : go (k + 1) (t + k + 1) (m - 1)


main :: IO ()
main = do
    print triangular50