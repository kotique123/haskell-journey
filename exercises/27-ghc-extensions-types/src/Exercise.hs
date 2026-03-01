{-# LANGUAGE RankNTypes          #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module Exercise
  ( applyToInt
  , applyToBoth
  , showWithProxy
  , sizeOf
  ) where

-- | Accept a *polymorphic* function (one that works for any Num type)
-- and apply it to an Int.
-- The rank-2 type (forall a. Num a => a -> a) guarantees the function
-- must work for ALL Num types — not just Int.
applyToInt :: (forall a. Num a => a -> a) -> Int -> Int
applyToInt _ _ = undefined

-- | Apply the same polymorphic Num function to both elements of the pair.
applyToBoth :: (forall a. Num a => a -> a) -> (Int, Double) -> (Int, Double)
applyToBoth _ _ = undefined

-- | Parse a String into type @a@ using TypeApplications.
-- Call with: showWithProxy @Int "42"
-- Hint: use 'read' with a type application: read @a s
showWithProxy :: forall a. Read a => String -> a
showWithProxy = undefined

-- | Return (length, original list) using a ScopedTypeVariable annotation.
-- The type variable @a@ from the signature must be in scope inside.
sizeOf :: forall a. [a] -> (Int, [a])
sizeOf = undefined
