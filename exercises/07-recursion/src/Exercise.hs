module Exercise
  ( myMap
  , myFilter
  , myFoldr
  , myTake
  , flatten
  ) where

myMap :: (a -> b) -> [a] -> [b]
myMap _ []     = []
myMap f (x:xs) = f x : myMap f xs

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter = undefined

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr = undefined

myTake :: Int -> [a] -> [a]
myTake = undefined

flatten :: [[a]] -> [a]
flatten = undefined
