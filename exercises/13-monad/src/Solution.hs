module Exercise
  ( safeDiv3, lookupChain, sequenceMaybe, whenJust, replicateM'
  ) where

safeDiv3 :: Int -> Int -> Int -> Maybe Int
safeDiv3 x y z = do
  a <- if y == 0 then Nothing else Just (x `div` y)
  if z == 0 then Nothing else Just (a `div` z)

lookupChain :: String -> [(String, String)] -> Maybe String
lookupChain key table = do
  mid <- lookup key table
  lookup mid table

sequenceMaybe :: [Maybe a] -> Maybe [a]
sequenceMaybe []     = Just []
sequenceMaybe (x:xs) = do
  v  <- x
  vs <- sequenceMaybe xs
  return (v : vs)

whenJust :: Maybe a -> (a -> IO b) -> IO (Maybe b)
whenJust Nothing  _      = return Nothing
whenJust (Just x) action = fmap Just (action x)

replicateM' :: Monad m => Int -> m a -> m [a]
replicateM' 0 _ = return []
replicateM' n m = do
  x  <- m
  xs <- replicateM' (n-1) m
  return (x : xs)
