module Exercise
  ( greet, double, circleArea, bmi
  ) where

greet :: String -> String
greet name = "Hello, " ++ name ++ "!"

double :: Int -> Int
double n = n * 2

circleArea :: Double -> Double
circleArea r = pi * r * r

bmi :: Double -> Double -> String
bmi weight height
  | bmiVal < 18.5 = "Underweight"
  | bmiVal < 25.0 = "Normal"
  | otherwise     = "Overweight"
  where bmiVal = weight / (height * height)
