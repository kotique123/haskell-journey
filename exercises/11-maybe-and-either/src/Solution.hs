module Exercise
  ( safeDiv, safeIndex, chainMaybe, parseAge, validateName
  ) where

import Text.Read (readMaybe)

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv a b = Just (a `div` b)

safeIndex :: [a] -> Int -> Maybe a
safeIndex xs i
  | i < 0 || i >= length xs = Nothing
  | otherwise               = Just (xs !! i)

chainMaybe :: Maybe Int -> Maybe Int
chainMaybe mx = do
  x <- mx
  y <- safeDiv x 2
  z <- safeDiv 6 y
  return (z * 2)

parseAge :: String -> Either String Int
parseAge s = case readMaybe s of
  Nothing -> Left "not a number"
  Just n  -> if n <= 0
               then Left "age must be positive"
               else Right n

validateName :: String -> Either String String
validateName s
  | length s < 2 = Left "name too short"
  | otherwise    = Right s
