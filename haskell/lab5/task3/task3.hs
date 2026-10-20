import System.IO
import System.Environment (getArgs)
import System.Directory (renameFile)
import Control.Monad (when, unless)
import Data.Char (isAsciiLower, isAsciiUpper, toLower)

viewFile :: FilePath -> IO ()
viewFile path = do
    contents <- readFile path
    viewLines (lines contents) 0
  where
    viewLines :: [String] -> Int -> IO ()
    viewLines [] _ = return ()
    viewLines ls n = do
        let (chunk, rest) = splitAt 20 ls
        mapM_ putStrLn chunk
        let shown     = n + length chunk
            remaining = length rest
        putStrLn $ "Показаны строки: " ++ show (n + 1) ++ "-" ++ show shown
                ++ ", осталось строк: " ++ show remaining
        when (not $ null rest) $ do
            putStrLn "Нажмите Enter для продолжения или введите 'q' для выхода"
            hFlush stdout
            command <- getLine
            unless (command == "q") $ viewLines rest shown

appendToFile :: FilePath -> String -> IO ()
appendToFile path newContent = do
    let tempPath = path ++ ".tmp"
    contents <- readFile path
    writeFile tempPath (contents ++ newContent ++ "\n")
    renameFile tempPath path

deleteLine :: FilePath -> Int -> IO ()
deleteLine path lineNumber = do
    contents <- readFile path
    let ls = lines contents
    if lineNumber < 1 || lineNumber > length ls
        then putStrLn "Ошибка: неверный номер строки"
        else do
            let (before, rest) = splitAt (lineNumber - 1) ls
                after          = drop 1 rest
            writeFile path (unlines (before ++ after))
            putStrLn $ "Строка " ++ show lineNumber ++ " удалена"

longLineFilter :: String -> Bool
longLineFilter line = length line > 15

isOnlyLatinLine :: String -> Bool
isOnlyLatinLine = all (\c -> isAsciiLower c || isAsciiUpper c || c == ' ')

filterByName :: String -> Maybe (String -> Bool)
filterByName name = case map toLower name of
    "latin" -> Just isOnlyLatinLine
    "long"  -> Just longLineFilter
    _       -> Nothing

copyWithFilters :: FilePath -> FilePath -> (String -> Bool) -> (String -> Bool) -> IO ()
copyWithFilters sourcePath destPath filter1 filter2 = do
    contents <- readFile sourcePath
    let filteredContents = filter (\l -> filter1 l && filter2 l) (lines contents)
    writeFile destPath (unlines filteredContents)
    putStrLn $ "Скопировано в " ++ destPath

menu :: FilePath -> IO ()
menu path = do
    putStrLn "\nВыберите операцию:"
    putStrLn "1 - просмотреть файл"
    putStrLn "2 - добавить текст"
    putStrLn "3 - удалить строку"
    putStrLn "4 - копировать с фильтрами"
    putStrLn "0 - выход"
    putStr "> "
    hFlush stdout
    cmd <- getLine
    case cmd of
        "1" -> do
            viewFile path
            menu path

        "2" -> do
            putStr "Текст для добавления: "
            hFlush stdout
            txt <- getLine
            appendToFile path txt
            menu path

        "3" -> do
            putStr "Номер строки (с 1): "
            hFlush stdout
            nStr <- getLine
            case reads nStr :: [(Int, String)] of
                [(k, "")] -> deleteLine path k >> menu path
                _         -> putStrLn "Неверный номер" >> menu path

        "4" -> do
            putStr "Целевой файл: "
            hFlush stdout
            dest <- getLine
            putStr "Первый фильтр (latin/long): "
            hFlush stdout
            f1 <- getLine
            putStr "Второй фильтр (latin/long): "
            hFlush stdout
            f2 <- getLine
            case (filterByName f1, filterByName f2) of
                (Just p1, Just p2) -> copyWithFilters path dest p1 p2 >> menu path
                _ -> putStrLn "Неверный фильтр. Используйте 'latin' или 'long'" >> menu path

        "0" -> putStrLn "Пока"
        _   -> putStrLn "Неизвестный выбор" >> menu path

main :: IO ()
main = do
    args <- getArgs
    case args of
        [filePath] -> menu filePath
        _          -> putStrLn "Использование: <программа> <файл>"