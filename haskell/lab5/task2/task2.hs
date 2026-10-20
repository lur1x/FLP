import System.Environment (getArgs)
import System.IO (hFlush, stdout)
import Data.Char (isPunctuation)

replacePunctuation :: Char -> String -> String
replacePunctuation newChar = map replace
  where
    replace x
        isPunctuation x = newChar
      | otherwise       = x

processFile :: FilePath -> FilePath -> Char -> IO ()
processFile sourceFile targetFile replaceChar = do
  content <- readFile sourceFile
  let newContent = replacePunctuation replaceChar content
  writeFile targetFile newContent

main :: IO ()
main = do
  args <- getArgs
  case args of
    [sourceFile, targetFile] -> do
      putStr "Введите символ для замены знаков пунктуации: "
      hFlush stdout
      input <- getLine
      case input of
        (c:_) -> processFile sourceFile targetFile c
        []    -> putStrLn "Ошибка: символ не введён"
    _ -> putStrLn "Использование: program <исходный_файл> <целевой_файл>"