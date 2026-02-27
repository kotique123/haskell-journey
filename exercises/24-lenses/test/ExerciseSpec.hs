module ExerciseSpec (spec) where
import Test.Hspec
import Control.Lens
import Exercise

spec :: Spec
spec = do
  let addr = Address "123 Main St" "Springfield" "12345"
  let bob = Person "Bob" 30 addr

  describe "Assignment 1: updateCity" $ do
    it "updates nested city" $ do
      let updated = updateCity "Shelbyville" bob
      updated ^. address . city `shouldBe` "Shelbyville"
    it "does not change other fields" $ do
      let updated = updateCity "Shelbyville" bob
      updated ^. name `shouldBe` "Bob"
      updated ^. age `shouldBe` 30

  describe "Assignment 2: incrementAge" $ do
    it "increments by 1" $ incrementAge bob ^. age `shouldBe` 31
    it "does not change name" $ incrementAge bob ^. name `shouldBe` "Bob"

  describe "Assignment 3: getFullAddress" $ do
    it "formats address" $ getFullAddress bob `shouldBe` "123 Main St, Springfield 12345"

  describe "Assignment 4: updateAllAges" $ do
    it "updates all" $ map (^. age) (updateAllAges [bob, bob]) `shouldBe` [31, 31]
    it "empty list" $ updateAllAges [] `shouldBe` []
