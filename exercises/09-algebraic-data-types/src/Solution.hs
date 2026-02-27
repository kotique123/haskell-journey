module Exercise
  ( Shape(..), area, perimeter
  , Direction(..), opposite
  , Person(..), fullName, isAdult
  ) where

data Shape
  = Circle Double
  | Rectangle Double Double
  | Triangle Double Double Double
  deriving (Show, Eq)

area :: Shape -> Double
area (Circle r)       = pi * r * r
area (Rectangle w h)  = w * h
area (Triangle a b c) = let s = (a + b + c) / 2
                         in sqrt (s * (s-a) * (s-b) * (s-c))

perimeter :: Shape -> Double
perimeter (Circle r)       = 2 * pi * r
perimeter (Rectangle w h)  = 2 * (w + h)
perimeter (Triangle a b c) = a + b + c

data Direction = North | South | East | West
  deriving (Show, Eq, Ord, Enum, Bounded)

opposite :: Direction -> Direction
opposite North = South
opposite South = North
opposite East  = West
opposite West  = East

data Person = Person
  { firstName :: String
  , lastName  :: String
  , age       :: Int
  } deriving (Show, Eq)

fullName :: Person -> String
fullName p = firstName p ++ " " ++ lastName p

isAdult :: Person -> Bool
isAdult p = age p >= 18
