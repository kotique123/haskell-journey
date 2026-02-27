module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: factorial" $ do
    it "factorial 0 is 1" $ factorial 0 `shouldBe` 1
    it "factorial 5 is 120" $ factorial 5 `shouldBe` 120
    it "factorial 10 is 3628800" $ factorial 10 `shouldBe` 3628800
  describe "Assignment 2: isEven" $ do
    it "0 is even" $ isEven 0 `shouldBe` True
    it "1 is odd" $ isEven 1 `shouldBe` False
    it "4 is even" $ isEven 4 `shouldBe` True
    it "property: n and n+2 have same parity" $ property $ \n -> isEven (n :: Int) == isEven (n + 2)
  describe "Assignment 3: digitToChar" $ do
    it "0 -> '0'" $ digitToChar 0 `shouldBe` '0'
    it "9 -> '9'" $ digitToChar 9 `shouldBe` '9'
  describe "Assignment 4: charToDigit" $ do
    it "'5' -> 5" $ charToDigit '5' `shouldBe` 5
    it "round-trip" $ property $ \n -> let d = n `mod` 10 in charToDigit (digitToChar (abs d)) == abs d
  describe "Assignment 5: initials" $ do
    it "John Doe -> J.D." $ initials "John" "Doe" `shouldBe` "J.D."
    it "Ada Lovelace -> A.L." $ initials "Ada" "Lovelace" `shouldBe` "A.L."
