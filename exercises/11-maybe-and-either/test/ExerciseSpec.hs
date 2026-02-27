module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: safeDiv" $ do
    it "normal division" $ safeDiv 10 2 `shouldBe` Just 5
    it "division by zero" $ safeDiv 10 0 `shouldBe` Nothing
  describe "Assignment 2: safeIndex" $ do
    it "valid index" $ safeIndex [10,20,30 :: Int] 1 `shouldBe` Just 20
    it "out of bounds" $ safeIndex [1,2,3 :: Int] 5 `shouldBe` Nothing
    it "negative index" $ safeIndex [1,2,3 :: Int] (-1) `shouldBe` Nothing
  describe "Assignment 3: chainMaybe" $ do
    it "both succeed" $ chainMaybe (Just 12) `shouldBe` Just 2
    it "Nothing input" $ chainMaybe Nothing `shouldBe` Nothing
    it "intermediate zero" $ chainMaybe (Just 0) `shouldBe` Nothing
  describe "Assignment 4: parseAge" $ do
    it "valid age" $ parseAge "25" `shouldBe` Right 25
    it "not a number" $ parseAge "abc" `shouldBe` Left "not a number"
    it "negative" $ parseAge "-5" `shouldBe` Left "age must be positive"
    it "zero" $ parseAge "0" `shouldBe` Left "age must be positive"
  describe "Assignment 5: validateName" $ do
    it "valid name" $ validateName "Ada" `shouldBe` Right "Ada"
    it "too short" $ validateName "A" `shouldBe` Left "name too short"
    it "empty" $ validateName "" `shouldBe` Left "name too short"
