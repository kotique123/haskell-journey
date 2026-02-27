module ExerciseSpec (spec) where
import Test.Hspec
import System.IO.Temp (withSystemTempFile)
import System.IO (hClose)
import Data.IORef
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: countLines" $ do
    it "counts lines" $ withSystemTempFile "test.txt" $ \path h -> do
      hClose h
      writeFile path "line1\nline2\nline3"
      n <- countLines path
      n `shouldBe` 3
    it "missing file returns 0" $ do
      n <- countLines "/tmp/nonexistent-haskell-test-12345.txt"
      n `shouldBe` 0
  describe "Assignment 2: appendToFile" $ do
    it "appends content" $ withSystemTempFile "test.txt" $ \path h -> do
      hClose h
      writeFile path ""
      appendToFile path "hello"
      appendToFile path "world"
      content <- readFile path
      content `shouldBe` "hello\nworld\n"
  describe "Assignment 3: makeCounter" $ do
    it "increments" $ do
      tick <- makeCounter
      a <- tick
      b <- tick
      c <- tick
      [a,b,c] `shouldBe` [1,2,3]
  describe "Assignment 4: safeDivIO" $ do
    it "success" $ do
      r <- safeDivIO 10 2
      r `shouldBe` Right 5
    it "divide by zero" $ do
      r <- safeDivIO 10 0
      r `shouldBe` Left "division by zero"
  describe "Assignment 5: repeatUntil" $ do
    it "runs body until predicate" $ do
      ref <- newIORef (0 :: Int)
      repeatUntil (do n <- readIORef ref; return (n >= 3))
                  (modifyIORef ref (+1))
      final <- readIORef ref
      final `shouldBe` 3
