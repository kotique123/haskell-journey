module Exercise
  ( describeList
  , fst3
  , snd3
  , thd3
  , fibonacci
  , describeNumber
  , safeHead
  ) where

describeList :: [a] -> String
describeList [] = "empty"
describeList [_] = "singleton"
describeList (x:xs) = "longer list"


fst3 :: (a, b, c) -> a
fst3 (a,_,_) = a 

snd3 :: (a, b, c) -> b
snd3 (_,b,_) = b

thd3 :: (a, b, c) -> c
thd3 (_,_,c) = c

fibonacci :: Int -> Int
fibonacci num = case num of
  0 -> 0
  1 -> 1
  num -> num + fibonacci(num - 1)


describeNumber :: Int -> String
describeNumber num = case num of
  0 -> "zero"
  1 -> "one"
  2 -> "two"
  _ | num >= 3 && num <= 9 -> "small"
    | otherwise -> "large"

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x