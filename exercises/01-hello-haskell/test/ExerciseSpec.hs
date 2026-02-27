module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: greet" $ do
    it "greets a name" $ greet "World" `shouldBe` "Hello, World!"
    it "greets another name" $ greet "Haskell" `shouldBe` "Hello, Haskell!"
  describe "Assignment 2: double" $ do
    it "doubles zero" $ double 0 `shouldBe` 0
    it "doubles a positive number" $ double 7 `shouldBe` 14
    it "doubles a negative number" $ double (-3) `shouldBe` (-6)
  describe "Assignment 3: circleArea" $ do
    it "area of radius 1 is pi" $ circleArea 1.0 `shouldSatisfy` (\a -> abs (a - pi) < 1e-9)
    it "area of radius 0 is 0" $ circleArea 0.0 `shouldBe` 0.0
  describe "Assignment 4: bmi" $ do
    it "underweight" $ bmi 45 1.75 `shouldBe` "Underweight"
    it "normal" $ bmi 70 1.75 `shouldBe` "Normal"
    it "overweight" $ bmi 100 1.75 `shouldBe` "Overweight"
