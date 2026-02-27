module Exercise
  ( Shape(..)
  , area
  , perimeter
  , Direction(..)
  , opposite
  , Person(..)
  , fullName
  , isAdult
  ) where

data Shape
  = Circle Double
  | Rectangle Double Double
  | Triangle Double Double Double
  deriving (Show, Eq)

area :: Shape -> Double
area = undefined

perimeter :: Shape -> Double
perimeter = undefined

data Direction = North | South | East | West
  deriving (Show, Eq, Ord, Enum, Bounded)

opposite :: Direction -> Direction
opposite = undefined

data Person = Person
  { firstName :: String
  , lastName  :: String
  , age       :: Int
  } deriving (Show, Eq)

fullName :: Person -> String
fullName = undefined

isAdult :: Person -> Bool
isAdult = undefined
