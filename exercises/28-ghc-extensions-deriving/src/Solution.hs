{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveTraversable          #-}

module Exercise
  ( Dollars(..), Euros(..)
  , Sum(..), Product(..)
  , Tree(..), insert, fromList
  ) where

newtype Dollars = Dollars Int
  deriving stock   (Show, Eq, Ord)
  deriving newtype (Num, Enum, Real, Integral)

newtype Euros = Euros Int
  deriving stock   (Show, Eq, Ord)
  deriving newtype (Num, Enum, Real, Integral)

newtype Sum a = Sum { getSum :: a }
  deriving stock (Show, Eq)

instance Num a => Semigroup (Sum a) where
  Sum x <> Sum y = Sum (x + y)

instance Num a => Monoid (Sum a) where
  mempty = Sum 0

newtype Product a = Product { getProduct :: a }
  deriving stock (Show, Eq)

instance Num a => Semigroup (Product a) where
  Product x <> Product y = Product (x * y)

instance Num a => Monoid (Product a) where
  mempty = Product 1

data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving stock (Show, Eq, Functor, Foldable, Traversable)

insert :: Ord a => a -> Tree a -> Tree a
insert x Leaf = Node Leaf x Leaf
insert x (Node l v r)
  | x < v     = Node (insert x l) v r
  | x > v     = Node l v (insert x r)
  | otherwise = Node l v r

fromList :: Ord a => [a] -> Tree a
fromList = foldr insert Leaf
