module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: myMap" $ do
    it "maps over list" $ myMap (*2) [1,2,3 :: Int] `shouldBe` [2,4,6]
    it "empty" $ myMap (*2) ([] :: [Int]) `shouldBe` []
    it "matches map" $ property $ \xs -> myMap (*2) (xs :: [Int]) == map (*2) xs
  describe "Assignment 2: myFilter" $ do
    it "filters evens" $ myFilter even [1..6 :: Int] `shouldBe` [2,4,6]
    it "matches filter" $ property $ \xs -> myFilter even (xs :: [Int]) == filter even xs
  describe "Assignment 3: myFoldr" $ do
    it "sums with foldr" $ myFoldr (+) 0 [1,2,3 :: Int] `shouldBe` 6
    it "builds list" $ myFoldr (:) [] [1,2,3 :: Int] `shouldBe` [1,2,3]
    it "matches foldr" $ property $ \xs -> myFoldr (+) 0 (xs :: [Int]) == foldr (+) 0 xs
  describe "Assignment 4: myTake" $ do
    it "takes n elements" $ myTake 3 [1..10 :: Int] `shouldBe` [1,2,3]
    it "take 0" $ myTake 0 [1..5 :: Int] `shouldBe` []
    it "matches take" $ property $ \(NonNegative n) xs -> myTake n (xs :: [Int]) == take n xs
  describe "Assignment 5: flatten" $ do
    it "flattens" $ flatten [[1,2],[3],[4,5,6 :: Int]] `shouldBe` [1,2,3,4,5,6]
    it "empty" $ flatten ([] :: [[Int]]) `shouldBe` []
    it "matches concat" $ property $ \xss -> flatten (xss :: [[Int]]) == concat xss
