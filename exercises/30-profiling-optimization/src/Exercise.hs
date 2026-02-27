{-# LANGUAGE BangPatterns #-}
module Exercise
  ( lazySum
  , strictSum
  , naiveFib
  , memoFib
  , forceList
  , StrictPair(..)
  , mkStrictPair
  ) where

import Data.List      (foldl')
import Control.DeepSeq (NFData, deepseq)

-- | Sum a list using 'foldl' — this accumulates unevaluated thunks
-- and will cause a stack overflow on large lists (space leak).
lazySum :: [Int] -> Int
lazySum = undefined

-- | Sum a list using 'foldl'' — the strict version; no space leak.
-- This is the idiomatic way to sum in Haskell.
strictSum :: [Int] -> Int
strictSum = undefined

-- | Naive recursive Fibonacci — O(2^n) time.
-- fib 0 = 0, fib 1 = 1, fib n = fib(n-1) + fib(n-2)
naiveFib :: Int -> Integer
naiveFib = undefined

-- | Efficient O(n) Fibonacci using a self-referential list (memoization).
-- Hint: define fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
-- then memoFib n = fibs !! n
memoFib :: Int -> Integer
memoFib = undefined

-- | Fully evaluate a list to normal form before returning it.
-- Hint: use deepseq from Control.DeepSeq.
forceList :: NFData a => [a] -> [a]
forceList = undefined

-- | A pair with strict (bang-pattern) fields.
-- The '!' prevents thunk accumulation inside the pair.
data StrictPair a b = StrictPair !a !b
  deriving (Show, Eq)

-- | Constructor for StrictPair.
mkStrictPair :: a -> b -> StrictPair a b
mkStrictPair = undefined
