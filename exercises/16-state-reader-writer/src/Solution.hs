module Exercise
  ( stackPush, stackPop, stackSize
  , Config(..), getRetryMessage
  , logComputation, runStack
  ) where

import Control.Monad (foldM)
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Writer
import Data.Tuple (swap)

stackPush :: a -> State [a] ()
stackPush x = modify (x :)

stackPop :: State [a] (Maybe a)
stackPop = do
  s <- get
  case s of
    []     -> return Nothing
    (x:xs) -> put xs >> return (Just x)

stackSize :: State [a] Int
stackSize = gets length

data Config = Config { maxRetries :: Int, timeout :: Int } deriving (Show, Eq)

getRetryMessage :: Reader Config String
getRetryMessage = do
  cfg <- ask
  return $ "Will retry " ++ show (maxRetries cfg) ++ " times with timeout " ++ show (timeout cfg)

logComputation :: Int -> Writer [String] Int
logComputation n = foldM step 1 [1..n]
  where
    step :: Int -> Int -> Writer [String] Int
    step acc i = do
      let result = acc * i
      tell [show i ++ "! = " ++ show result]
      return result

runStack :: [a] -> State [a] b -> ([a], b)
runStack s m = swap (runState m s)
