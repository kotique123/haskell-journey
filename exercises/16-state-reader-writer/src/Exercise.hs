module Exercise
  ( stackPush
  , stackPop
  , stackSize
  , Config(..)
  , getRetryMessage
  , logComputation
  , runStack
  ) where

import Control.Monad (foldM)
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Writer
import Data.Tuple (swap)

-- | Push a value onto the stack (list head = top of stack).
stackPush :: a -> State [a] ()
stackPush = undefined -- TODO: implement using `modify`

-- | Pop the top value; returns Nothing if the stack is empty.
stackPop :: State [a] (Maybe a)
stackPop = undefined -- TODO: implement

-- | Return the current stack depth without modifying it.
stackSize :: State [a] Int
stackSize = undefined -- TODO: implement

data Config = Config { maxRetries :: Int, timeout :: Int } deriving (Show, Eq)

-- | Produce a message like "Will retry 3 times with timeout 30" from Config.
getRetryMessage :: Reader Config String
getRetryMessage = undefined -- TODO: implement

-- | Compute the factorial of n, logging each step "k! = result" via Writer.
logComputation :: Int -> Writer [String] Int
logComputation = undefined -- TODO: implement

-- | Run a State action from an initial stack; return (finalStack, result).
runStack :: [a] -> State [a] b -> ([a], b)
runStack = undefined -- TODO: implement
