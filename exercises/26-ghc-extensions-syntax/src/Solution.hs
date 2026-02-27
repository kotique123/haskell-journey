{-# LANGUAGE LambdaCase      #-}
{-# LANGUAGE TupleSections   #-}
{-# LANGUAGE MultiWayIf      #-}
{-# LANGUAGE BlockArguments  #-}
{-# LANGUAGE NamedFieldPuns  #-}
{-# LANGUAGE RecordWildCards #-}

module Exercise
  ( describeWithLambdaCase, pairWithIndex, classify
  , Config(..), formatConfig, defaultConfig
  ) where

describeWithLambdaCase :: Maybe Int -> String
describeWithLambdaCase = \case
  Nothing -> "nothing"
  Just n  -> "just " ++ show n

pairWithIndex :: [a] -> [(Int, a)]
pairWithIndex xs = zipWith (,) [0..] xs

classify :: Int -> String
classify n = if
  | n < 0     -> "neg"
  | n == 0    -> "zero"
  | n < 100   -> "small"
  | otherwise -> "big"

data Config = Config { host :: String, port :: Int } deriving (Show, Eq)

formatConfig :: Config -> String
formatConfig Config{host, port} = host ++ ":" ++ show port

defaultConfig :: Config
defaultConfig = Config { host = "localhost", port = 8080 }
