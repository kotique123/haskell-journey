module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: applyToInt" $ do
    it "applies negate" $ applyToInt negate 5 `shouldBe` (-5)
    it "applies abs" $ applyToInt abs (-3) `shouldBe` 3
    it "applies (+1)" $ applyToInt (+1) 10 `shouldBe` 11

  describe "Assignment 2: applyToBoth" $ do
    it "negates both" $ applyToBoth negate (5, 3.0) `shouldBe` (-5, -3.0)
    it "abs both" $ applyToBoth abs (-5, -3.0) `shouldBe` (5, 3.0)

  describe "Assignment 3: showWithProxy" $ do
    it "reads Int" $ (showWithProxy @Int "42" :: Int) `shouldBe` 42
    it "reads Bool" $ (showWithProxy @Bool "True" :: Bool) `shouldBe` True

  describe "Assignment 4: sizeOf" $ do
    it "returns length and list" $ sizeOf [1,2,3 :: Int] `shouldBe` (3, [1,2,3])
    it "property" $ property $ \xs -> fst (sizeOf (xs :: [Int])) == length xs
