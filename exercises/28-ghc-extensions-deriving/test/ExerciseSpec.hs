module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Data.Foldable (toList)
import Data.List (sort, nub)
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: Dollars newtype arithmetic" $ do
    it "addition" $ Dollars 5 + Dollars 3 `shouldBe` Dollars 8
    it "multiplication" $ Dollars 4 * Dollars 3 `shouldBe` Dollars 12

  describe "Assignment 2: Sum / Product monoids" $ do
    it "Sum fold" $ foldMap (Sum . getSum) [Sum 1, Sum 2, Sum 3 :: Sum Int] `shouldBe` Sum 6
    it "Product fold" $ foldMap (Product . getProduct) [Product 1, Product 2, Product 3 :: Product Int] `shouldBe` Product 6
    it "Sum mempty" $ mempty <> Sum (5 :: Int) `shouldBe` Sum 5
    it "Product mempty" $ mempty <> Product (5 :: Int) `shouldBe` Product 5

  describe "Assignment 3: Derived Foldable/Traversable Tree" $ do
    it "sum via Foldable" $ sum (fromList [1,2,3,4 :: Int]) `shouldBe` 10
    it "traverse with Maybe" $ traverse (\x -> if x > 0 then Just x else Nothing) (fromList [1,2,3 :: Int]) `shouldSatisfy` maybe False (const True)
    it "sorted via toList" $ toList (fromList [3,1,4,1,5 :: Int]) `shouldBe` sort (nub [3,1,4,1,5])
