module ExerciseSpec (spec) where
import Test.Hspec
import Data.List (sort)
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: safeSqrt" $ do
    it "positive" $ safeSqrt 9 `shouldSatisfy` maybe False (\r -> abs (r - 3) < 1e-9)
    it "negative" $ safeSqrt (-1) `shouldBe` Nothing
  describe "Assignment 2: solveQuadratic" $ do
    it "two roots" $ solveQuadratic 1 (-5) 6 `shouldBe` Just (3.0, 2.0)
    it "no real roots" $ solveQuadratic 1 0 1 `shouldBe` Nothing
  describe "Assignment 3: validatePerson" $ do
    it "valid" $ validatePerson "Alice" 30 `shouldBe` Right ("Alice", 30)
    it "empty name" $ validatePerson "" 30 `shouldBe` Left "name cannot be empty"
    it "invalid age" $ validatePerson "Bob" 200 `shouldBe` Left "age out of range"
  describe "Assignment 4: knightMoves" $ do
    it "corner (1,1) has 2 moves" $ length (knightMoves (1,1)) `shouldBe` 2
    it "center (4,4) has 8 moves" $ length (knightMoves (4,4)) `shouldBe` 8
    it "all moves on board" $ all (\(r,c) -> r >= 1 && r <= 8 && c >= 1 && c <= 8) (knightMoves (4,4)) `shouldBe` True
  describe "Assignment 5: pythagorean3" $ do
    it "includes 3-4-5" $ pythagorean3 10 `shouldContain` [(3,4,5)]
    it "all valid" $ all (\(a,b,c) -> a*a + b*b == c*c) (pythagorean3 20) `shouldBe` True
