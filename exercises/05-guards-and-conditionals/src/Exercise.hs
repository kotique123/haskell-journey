module Exercise
  ( classify
  , grade
  , fizzbuzz
  , between
  , clamp
  ) where

classify :: (Ord a, Num a) => a -> String
classify n 
  | n < 0 = "negative"
  | n == 0 = "zero"
  | otherwise = "positive"

grade :: Int -> String
grade n
  | n >= 90 = "A"
  | n >= 80 && n < 90 = "B"
  | n >= 70 && n < 80 = "C"
  | n >= 60 && n < 70 = "D"
  | otherwise = "F"

fizzbuzz :: Int -> String
fizzbuzz n
  | n `mod` 3 == 0 && n `mod` 5 == 0 = "FizzBuzz"
  | n `mod` 3 == 0 = "Fizz"
  | n `mod` 5 == 0 = "Buzz"
  | otherwise = show n

between :: Ord a => a -> a -> a -> Bool
between lo hi n 
  | n >= lo && n <= hi = True
  | otherwise = False

clamp :: Ord a => a -> a -> a -> a
clamp lo hi n
  | n < lo = lo
  | n > hi = hi
  | otherwise = n
