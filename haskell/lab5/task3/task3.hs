import System.IO
import System.Environment (getArgs)
import System.Directory (doesFileExist, renameFile, removeFile)
import Control.Monad (when, unless)
import Control.Exception (try, IOException, bracketOnError)
import Data.Char (isAsciiLower, isAsciiUpper, toLower)
import Text.Read (readMaybe)

writeViaTemp :: FilePath -> String -> IO ()
writeViaTemp path newContent =
    bracketOnError
        (return (path ++ ".tmp"))
        (\tmp -> try (removeFile tmp) :: IO (Either IOException ()))
        (\tmp -> writeFile tmp newContent >> renameFile tmp path)

viewFile :: FilePath -> IO ()
viewFile path = do
    result <- try (readFile path) :: IO (Either IOException String)
    case result of
        Left e   -> putStrLn $ "Ошибка чтения файла: " ++ show e
        Right cs -> viewLines (lines cs) 0
    where
        viewLines :: [String] -> Int -> IO ()
        viewLines [] _ = return ()
        viewLines ls n = do
            let (chunk, rest) = splitAt 20 ls
            mapM_ putStrLn chunk
            let shown = n + length chunk
            if null rest
                then putStrLn $ "Показаны строки: " ++ show (n + 1) ++ "-" ++ show shown
                else do
                    putStrLn $ "Показаны строки: " ++ show (n + 1) ++ "-" ++ show shown
                            ++ ", осталось строк: " ++ show (length rest)
                    putStrLn "Нажмите Enter для продолжения или введите 'q' для выхода"
                    hFlush stdout
                    command <- getLine
                    unless (command == "q") $ viewLines rest shown

appendToFile :: FilePath -> String -> IO ()
appendToFile path newContent = do
    result <- try (readFile path) :: IO (Either IOException String)
    case result of
        Left e -> putStrLn $ "Ошибка чтения файла: " ++ show e
        Right contents -> do
            let sep = if null contents || last contents == '\n' then "" else "\n"
            writeViaTemp path (contents ++ sep ++ newContent ++ "\n")

deleteLine :: FilePath -> Int -> IO ()
deleteLine path lineNumber = do
    result <- try (readFile path) :: IO (Either IOException String)
    case result of
        Left e -> putStrLn $ "Ошибка чтения файла: " ++ show e
        Right contents -> do
            let ls = lines contents
            if lineNumber < 1 || lineNumber > length ls
                then putStrLn "Ошибка: неверный номер строки"
                else do
                    let (before, rest) = splitAt (lineNumber - 1) ls
                        after          = drop 1 rest
                    writeViaTemp path (unlines (before ++ after))
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
    result <- try (readFile sourcePath) :: IO (Either IOException String)
    case result of
        Left e -> putStrLn $ "Ошибка чтения файла: " ++ show e
        Right contents -> do
            let filteredContents = filter (\l -> filter1 l && filter2 l) (lines contents)
            writeViaTemp destPath (unlines filteredContents)
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
            case readMaybe nStr :: Maybe Int of
                Just k  -> deleteLine path k >> menu path
                Nothing -> putStrLn "Неверный номер" >> menu path

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
        [filePath] -> do
            exists <- doesFileExist filePath
            if exists
                then menu filePath
                else putStrLn $ "Ошибка: файл не найден: " ++ filePath
        _ -> putStrLn "Использование: <программа> <файл>"