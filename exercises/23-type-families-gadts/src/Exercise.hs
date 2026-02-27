{-# LANGUAGE GADTs               #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}
{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE KindSignatures      #-}
{-# LANGUAGE UndecidableInstances #-}

module Exercise
  ( Expr(..)
  , eval
  , HList(..)
  , hHead
  , hTail
  , Length
  ) where

import GHC.TypeLits (Nat, type (+))

-- ---------------------------------------------------------------------------
-- The GADT Expr encodes the *type* of the result in the type parameter.
-- This makes eval total and type-safe — it cannot return an Int where
-- the expression has type Bool.
-- ---------------------------------------------------------------------------

data Expr a where
  Lit     :: Int  -> Expr Int
  BoolLit :: Bool -> Expr Bool
  Add     :: Expr Int -> Expr Int -> Expr Int
  If      :: Expr Bool -> Expr a -> Expr a -> Expr a

-- | Evaluate a type-safe expression to its Haskell value.
-- Hint: pattern match on each constructor; recursively call eval on subterms.
eval :: Expr a -> a
eval = undefined

-- ---------------------------------------------------------------------------
-- HList is a heterogeneous list: each element may have a different type,
-- and the list of types is tracked in the type parameter.
-- HNil :: HList '[]
-- HCons :: t -> HList ts -> HList (t ': ts)
-- ---------------------------------------------------------------------------

data HList (ts :: [*]) where
  HNil  :: HList '[]
  HCons :: t -> HList ts -> HList (t ': ts)

-- | Return the first element of a non-empty HList.
hHead :: HList (t ': ts) -> t
hHead = undefined

-- | Return the tail of a non-empty HList.
hTail :: HList (t ': ts) -> HList ts
hTail = undefined

-- ---------------------------------------------------------------------------
-- Type family: compute the length of a type-level list at compile time.
-- This is a closed type family — GHC evaluates it during type-checking.
-- ---------------------------------------------------------------------------

type family Length (xs :: [*]) :: Nat where
  Length '[]       = 0
  Length (_ ': xs) = 1 + Length xs
