module Exercise
  ( classify, grade, fizzbuzz, between, clamp
  ) where

classify :: (Ord a, Num a) => a -> String
classify x
  | x < 0    = "negative"
  | x == 0   = "zero"
  | otherwise = "positive"

grade :: Int -> String
grade n
  | n >= 90   = "A"
  | n >= 80   = "B"
  | n >= 70   = "C"
  | n >= 60   = "D"
  | otherwise = "F"

fizzbuzz :: Int -> String
fizzbuzz n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 3  == 0 = "Fizz"
  | n `mod` 5  == 0 = "Buzz"
  | otherwise       = show n

between :: Ord a => a -> a -> a -> Bool
between lo hi x = x >= lo && x <= hi

clamp :: Ord a => a -> a -> a -> a
clamp lo hi x
  | x < lo    = lo
  | x > hi    = hi
  | otherwise = x
