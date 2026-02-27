module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: hypotenuse" $ do
    it "3-4-5 triangle" $ hypotenuse 3 4 `shouldSatisfy` (\h -> abs (h - 5) < 1e-9)
    it "1-1 triangle" $ hypotenuse 1 1 `shouldSatisfy` (\h -> abs (h - sqrt 2) < 1e-9)
  describe "Assignment 2: celsiusToFahrenheit" $ do
    it "0C is 32F" $ celsiusToFahrenheit 0 `shouldBe` 32.0
    it "100C is 212F" $ celsiusToFahrenheit 100 `shouldBe` 212.0
  describe "Assignment 3: fahrenheitToCelsius" $ do
    it "32F is 0C" $ fahrenheitToCelsius 32 `shouldBe` 0.0
    it "round-trip" $ property $ \c -> abs (fahrenheitToCelsius (celsiusToFahrenheit c) - c) < 1e-9
  describe "Assignment 4: applyTwice" $ do
    it "double twice" $ applyTwice (+3) 10 `shouldBe` 16
    it "negate twice is identity" $ applyTwice negate 5 `shouldBe` 5
  describe "Assignment 5: compose3" $ do
    it "show . negate . length" $ compose3 show negate length [1,2,3 :: Int] `shouldBe` "-3"
