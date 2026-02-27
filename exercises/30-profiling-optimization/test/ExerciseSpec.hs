module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Control.DeepSeq
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: lazySum vs strictSum" $ do
    it "lazySum correct" $ lazySum [1..100] `shouldBe` 5050
    it "strictSum correct" $ strictSum [1..100] `shouldBe` 5050
    it "both agree" $ property $ \xs -> lazySum xs == strictSum (xs :: [Int])

  describe "Assignment 2: naiveFib" $ do
    it "fib 0" $ naiveFib 0 `shouldBe` 0
    it "fib 10" $ naiveFib 10 `shouldBe` 55
    it "fib 20" $ naiveFib 20 `shouldBe` 6765

  describe "Assignment 3: memoFib" $ do
    it "agrees with naive" $ property $ \(NonNegative n) -> memoFib (n `mod` 25) == naiveFib (n `mod` 25)
    it "fib 50" $ memoFib 50 `shouldBe` 12586269025

  describe "Assignment 4: forceList" $ do
    it "returns same list" $ forceList [1,2,3 :: Int] `shouldBe` [1,2,3]
    it "fully evaluates" $ (rnf (forceList [1..100 :: Int]) `seq` True) `shouldBe` True

  describe "Assignment 5: StrictPair" $ do
    it "creates pair" $ mkStrictPair (1 :: Int) True `shouldBe` StrictPair 1 True
