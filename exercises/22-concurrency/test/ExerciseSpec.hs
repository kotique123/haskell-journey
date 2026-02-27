module ExerciseSpec (spec) where
import Test.Hspec
import Control.Concurrent
import Control.Concurrent.Async (replicateConcurrently_)
import Control.Concurrent.STM
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: makeSharedCounter" $ do
    it "increments correctly" $ do
      (inc, get) <- makeSharedCounter
      inc >> inc >> inc
      n <- get
      n `shouldBe` 3
    it "concurrent increments are atomic (no lost updates)" $ do
      (inc, get) <- makeSharedCounter
      -- Run 100 threads each incrementing once; MVar guarantees atomicity
      replicateConcurrently_ 100 inc
      n <- get
      n `shouldBe` 100
  describe "Assignment 2: STMStack" $ do
    it "push and pop" $ do
      stack <- atomically newSTMStack
      atomically $ pushSTM (1 :: Int) stack
      atomically $ pushSTM 2 stack
      top <- atomically $ popSTM stack
      top `shouldBe` Just 2
    it "pop empty" $ do
      stack <- atomically (newSTMStack :: STM (STMStack Int))
      result <- atomically $ popSTM stack
      result `shouldBe` Nothing
  describe "Assignment 3: parallelMap" $ do
    it "processes all" $ do
      results <- parallelMap (\x -> return (x * 2)) [1..5 :: Int]
      results `shouldBe` [2,4,6,8,10]
    it "preserves order" $ do
      results <- parallelMap return [1..10 :: Int]
      results `shouldBe` [1..10]
  describe "Assignment 4: timeout'" $ do
    it "completes fast action" $ do
      result <- timeout' 1000000 (return (42 :: Int))
      result `shouldBe` Just 42
    it "times out slow action" $ do
      result <- timeout' 1000 (threadDelay 1000000 >> return (42 :: Int))
      result `shouldBe` Nothing
