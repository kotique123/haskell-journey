module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: addOne" $ do
    it "Just" $ addOne (Just 4) `shouldBe` Just 5
    it "Nothing" $ addOne Nothing `shouldBe` Nothing
  describe "Assignment 2: safeSquareRoot" $ do
    it "positive" $ safeSquareRoot 4.0 `shouldSatisfy` maybe False (\r -> abs (r - 2.0) < 1e-9)
    it "zero" $ safeSquareRoot 0.0 `shouldBe` Just 0.0
    it "negative" $ safeSquareRoot (-1.0) `shouldBe` Nothing
  describe "Assignment 3: applyMaybe" $ do
    it "Just f Just x" $ applyMaybe (Just (+1)) (Just 5 :: Maybe Int) `shouldBe` Just 6
    it "Nothing f" $ applyMaybe (Nothing :: Maybe (Int -> Int)) (Just 5 :: Maybe Int) `shouldBe` Nothing
    it "Nothing x" $ applyMaybe (Just (+1)) (Nothing :: Maybe Int) `shouldBe` Nothing
  describe "Assignment 4: liftAdd" $ do
    it "both Just" $ liftAdd (Just 3) (Just 4) `shouldBe` Just 7
    it "one Nothing" $ liftAdd Nothing (Just 4) `shouldBe` Nothing
  describe "Assignment 5: cartesianProduct" $ do
    it "basic" $ cartesianProduct [1,2 :: Int] ['a','b'] `shouldBe` [(1,'a'),(1,'b'),(2,'a'),(2,'b')]
    it "empty" $ cartesianProduct ([] :: [Int]) "abc" `shouldBe` []
