{-# LANGUAGE BangPatterns #-}
module Exercise
  ( naturals
  , fibs
  , primes
  , strictSum
  , collatz
  ) where

import Data.List (foldl', unfoldr)

-- | Infinite list of positive integers: 1, 2, 3, …
naturals :: [Integer]
naturals = undefined -- TODO: implement

-- | Infinite Fibonacci sequence: 0, 1, 1, 2, 3, 5, 8, …
fibs :: [Integer]
fibs = undefined -- TODO: implement

-- | Infinite list of prime numbers via a lazy sieve.
primes :: [Integer]
primes = undefined -- TODO: implement

-- | Sum a list strictly (no space leak).
strictSum :: [Int] -> Int
strictSum = undefined -- TODO: implement

-- | Generate the Collatz sequence from n to 1 (inclusive).
collatz :: Integer -> [Integer]
collatz = undefined -- TODO: implement
