{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DeriveTraversable          #-}

module Exercise
  ( Dollars(..)
  , Euros(..)
  , Sum(..)
  , Product(..)
  , Tree(..)
  , insert
  , fromList
  ) where

-- | A newtype for US dollars.
-- Use 'deriving newtype' to inherit Num/Enum/Real/Integral from Int,
-- so you can write: Dollars 5 + Dollars 3
newtype Dollars = Dollars Int
  deriving stock   (Show, Eq, Ord)
  deriving newtype (Num, Enum, Real, Integral)

-- | A newtype for Euros — same pattern as Dollars.
newtype Euros = Euros Int
  deriving stock   (Show, Eq, Ord)
  deriving newtype (Num, Enum, Real, Integral)

-- | A wrapper that turns any Num type into a Monoid under addition.
newtype Sum a = Sum { getSum :: a }
  deriving stock (Show, Eq)

-- Implement (<>) as addition and mempty as 0.
instance Num a => Semigroup (Sum a) where
  (<>) = undefined

instance Num a => Monoid (Sum a) where
  mempty = undefined

-- | A wrapper that turns any Num type into a Monoid under multiplication.
newtype Product a = Product { getProduct :: a }
  deriving stock (Show, Eq)

-- Implement (<>) as multiplication and mempty as 1.
instance Num a => Semigroup (Product a) where
  (<>) = undefined

instance Num a => Monoid (Product a) where
  mempty = undefined

-- | A binary tree with Functor, Foldable, and Traversable derived via 'stock'.
-- GHC can generate these mechanically; you get toList, fmap, traverse for free.
data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving stock (Show, Eq, Functor, Foldable, Traversable)

-- | Insert a value into a BST, ignoring duplicates.
insert :: Ord a => a -> Tree a -> Tree a
insert = undefined

-- | Build a BST from a list.
fromList :: Ord a => [a] -> Tree a
fromList = undefined
