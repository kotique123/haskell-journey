{-# LANGUAGE BangPatterns #-}

module Exercise
  ( lazySum, strictSum, naiveFib, memoFib, forceList, StrictPair(..), mkStrictPair
  ) where

import Data.List       (foldl')
import Control.DeepSeq (NFData, deepseq)

lazySum :: [Int] -> Int
lazySum = foldl (+) 0

strictSum :: [Int] -> Int
strictSum = foldl' (+) 0

naiveFib :: Int -> Integer
naiveFib 0 = 0
naiveFib 1 = 1
naiveFib n = naiveFib (n - 1) + naiveFib (n - 2)

memoFib :: Int -> Integer
memoFib n = fibs !! n
  where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

forceList :: NFData a => [a] -> [a]
forceList xs = xs `deepseq` xs

data StrictPair a b = StrictPair !a !b
  deriving (Show, Eq)

mkStrictPair :: a -> b -> StrictPair a b
mkStrictPair = StrictPair
