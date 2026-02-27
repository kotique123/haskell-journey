module Exercise
  ( Color(..), allColors
  , Describable(..)
  , Container(..), Stack(..)
  ) where

data Color = Red | Green | Blue
  deriving (Show, Eq, Ord, Enum, Bounded)

allColors :: [Color]
allColors = [Red, Green, Blue]

class Describable a where
  toDescription :: a -> String

instance Describable Color where
  toDescription Red   = "red"
  toDescription Green = "green"
  toDescription Blue  = "blue"

instance Describable Bool where
  toDescription True  = "yes"
  toDescription False = "no"

class Container f where
  empty  :: f a
  insert :: a -> f a -> f a
  toList :: f a -> [a]

newtype Stack a = Stack [a]
  deriving (Show, Eq)

instance Container Stack where
  empty               = Stack []
  insert x (Stack xs) = Stack (x : xs)
  toList (Stack xs)   = xs
