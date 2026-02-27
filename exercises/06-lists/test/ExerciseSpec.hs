module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: myLength" $ do
    it "empty" $ myLength ([] :: [Int]) `shouldBe` 0
    it "non-empty" $ myLength [1,2,3 :: Int] `shouldBe` 3
    it "matches length" $ property $ \xs -> myLength (xs :: [Int]) == length xs
  describe "Assignment 2: myReverse" $ do
    it "reverses" $ myReverse [1,2,3 :: Int] `shouldBe` [3,2,1]
    it "double reverse is identity" $ property $ \xs -> myReverse (myReverse (xs :: [Int])) == xs
  describe "Assignment 3: mySum" $ do
    it "empty is 0" $ mySum ([] :: [Int]) `shouldBe` 0
    it "sums correctly" $ mySum [1,2,3,4 :: Int] `shouldBe` 10
    it "matches sum" $ property $ \xs -> mySum (xs :: [Int]) == sum xs
  describe "Assignment 4: pythagorean" $ do
    it "includes 3-4-5" $ pythagorean 10 `shouldContain` [(3,4,5)]
    it "all valid triples" $ all (\(a,b,c) -> a*a + b*b == c*c) (pythagorean 20) `shouldBe` True
  describe "Assignment 5: runLengthEncode" $ do
    it "encodes runs" $ runLengthEncode "aabb" `shouldBe` [(2,'a'),(2,'b')]
    it "single chars" $ runLengthEncode "abc" `shouldBe` [(1,'a'),(1,'b'),(1,'c')]
    it "empty" $ runLengthEncode ([] :: [Char]) `shouldBe` []
