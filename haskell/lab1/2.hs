b1 :: Char
b1 = head (tail ['a', 'b', 'c'])

b2 :: Char
b2 = head (tail (head [['a', 'b'], ['c', 'd']]))

b3 :: Char
b3 = head (tail (head (tail [['a', 'c', 'd'], ['a', 'b']])))

b4 :: Char
b4 = head (head (tail [['a', 'd'], ['b', 'c']]))

main :: IO ()
main = do
    print b1
    print b2
    print b3
    print b4
    