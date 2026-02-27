module Exercise
  ( greet
  , double
  , circleArea
  , bmi
  ) where

greet :: String -> String
greet name = "Hello, " ++ name ++ "!"

double :: Int -> Int
double num = num * 2
-- Area = πr^2
circleArea :: Double -> Double
circleArea radius = pi * radius^2
-- BMI = weight (kg) / height^2 (m^2)
-- most idiomatic and readable approach
bmi :: Double -> Double -> String
bmi weight height
  | bmiValue < 18.5 = "Underweight"
  | bmiValue < 25.0 = "Normal"
  | otherwise       = "Overweight"
  where bmiValue = weight / height^2
