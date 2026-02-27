module ExerciseSpec (spec) where
import Test.Hspec
import Test.QuickCheck
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: naturals" $ do
    it "first 5" $ take 5 naturals `shouldBe` [1,2,3,4,5]
    it "100th element" $ naturals !! 99 `shouldBe` 100
  describe "Assignment 2: fibs" $ do
    it "first 8" $ take 8 fibs `shouldBe` [0,1,1,2,3,5,8,13]
    it "20th fib" $ fibs !! 19 `shouldBe` 4181
  describe "Assignment 3: primes" $ do
    it "first 5 primes" $ take 5 primes `shouldBe` [2,3,5,7,11]
    it "10th prime is 29" $ primes !! 9 `shouldBe` 29
    it "all prime" $ all isPrime (take 20 primes) `shouldBe` True
  describe "Assignment 4: strictSum" $ do
    it "sums list" $ strictSum [1..100] `shouldBe` 5050
    it "matches sum" $ property $ \xs -> strictSum xs == sum xs
  describe "Assignment 5: collatz" $ do
    it "collatz 1" $ collatz 1 `shouldBe` [1]
    it "collatz 6" $ collatz 6 `shouldBe` [6,3,10,5,16,8,4,2,1]
    it "always ends in 1" $ all (\xs -> last xs == 1) (map collatz [1..20]) `shouldBe` True

isPrime :: Integer -> Bool
isPrime n = n > 1 && all (\d -> n `mod` d /= 0) [2..floor (sqrt (fromIntegral n))]
