{-# LANGUAGE RankNTypes          #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module Exercise
  ( applyToInt, applyToBoth, showWithProxy, sizeOf, runST'
  ) where

import Control.Monad.ST (ST, runST)

applyToInt :: (forall a. Num a => a -> a) -> Int -> Int
applyToInt f x = f x

applyToBoth :: (forall a. Num a => a -> a) -> (Int, Double) -> (Int, Double)
applyToBoth f (x, y) = (f x, f y)

showWithProxy :: forall a. Read a => String -> a
showWithProxy = read @a

sizeOf :: forall a. [a] -> (Int, [a])
sizeOf xs = (length xs, xs)

runST' :: (forall s. ST s a) -> a
runST' = runST
