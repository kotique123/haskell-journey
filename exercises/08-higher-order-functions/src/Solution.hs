module Exercise
  ( sumSquaresOfEvens, myZipWith, applyAll, countWhere, myIterate
  ) where

sumSquaresOfEvens :: [Int] -> Int
sumSquaresOfEvens = sum . map (^2) . filter even

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ [] _          = []
myZipWith _ _ []          = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

applyAll :: [a -> a] -> a -> a
applyAll fs x = foldl (flip ($)) x fs

countWhere :: (a -> Bool) -> [a] -> Int
countWhere p = length . filter p

myIterate :: (a -> a) -> a -> [a]
myIterate f x = x : myIterate f (f x)
