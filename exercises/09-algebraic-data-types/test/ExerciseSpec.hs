module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: area" $ do
    it "circle area" $ area (Circle 1) `shouldSatisfy` (\a -> abs (a - pi) < 1e-9)
    it "rectangle area" $ area (Rectangle 3 4) `shouldBe` 12.0
    it "triangle area (Heron)" $ area (Triangle 3 4 5) `shouldSatisfy` (\a -> abs (a - 6) < 1e-9)
  describe "Assignment 2: perimeter" $ do
    it "circle" $ perimeter (Circle 1) `shouldSatisfy` (\p -> abs (p - 2*pi) < 1e-9)
    it "rectangle" $ perimeter (Rectangle 3 4) `shouldBe` 14.0
  describe "Assignment 3: opposite" $ do
    it "North -> South" $ opposite North `shouldBe` South
    it "East -> West" $ opposite East `shouldBe` West
    it "double opposite is identity" $ all (\d -> opposite (opposite d) == d) [North,South,East,West] `shouldBe` True
  describe "Assignment 4: fullName" $ do
    it "concatenates" $ fullName (Person "Ada" "Lovelace" 36) `shouldBe` "Ada Lovelace"
  describe "Assignment 5: isAdult" $ do
    it "adult" $ isAdult (Person "Ada" "Lovelace" 36) `shouldBe` True
    it "minor" $ isAdult (Person "Bob" "Smith" 15) `shouldBe` False
