{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE KindSignatures      #-}
{-# LANGUAGE TypeOperators       #-}
{-# LANGUAGE GADTs               #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module Exercise
  ( Vec(..)
  , vHead
  , vTail
  , vLength
  , vToList
  , vReplicate
  , symbolName
  ) where

import GHC.TypeLits (KnownNat, KnownSymbol, Nat, natVal, symbolVal, type (+))
import Data.Proxy   (Proxy(..))

-- | A length-indexed vector. The natural number @n@ lives at the type level,
-- so Vec 3 Int and Vec 4 Int are different types.
--
-- VNil  :: Vec 0 a
-- VCons :: a -> Vec n a -> Vec (n+1) a
data Vec (n :: Nat) a where
  VNil  :: Vec 0 a
  VCons :: a -> Vec n a -> Vec (n + 1) a

-- | Return the first element of a non-empty Vec.
-- The type (n+1) guarantees the compiler that VNil is impossible here.
vHead :: Vec (n + 1) a -> a
vHead = undefined

-- | Return everything after the first element.
vTail :: Vec (n + 1) a -> Vec n a
vTail = undefined

-- | Return the runtime length of the Vec.
-- Hint: use natVal (Proxy @n) :: Integer, then convert with fromIntegral.
vLength :: forall n a. KnownNat n => Vec n a -> Int
vLength = undefined

-- | Convert a Vec to a plain Haskell list.
vToList :: Vec n a -> [a]
vToList = undefined

-- | Build a Vec of length @n@ filled with the given element.
-- Hint: get the count from natVal (Proxy @n) and build recursively.
-- Note: this requires a creative solution — see the README for ideas.
vReplicate :: forall n a. KnownNat n => a -> Vec n a
vReplicate = undefined

-- | Return the type-level Symbol as a runtime String.
-- Call with: symbolName @"hello"
-- Hint: use symbolVal (Proxy @s).
symbolName :: forall s. KnownSymbol s => String
symbolName = undefined
