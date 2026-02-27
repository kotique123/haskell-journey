module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: describeWithLambdaCase" $ do
    it "Nothing" $ describeWithLambdaCase Nothing `shouldBe` "nothing"
    it "Just" $ describeWithLambdaCase (Just 42) `shouldBe` "just 42"

  describe "Assignment 2: pairWithIndex" $ do
    it "pairs with index" $ pairWithIndex "abc" `shouldBe` [(0,'a'),(1,'b'),(2,'c')]
    it "empty" $ pairWithIndex ([] :: [Int]) `shouldBe` []

  describe "Assignment 3: classify" $ do
    it "negative" $ classify (-5) `shouldBe` "neg"
    it "zero" $ classify 0 `shouldBe` "zero"
    it "small" $ classify 50 `shouldBe` "small"
    it "big" $ classify 200 `shouldBe` "big"

  describe "Assignment 4: formatConfig" $ do
    it "formats" $ formatConfig (Config "localhost" 8080) `shouldBe` "localhost:8080"
    it "default config" $ formatConfig defaultConfig `shouldSatisfy` (not . null)
