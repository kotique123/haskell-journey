module Exercise
  ( addOne, safeSquareRoot, applyMaybe, liftAdd, cartesianProduct
  ) where

addOne :: Maybe Int -> Maybe Int
addOne = fmap (+1)

safeSquareRoot :: Double -> Maybe Double
safeSquareRoot x
  | x < 0    = Nothing
  | otherwise = Just (sqrt x)

applyMaybe :: Maybe (a -> b) -> Maybe a -> Maybe b
applyMaybe Nothing  _        = Nothing
applyMaybe _        Nothing  = Nothing
applyMaybe (Just f) (Just x) = Just (f x)

liftAdd :: Maybe Int -> Maybe Int -> Maybe Int
liftAdd = (<*>) . fmap (+)

cartesianProduct :: [a] -> [b] -> [(a, b)]
cartesianProduct xs ys = [(x, y) | x <- xs, y <- ys]
