{-# LANGUAGE GADTs               #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}
{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE KindSignatures      #-}
{-# LANGUAGE UndecidableInstances #-}

module Exercise
  ( Expr(..), eval
  , HList(..), hHead, hTail
  , Length
  ) where

import GHC.TypeLits (Nat, type (+))

data Expr a where
  Lit     :: Int  -> Expr Int
  BoolLit :: Bool -> Expr Bool
  Add     :: Expr Int -> Expr Int -> Expr Int
  If      :: Expr Bool -> Expr a -> Expr a -> Expr a

eval :: Expr a -> a
eval (Lit n)       = n
eval (BoolLit b)   = b
eval (Add e1 e2)   = eval e1 + eval e2
eval (If b t f)    = if eval b then eval t else eval f

data HList (ts :: [*]) where
  HNil  :: HList '[]
  HCons :: t -> HList ts -> HList (t ': ts)

hHead :: HList (t ': ts) -> t
hHead (HCons x _) = x

hTail :: HList (t ': ts) -> HList ts
hTail (HCons _ xs) = xs

type family Length (xs :: [*]) :: Nat where
  Length '[]       = 0
  Length (_ ': xs) = 1 + Length xs
