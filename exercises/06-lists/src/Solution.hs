module Exercise
  ( myLength, myReverse, mySum, pythagorean, runLengthEncode
  ) where

myLength :: [a] -> Int
myLength []     = 0
myLength (_:xs) = 1 + myLength xs

myReverse :: [a] -> [a]
myReverse []     = []
myReverse (x:xs) = myReverse xs ++ [x]

mySum :: [Int] -> Int
mySum []     = 0
mySum (x:xs) = x + mySum xs

pythagorean :: Int -> [(Int, Int, Int)]
pythagorean n = [(a,b,c) | c <- [1..n], b <- [1..c], a <- [1..b], a*a + b*b == c*c]

runLengthEncode :: Eq a => [a] -> [(Int, a)]
runLengthEncode [] = []
runLengthEncode (x:xs) =
  let (same, rest) = span (== x) xs
  in (1 + length same, x) : runLengthEncode rest
