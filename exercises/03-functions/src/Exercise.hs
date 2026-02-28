module Exercise
  ( hypotenuse
  , celsiusToFahrenheit
  , fahrenheitToCelsius
  , applyTwice
  , compose3
  ) where

hypotenuse :: Double -> Double -> Double
hypotenuse a b = sqrt(a * a + b * b)

celsiusToFahrenheit :: Double -> Double
celsiusToFahrenheit c = c * 9/5 + 32
fahrenheitToCelsius :: Double -> Double
fahrenheitToCelsius f = (f - 32) * 5/9

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f $ f x 
compose3 :: (c -> d) -> (b -> c) -> (a -> b) -> a -> d
compose3 f g h x = f $ g $ h x
