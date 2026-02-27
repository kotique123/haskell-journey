{-# LANGUAGE DataKinds                #-}
{-# LANGUAGE KindSignatures           #-}
{-# LANGUAGE TypeOperators            #-}
{-# LANGUAGE GADTs                    #-}
{-# LANGUAGE ScopedTypeVariables      #-}
{-# LANGUAGE TypeApplications         #-}
{-# LANGUAGE AllowAmbiguousTypes      #-}
{-# LANGUAGE ExistentialQuantification #-}

module Exercise
  ( Vec(..), vHead, vTail, vLength, vToList, vReplicate, symbolName
  ) where

import GHC.TypeLits  (KnownNat, KnownSymbol, Nat, natVal, symbolVal, type (+))
import Data.Proxy    (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)

data Vec (n :: Nat) a where
  VNil  :: Vec 0 a
  VCons :: a -> Vec n a -> Vec (n + 1) a

vHead :: Vec (n + 1) a -> a
vHead (VCons x _) = x

vTail :: Vec (n + 1) a -> Vec n a
vTail (VCons _ xs) = unsafeCoerce xs

vLength :: forall n a. KnownNat n => Vec n a -> Int
vLength _ = fromIntegral (natVal (Proxy @n))

vToList :: Vec n a -> [a]
vToList VNil         = []
vToList (VCons x xs) = x : vToList xs

data SomeVec a = forall n. SomeVec (Vec n a)

buildVec :: Int -> a -> SomeVec a
buildVec 0 _ = SomeVec VNil
buildVec n x = case buildVec (n - 1) x of
  SomeVec v -> SomeVec (VCons x v)

vReplicate :: forall n a. KnownNat n => a -> Vec n a
vReplicate x =
  let k = fromIntegral (natVal (Proxy @n))
  in case buildVec k x of
       SomeVec v -> unsafeCoerce v

symbolName :: forall s. KnownSymbol s => String
symbolName = symbolVal (Proxy @s)
