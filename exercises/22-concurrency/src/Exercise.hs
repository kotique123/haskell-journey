module Exercise
  ( makeSharedCounter
  , STMStack(..)
  , newSTMStack
  , pushSTM
  , popSTM
  , parallelMap
  , timeout'
  ) where

import Control.Concurrent.MVar
import Control.Concurrent.STM
import Control.Concurrent.Async (mapConcurrently)
import System.Timeout (timeout)

-- | Create a shared counter backed by an MVar.
-- Returns (incrementAction, readAction).
-- Both actions can be called safely from multiple threads.
makeSharedCounter :: IO (IO (), IO Int)
makeSharedCounter = undefined

-- | A thread-safe stack backed by a TVar holding a list.
-- The head of the list is the top of the stack.
data STMStack a = STMStack (TVar [a])

-- | Create a new empty STMStack inside an STM transaction.
newSTMStack :: STM (STMStack a)
newSTMStack = undefined

-- | Push a value onto the top of the stack.
pushSTM :: a -> STMStack a -> STM ()
pushSTM = undefined

-- | Pop the top value; returns Nothing if empty.
-- Must be atomic: read and modify the TVar in a single transaction.
popSTM :: STMStack a -> STM (Maybe a)
popSTM = undefined

-- | Run all IO actions concurrently and collect results in order.
-- Hint: use mapConcurrently from Control.Concurrent.Async.
parallelMap :: (a -> IO b) -> [a] -> IO [b]
parallelMap = undefined

-- | Run an action with a microsecond timeout.
-- Returns Nothing if the action does not complete in time.
timeout' :: Int -> IO a -> IO (Maybe a)
timeout' = undefined
