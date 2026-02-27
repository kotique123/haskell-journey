{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Exercise
  ( Color(..)
  , Point(..)
  , Celsius(..)
  , Fahrenheit(..)
  , toFahrenheit
  , toCelsius
  ) where

import GHC.Generics (Generic)
import Data.Aeson   (ToJSON, FromJSON)

-- ---------------------------------------------------------------------------
-- The empty instance bodies below are intentional. Because Color derives
-- Generic, Aeson can generate the serialisation code automatically.
-- Your job: understand *why* these compile and what they produce.
-- ---------------------------------------------------------------------------

data Color = Red | Green | Blue
  deriving stock (Show, Eq, Generic)

instance ToJSON   Color
instance FromJSON Color

-- ---------------------------------------------------------------------------
-- Point uses Generic-derived JSON with named fields (record syntax).
-- ---------------------------------------------------------------------------

data Point = Point { x :: Double, y :: Double }
  deriving stock (Show, Eq, Generic)

instance ToJSON   Point
instance FromJSON Point

-- ---------------------------------------------------------------------------
-- Celsius uses 'deriving newtype' so that all Num/Fractional operations
-- work directly on Celsius values without manual unwrapping.
-- ---------------------------------------------------------------------------

newtype Celsius = Celsius Double
  deriving stock    (Show, Eq)
  deriving newtype  (Num, Fractional)

newtype Fahrenheit = Fahrenheit Double
  deriving stock (Show, Eq)

-- | Convert Celsius to Fahrenheit. Formula: F = C * 9/5 + 32
toFahrenheit :: Celsius -> Fahrenheit
toFahrenheit = undefined

-- | Convert Fahrenheit to Celsius. Formula: C = (F - 32) * 5/9
toCelsius :: Fahrenheit -> Celsius
toCelsius = undefined
