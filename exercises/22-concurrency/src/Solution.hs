module Exercise
  ( makeSharedCounter
  , STMStack(..), newSTMStack, pushSTM, popSTM
  , parallelMap
  , timeout'
  ) where

import Control.Concurrent.MVar
import Control.Concurrent.STM
import Control.Concurrent.Async (mapConcurrently)
import System.Timeout (timeout)

makeSharedCounter :: IO (IO (), IO Int)
makeSharedCounter = do
  mvar <- newMVar (0 :: Int)
  let inc = modifyMVar_ mvar (\n -> return (n + 1))
  let get = readMVar mvar
  return (inc, get)

data STMStack a = STMStack (TVar [a])

newSTMStack :: STM (STMStack a)
newSTMStack = STMStack <$> newTVar []

pushSTM :: a -> STMStack a -> STM ()
pushSTM x (STMStack tv) = modifyTVar tv (x :)

popSTM :: STMStack a -> STM (Maybe a)
popSTM (STMStack tv) = do
  xs <- readTVar tv
  case xs of
    []     -> return Nothing
    (x:ys) -> writeTVar tv ys >> return (Just x)

parallelMap :: (a -> IO b) -> [a] -> IO [b]
parallelMap = mapConcurrently

timeout' :: Int -> IO a -> IO (Maybe a)
timeout' = timeout
