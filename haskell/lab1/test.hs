-- 1 задание
charA :: Char
charA = snd (fst ((1, 'a'), "abc"))

-- 2 задание
b1 :: Char
b1 = head (tail ['a', 'b', 'c'])

b2 :: Char
b2 = head (tail (head [['a', 'b'], ['c', 'd']]))

b3 :: Char
b3 = head (tail (head (tail [['a', 'c', 'd'], ['a', 'b']])))

b4 :: Char
b4 = head (head (tail [['a', 'd'], ['b', 'c']]))

-- 3 задание
odds1 :: Integer -> Int -> [Integer]
odds1 _ 0 = []
odds1 k n = k : odds1 (k + 2) (n - 1)

odds2 :: Int -> [Integer]
odds2 n = go 1 n
  where
    go :: Integer -> Int -> [Integer]
    go _ 0 = []
    go k m = k : go (k + 2) (m - 1)

odds3 :: Int -> [Integer]
odds3 n =
    let go _ 0 = []
        go k m = k : go (k + 2) (m - 1)
    in go 1 n
   
-- 4 задание 
triangular50 :: [Integer]
triangular50 = go 1 1 50
  where
    go :: Integer -> Integer -> Integer -> [Integer]
    go _ _ 0 = []
    go k t m = t : go (k + 1) (t + k + 1) (m - 1)

-- 5 задание
pyramidal50 :: [Integer]
pyramidal50 = go 1 1 50
  where
    go :: Integer -> Integer -> Integer -> [Integer]
    go _ _ 0 = []
    go k p m = p : go (k + 1) (p + (k + 1) * (k + 1)) (m - 1)

main :: IO ()
  
main = do

    -- 1 задание
    putStr "N1:"
    print (charA)
        
    -- 2 задание
    putStr "N2:"
    print b1
    
    putStr "N2:"
    print b2
    
    putStr "N2:"
    print b3
    
    putStr "N2:"
    print b4
    
    -- 3 задание
    putStr "N3:"
    print (odds1 1 20)
    
    putStr "N3:"
    print (odds2 20)
    
    putStr "N3:"
    print (odds3 20)
    
    -- 4 задание
    putStr "N4:"
    print triangular50
    
    
    -- 5 задание
    putStr "N5:"
    print pyramidal50
    