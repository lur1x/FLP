module Main where

pyramidalF :: Integer -> Integer
pyramidalF n = n * (n + 1) * (2 * n + 1) `div` 6

pyramidal50 :: [Integer]
pyramidal50 = go 1 50
  where
    go :: Integer -> Integer -> [Integer]
    go _ 0 = []
    go k m = pyramidalF k : go (k + 1) (m - 1)

main :: IO ()
main = do
    print pyramidal50