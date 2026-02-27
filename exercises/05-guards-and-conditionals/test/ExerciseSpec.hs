module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck hiding (classify)
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: classify" $ do
    it "negative" $ classify (-5 :: Int) `shouldBe` "negative"
    it "zero" $ classify (0 :: Int) `shouldBe` "zero"
    it "positive" $ classify (3 :: Int) `shouldBe` "positive"
  describe "Assignment 2: grade" $ do
    it "A" $ grade 95 `shouldBe` "A"
    it "B" $ grade 85 `shouldBe` "B"
    it "C" $ grade 75 `shouldBe` "C"
    it "D" $ grade 65 `shouldBe` "D"
    it "F" $ grade 55 `shouldBe` "F"
  describe "Assignment 3: fizzbuzz" $ do
    it "fizz" $ fizzbuzz 9 `shouldBe` "Fizz"
    it "buzz" $ fizzbuzz 10 `shouldBe` "Buzz"
    it "fizzbuzz" $ fizzbuzz 15 `shouldBe` "FizzBuzz"
    it "number" $ fizzbuzz 7 `shouldBe` "7"
  describe "Assignment 4: between" $ do
    it "inside" $ between 1 10 (5 :: Int) `shouldBe` True
    it "outside" $ between 1 10 (11 :: Int) `shouldBe` False
    it "on boundary" $ between 1 10 (1 :: Int) `shouldBe` True
  describe "Assignment 5: clamp" $ do
    it "below" $ clamp 0 100 (-5 :: Int) `shouldBe` 0
    it "above" $ clamp 0 100 (200 :: Int) `shouldBe` 100
    it "inside" $ clamp 0 100 (50 :: Int) `shouldBe` 50
    it "property: result always in range" $ property $ \x -> let r = clamp 0 100 (x :: Int) in r >= 0 && r <= 100
