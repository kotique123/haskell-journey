module Exercise
  ( describeList, fst3, snd3, thd3, fibonacci, describeNumber, safeHead
  ) where

describeList :: [a] -> String
describeList []  = "empty"
describeList [_] = "singleton"
describeList _   = "longer list"

fst3 :: (a, b, c) -> a
fst3 (x, _, _) = x

snd3 :: (a, b, c) -> b
snd3 (_, y, _) = y

thd3 :: (a, b, c) -> c
thd3 (_, _, z) = z

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

describeNumber :: Int -> String
describeNumber 0 = "zero"
describeNumber 1 = "one"
describeNumber 2 = "two"
describeNumber n
  | n < 10    = "small"
  | otherwise = "large"

safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x
