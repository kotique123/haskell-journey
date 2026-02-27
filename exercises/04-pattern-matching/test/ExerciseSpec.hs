module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: describeList" $ do
    it "empty list" $ describeList ([] :: [Int]) `shouldBe` "empty"
    it "singleton" $ describeList [1 :: Int] `shouldBe` "singleton"
    it "longer list" $ describeList [1,2,3 :: Int] `shouldBe` "longer list"
  describe "Assignment 2: fst3/snd3/thd3" $ do
    it "fst3" $ fst3 (1::Int, 'a', True) `shouldBe` 1
    it "snd3" $ snd3 (1::Int, 'a', True) `shouldBe` 'a'
    it "thd3" $ thd3 (1::Int, 'a', True) `shouldBe` True
  describe "Assignment 3: fibonacci" $ do
    it "fib 0" $ fibonacci 0 `shouldBe` 0
    it "fib 1" $ fibonacci 1 `shouldBe` 1
    it "fib 10" $ fibonacci 10 `shouldBe` 55
  describe "Assignment 4: describeNumber" $ do
    it "zero" $ describeNumber 0 `shouldBe` "zero"
    it "one" $ describeNumber 1 `shouldBe` "one"
    it "two" $ describeNumber 2 `shouldBe` "two"
    it "small" $ describeNumber 7 `shouldBe` "small"
    it "large" $ describeNumber 42 `shouldBe` "large"
  describe "Assignment 5: safeHead" $ do
    it "empty list" $ safeHead ([] :: [Int]) `shouldBe` Nothing
    it "non-empty" $ safeHead [1,2,3 :: Int] `shouldBe` Just 1
