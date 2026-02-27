module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Data.Foldable (toList)
import Data.List (sort, nub)
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: Foldable Tree" $ do
    it "toList in-order" $ toList (Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)) `shouldBe` [1,2,3 :: Int]
    it "sum" $ sum (fromListBST [3,1,2 :: Int]) `shouldBe` 6
    it "length" $ length (fromListBST [1..5 :: Int]) `shouldBe` 5
  describe "Assignment 2: Functor Tree" $ do
    it "fmaps over tree" $ toList (fmap (*2) (fromListBST [1,2,3 :: Int])) `shouldBe` [2,4,6]
    it "fmap id law" $ property $ \xs -> fmap id (fromListBST (xs :: [Int])) == fromListBST xs
  describe "Assignment 3: Traversable Tree" $ do
    it "traverse with Maybe" $ traverse (\x -> if x > 0 then Just x else Nothing) (fromListBST [1,2,3 :: Int]) `shouldSatisfy` maybe False (const True)
    it "Nothing if any fails" $ traverse (\x -> if x > 0 then Just x else Nothing) (fromListBST [-1,2,3 :: Int]) `shouldBe` Nothing
  describe "Assignment 4: toSortedList" $ do
    it "sorts" $ toSortedList (fromListBST [3,1,4,1,5,9,2,6 :: Int]) `shouldBe` sort (nub [3,1,4,1,5,9,2,6])
    it "property: sorted" $ property $ \xs -> let sorted = toSortedList (fromListBST (xs :: [Int])) in sorted == sort (nub xs)
