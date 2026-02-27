module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: allColors" $ do
    it "has all three" $ allColors `shouldBe` [Red, Green, Blue]
    it "length 3" $ length allColors `shouldBe` 3
  describe "Assignment 2: Describable Color" $ do
    it "Red" $ toDescription Red `shouldBe` "red"
    it "Green" $ toDescription Green `shouldBe` "green"
    it "Blue" $ toDescription Blue `shouldBe` "blue"
  describe "Assignment 3: Describable Bool" $ do
    it "True" $ toDescription True `shouldBe` "yes"
    it "False" $ toDescription False `shouldBe` "no"
  describe "Assignment 4: Container Stack" $ do
    it "empty stack" $ toList (empty :: Stack Int) `shouldBe` []
    it "insert and toList" $ toList (insert 1 (insert 2 (empty :: Stack Int))) `shouldBe` [1,2]
