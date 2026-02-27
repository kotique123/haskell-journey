{-# LANGUAGE LambdaCase      #-}
{-# LANGUAGE TupleSections   #-}
{-# LANGUAGE MultiWayIf      #-}
{-# LANGUAGE BlockArguments  #-}
{-# LANGUAGE NamedFieldPuns  #-}
{-# LANGUAGE RecordWildCards #-}

module Exercise
  ( describeWithLambdaCase
  , pairWithIndex
  , classify
  , Config(..)
  , formatConfig
  , defaultConfig
  ) where

-- | Describe a Maybe Int using \case (LambdaCase) syntax.
-- Nothing → "nothing", Just n → "just <n>"
-- You MUST use \case syntax — no manual lambda + case.
describeWithLambdaCase :: Maybe Int -> String
describeWithLambdaCase = undefined

-- | Pair each element with its 0-based index.
-- You MUST use a TupleSection somewhere, e.g. (i,) or (,x).
-- Expected: pairWithIndex "abc" == [(0,'a'),(1,'b'),(2,'c')]
pairWithIndex :: [a] -> [(Int, a)]
pairWithIndex = undefined

-- | Classify an Int using MultiWayIf syntax.
-- n < 0 → "neg", n == 0 → "zero", n < 100 → "small", else → "big"
-- You MUST use the MultiWayIf syntax (if | guard → expr).
classify :: Int -> String
classify = undefined

data Config = Config { host :: String, port :: Int } deriving (Show, Eq)

-- | Format a Config as "host:port" using NamedFieldPuns.
-- You MUST use {host, port} record-puns syntax in the pattern.
formatConfig :: Config -> String
formatConfig = undefined

-- | A default Config value.
defaultConfig :: Config
defaultConfig = undefined
