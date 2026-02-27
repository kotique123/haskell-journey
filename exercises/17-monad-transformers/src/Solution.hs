module Exercise
  ( AppM, increment, guardPositive, runApp
  , ConfigM, greetUser, safeReadFile
  ) where

import Control.Monad.Except
import Control.Monad.State
import Control.Monad.Reader
import Control.Exception (try, IOException)

type AppM a = ExceptT String (State Int) a

increment :: AppM ()
increment = lift $ modify (+1)

guardPositive :: Int -> AppM Int
guardPositive n
  | n <= 0    = throwError "non-positive"
  | otherwise = return n

runApp :: AppM a -> Int -> (Either String a, Int)
runApp m s = runState (runExceptT m) s

type ConfigM a = ReaderT String IO a

greetUser :: String -> ConfigM String
greetUser name = do
  prefix <- ask
  return (prefix ++ " " ++ name)

safeReadFile :: FilePath -> ExceptT String IO String
safeReadFile path = do
  result <- liftIO (try (readFile path) :: IO (Either IOException String))
  case result of
    Left  err     -> throwError (show err)
    Right content -> return content
