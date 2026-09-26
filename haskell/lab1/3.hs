odds1 :: Integer -> Integer -> [Integer]
-- принимает два Integer и возвращает список Integer
-- принимает первое число k и возвращает функцию, которая принимает второе число n и возвращает список
-- k - с какого нечётного числа начать; n - сколько чисел нужно сгенерировать.
odds1 k n =
    if n <= 0
        then []
        else k : odds1 (k + 2) (n - 1)

odds2 :: Integer -> [Integer]
odds2 n =
    let go :: Integer -> Integer -> [Integer]
        go _ 0 = []
        go k m = k : go (k + 2) (m - 1)
    in go 1 n

odds3 :: Integer -> [Integer]
odds3 n = go n []
  where
    go :: Integer -> [Integer] -> [Integer]
    go 0 acc = acc
    go k acc = go (k - 1) ((2 * k - 1) : acc)


main :: IO ()
main = do
    print (odds1 1 20)
    print (odds2 20)
    print (odds3 20)