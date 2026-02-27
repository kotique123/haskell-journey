module Exercise
  ( AppM
  , increment
  , guardPositive
  , runApp
  , ConfigM
  , greetUser
  , safeReadFile
  ) where

import Control.Monad.Except
import Control.Monad.State
import Control.Monad.Reader
import Control.Exception (try, IOException)

-- | A transformer stack: ExceptT String on top of State Int.
-- Gives us error-handling AND mutable state in the same computation.
type AppM a = ExceptT String (State Int) a

-- | Increment the integer counter in the State layer.
increment :: AppM ()
increment = undefined -- TODO: implement

-- | If n <= 0, throw "non-positive"; otherwise return n unchanged.
guardPositive :: Int -> AppM Int
guardPositive = undefined -- TODO: implement

-- | Run the AppM stack from an initial counter value.
runApp :: AppM a -> Int -> (Either String a, Int)
runApp = undefined -- TODO: implement

-- | A Reader monad transformer over IO, carrying a String prefix.
type ConfigM a = ReaderT String IO a

-- | Prepend the String from the Reader environment to the given name.
greetUser :: String -> ConfigM String
greetUser = undefined -- TODO: implement

-- | Read a file, converting any IOException into a Left String.
safeReadFile :: FilePath -> ExceptT String IO String
safeReadFile = undefined -- TODO: implement
