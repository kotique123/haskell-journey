{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Exercise
  ( Color(..), Point(..)
  , Celsius(..), Fahrenheit(..)
  , toFahrenheit, toCelsius
  ) where

import GHC.Generics (Generic)
import Data.Aeson   (ToJSON, FromJSON)

data Color = Red | Green | Blue
  deriving stock (Show, Eq, Generic)

instance ToJSON   Color
instance FromJSON Color

data Point = Point { x :: Double, y :: Double }
  deriving stock (Show, Eq, Generic)

instance ToJSON   Point
instance FromJSON Point

newtype Celsius = Celsius Double
  deriving stock    (Show, Eq)
  deriving newtype  (Num, Fractional)

newtype Fahrenheit = Fahrenheit Double
  deriving stock (Show, Eq)

toFahrenheit :: Celsius -> Fahrenheit
toFahrenheit (Celsius c) = Fahrenheit (c * 9/5 + 32)

toCelsius :: Fahrenheit -> Celsius
toCelsius (Fahrenheit f) = Celsius ((f - 32) * 5/9)
