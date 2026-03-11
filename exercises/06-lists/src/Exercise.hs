module Exercise
  ( myLength
  , myReverse
  , mySum
  , pythagorean
  , runLengthEncode
  ) where

myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

mySum :: Num a => [a] -> a
mySum [] = 0
mySum (x:xs) = x + mySum xs

pythagorean :: Int -> [(Int, Int, Int)]
pythagorean n = [(a,b,c) | a <- [1..n],      -- a from 1 to n
                           b <- [a..n],      -- b from a to n (ensures a ≤ b)
                           c <- [b+1..n],    -- c from b+1 to n (ensures b < c)
                           a^2 + b^2 == c^2] -- Pythagorean condition

runLengthEncode :: Eq a => [a] -> [(Int, a)]
runLengthEncode [] = []                                    -- base case
runLengthEncode (x:xs) = (1 + length prefix, x) : runLengthEncode rest
  where
    (prefix, rest) = span (== x) xs
