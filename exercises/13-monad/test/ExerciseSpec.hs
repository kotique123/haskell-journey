module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: safeDiv3" $ do
    it "all nonzero" $ safeDiv3 12 3 2 `shouldBe` Just 2
    it "first divisor zero" $ safeDiv3 10 0 2 `shouldBe` Nothing
    it "second divisor zero" $ safeDiv3 10 2 0 `shouldBe` Nothing
  describe "Assignment 2: lookupChain" $ do
    it "found" $ lookupChain "a" [("a","b"),("b","c")] `shouldBe` Just "c"
    it "first not found" $ lookupChain "x" [("a","b")] `shouldBe` Nothing
    it "second not found" $ lookupChain "a" [("a","x")] `shouldBe` Nothing
  describe "Assignment 3: sequenceMaybe" $ do
    it "all Just" $ sequenceMaybe [Just 1, Just 2, Just 3 :: Maybe Int] `shouldBe` Just [1,2,3]
    it "has Nothing" $ sequenceMaybe [Just 1, Nothing, Just 3 :: Maybe Int] `shouldBe` Nothing
    it "empty" $ sequenceMaybe ([] :: [Maybe Int]) `shouldBe` Just []
  describe "Assignment 4: whenJust" $ do
    it "Just runs action" $ do
      let action x = pure [x]
      result <- whenJust (Just (42 :: Int)) action
      result `shouldBe` Just [42]
    it "Nothing skips" $ do
      let action x = pure [x :: Int]
      result <- whenJust Nothing action
      result `shouldBe` Nothing
  describe "Assignment 5: replicateM'" $ do
    it "replicates Just" $ replicateM' 3 (Just (1 :: Int)) `shouldBe` Just [1,1,1]
    it "Nothing short-circuits" $ replicateM' 3 (Nothing :: Maybe Int) `shouldBe` Nothing
    it "zero times" $ replicateM' 0 (Just (1 :: Int)) `shouldBe` Just []
