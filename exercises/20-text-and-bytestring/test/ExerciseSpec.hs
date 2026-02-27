module ExerciseSpec (spec) where
import Test.Hspec
import qualified Data.Text as T
import qualified Data.ByteString as BS
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: countWords" $ do
    it "counts words" $ countWords "hello world foo" `shouldBe` 3
    it "empty" $ countWords "" `shouldBe` 0
    it "single word" $ countWords "haskell" `shouldBe` 1
  describe "Assignment 2: titleCase" $ do
    it "basic" $ titleCase "hello world" `shouldBe` "Hello World"
    it "already title" $ titleCase "Haskell Is Great" `shouldBe` "Haskell Is Great"
  describe "Assignment 3: isPalindrome" $ do
    it "palindrome" $ isPalindrome "racecar" `shouldBe` True
    it "not palindrome" $ isPalindrome "hello" `shouldBe` False
    it "with spaces" $ isPalindrome "a man a plan a canal panama" `shouldBe` True
  describe "Assignment 4: csvToRows" $ do
    it "parses CSV" $ csvToRows "a,b,c\n1,2,3" `shouldBe` [["a","b","c"],["1","2","3"]]
    it "single row" $ csvToRows "x,y" `shouldBe` [["x","y"]]
  describe "Assignment 5: textToBytes / bytesToText" $ do
    it "round-trip ASCII" $ bytesToText (textToBytes "hello") `shouldBe` Just "hello"
    it "round-trip Unicode" $ bytesToText (textToBytes "こんにちは") `shouldBe` Just "こんにちは"
    it "invalid UTF-8 is Nothing" $ bytesToText (BS.pack [0xFF, 0xFE]) `shouldBe` Nothing
