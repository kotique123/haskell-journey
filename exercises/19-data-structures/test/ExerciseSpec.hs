module ExerciseSpec (spec) where
import Test.Hspec
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Data.List (sortBy)
import Data.Ord (comparing, Down(..))
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: wordCount" $ do
    it "counts words" $ wordCount "the cat sat on the mat" `shouldBe`
      Map.fromList [("cat",1),("mat",1),("on",1),("sat",1),("the",2)]
    it "empty string" $ wordCount "" `shouldBe` Map.empty
  describe "Assignment 2: invertMap" $ do
    it "basic inversion" $ invertMap (Map.fromList [("a",1),("b",1),("c",2)]) `shouldBe`
      Map.fromList [(1,["a","b"]),(2,["c"])]
  describe "Assignment 3: uniqueWords" $ do
    it "deduplicates" $ uniqueWords "the cat and the dog" `shouldBe`
      Set.fromList ["and","cat","dog","the"]
    it "single word" $ Set.size (uniqueWords "hello") `shouldBe` 1
  describe "Assignment 4: commonElements" $ do
    it "intersection" $ commonElements [1,2,3,4 :: Int] [3,4,5,6] `shouldMatchList` [3,4]
    it "no common" $ commonElements [1,2 :: Int] [3,4] `shouldBe` []
  describe "Assignment 5: topN" $ do
    it "top 2" $ topN 2 (Map.fromList [("a",3),("b",1),("c",2)]) `shouldBe` [("a",3),("c",2)]
    it "n larger than map" $ length (topN 10 (Map.fromList [("a",1),("b",2)])) `shouldBe` 2
