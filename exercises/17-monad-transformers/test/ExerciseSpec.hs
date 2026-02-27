module ExerciseSpec (spec) where
import Test.Hspec
import Control.Monad.Except
import Control.Monad.State
import Control.Monad.Reader
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: increment / runApp" $ do
    it "increments state" $ do
      let (result, st) = runApp (increment >> increment >> increment) 0
      result `shouldBe` Right ()
      st `shouldBe` 3
  describe "Assignment 2: guardPositive" $ do
    it "positive passes" $ do
      let (result, _) = runApp (guardPositive 5) 0
      result `shouldBe` Right 5
    it "non-positive fails" $ do
      let (result, _) = runApp (guardPositive (-1)) 0
      result `shouldBe` Left "non-positive"
    it "error stops state updates" $ do
      let (result, st) = runApp (increment >> guardPositive (-1) >> increment) 0
      result `shouldBe` Left "non-positive"
      st `shouldBe` 1
  describe "Assignment 3: greetUser" $ do
    it "prepends prefix" $ do
      result <- runReaderT (greetUser "Alice") "Hello"
      result `shouldBe` "Hello Alice"
  describe "Assignment 4: safeReadFile" $ do
    it "missing file gives Left" $ do
      result <- runExceptT (safeReadFile "/tmp/nonexistent-haskell-99999.txt")
      case result of
        Left _  -> return ()
        Right _ -> expectationFailure "expected Left for missing file"
