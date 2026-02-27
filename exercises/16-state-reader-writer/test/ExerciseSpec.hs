module ExerciseSpec (spec) where
import Test.Hspec
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Writer
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: stackPush / stackPop" $ do
    it "push then pop" $ do
      let result = runState (do stackPush 1; stackPush 2; stackPop) []
      result `shouldBe` (Just 2, [1])
    it "pop empty" $ do
      let result = runState stackPop ([] :: [Int])
      result `shouldBe` (Nothing, [])
  describe "Assignment 2: stackSize" $ do
    it "size after pushes" $ execState (stackPush 'a' >> stackPush 'b' >> stackPush 'c') [] `shouldBe` "cba"
    it "size is 3" $ evalState (stackPush 'a' >> stackPush 'b' >> stackPush 'c' >> stackSize) [] `shouldBe` 3
  describe "Assignment 3: getRetryMessage" $ do
    it "formats message" $ runReader getRetryMessage (Config 3 30) `shouldBe` "Will retry 3 times with timeout 30"
  describe "Assignment 4: logComputation" $ do
    it "result is factorial" $ fst (runWriter (logComputation 4)) `shouldBe` 24
    it "logs steps" $ length (snd (runWriter (logComputation 4))) `shouldBe` 4
