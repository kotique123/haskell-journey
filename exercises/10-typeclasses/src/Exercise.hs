module Exercise
  ( Color(..)
  , allColors
  , Describable(..)
  , Container(..)
  , Stack(..)
  ) where

data Color = Red | Green | Blue
  deriving (Show, Eq, Ord, Enum, Bounded)

allColors :: [Color]
allColors = undefined

class Describable a where
  toDescription :: a -> String

instance Describable Color where
  toDescription = undefined

instance Describable Bool where
  toDescription = undefined

class Container f where
  empty  :: f a
  insert :: a -> f a -> f a
  toList :: f a -> [a]

newtype Stack a = Stack [a]
  deriving (Show, Eq)

instance Container Stack where
  empty  = undefined
  insert = undefined
  toList = undefined
