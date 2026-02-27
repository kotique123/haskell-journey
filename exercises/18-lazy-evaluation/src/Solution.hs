{-# LANGUAGE BangPatterns #-}
module Exercise
  ( naturals, fibs, primes, strictSum, collatz
  ) where

import Data.List (foldl', unfoldr)

naturals :: [Integer]
naturals = [1..]

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

primes :: [Integer]
primes = sieve [2..]
  where
    sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p /= 0]
    sieve []     = []

strictSum :: [Int] -> Int
strictSum = foldl' (+) 0

collatz :: Integer -> [Integer]
collatz = unfoldr step
  where
    step 0 = Nothing
    step 1 = Just (1, 0)
    step n
      | even n    = Just (n, n `div` 2)
      | otherwise = Just (n, 3*n + 1)
