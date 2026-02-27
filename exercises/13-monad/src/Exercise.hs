module Exercise
  ( safeDiv3
  , lookupChain
  , sequenceMaybe
  , whenJust
  , replicateM'
  ) where

safeDiv3 :: Int -> Int -> Int -> Maybe Int
safeDiv3 = undefined

lookupChain :: String -> [(String, String)] -> Maybe String
lookupChain = undefined

sequenceMaybe :: [Maybe a] -> Maybe [a]
sequenceMaybe = undefined

whenJust :: Maybe a -> (a -> IO b) -> IO (Maybe b)
whenJust = undefined

replicateM' :: Monad m => Int -> m a -> m [a]
replicateM' = undefined
