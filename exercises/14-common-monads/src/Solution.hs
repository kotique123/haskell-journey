module Exercise
  ( safeSqrt, solveQuadratic, validatePerson, knightMoves, pythagorean3
  ) where

safeSqrt :: Double -> Maybe Double
safeSqrt x
  | x < 0    = Nothing
  | otherwise = Just (sqrt x)

solveQuadratic :: Double -> Double -> Double -> Maybe (Double, Double)
solveQuadratic a b c
  | disc < 0  = Nothing
  | otherwise = Just ((-b + sqrtDisc) / (2*a), (-b - sqrtDisc) / (2*a))
  where
    disc     = b*b - 4*a*c
    sqrtDisc = sqrt disc

validatePerson :: String -> Int -> Either String (String, Int)
validatePerson name age
  | null name             = Left "name cannot be empty"
  | age < 0 || age > 150 = Left "age out of range"
  | otherwise             = Right (name, age)

knightMoves :: (Int, Int) -> [(Int, Int)]
knightMoves (r, c) =
  [ (r+dr, c+dc)
  | (dr, dc) <- [(2,1),(2,-1),(-2,1),(-2,-1),(1,2),(1,-2),(-1,2),(-1,-2)]
  , let r' = r+dr; c' = c+dc
  , r' >= 1 && r' <= 8 && c' >= 1 && c' <= 8
  ]

pythagorean3 :: Int -> [(Int, Int, Int)]
pythagorean3 n = [(a,b,c) | c <- [1..n], b <- [1..c], a <- [1..b], a*a + b*b == c*c]
