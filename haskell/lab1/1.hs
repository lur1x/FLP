module Main where

-- 1 решение
charA :: Char
charA = snd (fst ((1, 'a'), "abc"))

main :: IO ()
main = do
    print (charA)

-- charA = snd (fst ((1, 'a'), "abc"))
