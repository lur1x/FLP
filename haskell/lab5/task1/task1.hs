import Text.Read (readMaybe)

generateList :: Int -> Int -> Int -> Either String [Int]
generateList start count step
    | count <= 0 = Left "Количество элементов должно быть больше 0"
    | step <= 0  = Left "Кратность должна быть больше 0"
    | otherwise  = Right (take count [first, first + step ..])
  where
    first = ((start + step - 1) `div` step) * step

readInt :: String -> IO Int
readInt prompt = do
    putStr prompt
    input <- getLine
    case readMaybe input of
        Just n  -> pure n
        Nothing -> do
            putStrLn "Ошибка: нужно ввести целое число."
            readInt prompt

main :: IO ()
main = do
    start <- readInt "Начальное значение: "
    count <- readInt "Количество элементов: "
    step  <- readInt "Кратность: "

    case generateList start count step of
        Left err -> putStrLn ("Ошибка: " ++ err)
        Right xs -> print xs