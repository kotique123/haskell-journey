module ExerciseSpec (spec) where
import Test.Hspec
import GHC.TypeLits
import Data.Proxy
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: Vec basics" $ do
    it "vHead" $ vHead (VCons (1 :: Int) (VCons 2 VNil)) `shouldBe` 1
    it "vTail to list" $ vToList (vTail (VCons (1 :: Int) (VCons 2 (VCons 3 VNil)))) `shouldBe` [2,3]

  describe "Assignment 2: vLength" $ do
    it "length 0" $ vLength (VNil :: Vec 0 Int) `shouldBe` 0
    it "length 3" $ vLength (VCons 1 (VCons 2 (VCons 3 VNil)) :: Vec 3 Int) `shouldBe` 3

  describe "Assignment 3: vReplicate" $ do
    it "replicate 3" $ vToList (vReplicate @3 (0 :: Int)) `shouldBe` [0,0,0]
    it "replicate 0" $ vToList (vReplicate @0 (0 :: Int)) `shouldBe` []

  describe "Assignment 4: symbolName" $ do
    it "returns symbol string" $ symbolName @"hello" `shouldBe` "hello"
    it "different symbol" $ symbolName @"haskell" `shouldBe` "haskell"
