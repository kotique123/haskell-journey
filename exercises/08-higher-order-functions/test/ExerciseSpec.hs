module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: sumSquaresOfEvens" $ do
    it "basic" $ sumSquaresOfEvens [1..10] `shouldBe` 220
    it "empty" $ sumSquaresOfEvens [] `shouldBe` 0
  describe "Assignment 2: myZipWith" $ do
    it "adds lists" $ myZipWith (+) [1,2,3 :: Int] [4,5,6] `shouldBe` [5,7,9]
    it "shorter list wins" $ myZipWith (+) [1 :: Int] [1,2,3] `shouldBe` [2]
    it "matches zipWith" $ property $ \xs ys -> myZipWith (+) (xs :: [Int]) ys == zipWith (+) xs ys
  describe "Assignment 3: applyAll" $ do
    it "applies sequence" $ applyAll [(+1),(+2),(+3)] (0 :: Int) `shouldBe` 6
    it "empty list" $ applyAll [] (5 :: Int) `shouldBe` 5
  describe "Assignment 4: countWhere" $ do
    it "counts evens" $ countWhere even [1..10 :: Int] `shouldBe` 5
    it "none match" $ countWhere (>100) [1..10 :: Int] `shouldBe` 0
  describe "Assignment 5: myIterate" $ do
    it "powers of 2" $ take 5 (myIterate (*2) 1 :: [Int]) `shouldBe` [1,2,4,8,16]
    it "matches iterate" $ property $ \x -> take 10 (myIterate (+1) (x :: Int)) == take 10 (iterate (+1) x)
