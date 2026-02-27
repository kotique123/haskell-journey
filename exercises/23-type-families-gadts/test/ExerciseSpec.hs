module ExerciseSpec (spec) where
import Test.Hspec
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: eval Expr" $ do
    it "Lit" $ eval (Lit 42) `shouldBe` 42
    it "Add" $ eval (Add (Lit 3) (Lit 4)) `shouldBe` 7
    it "If true" $ eval (If (BoolLit True) (Lit 1) (Lit 2)) `shouldBe` 1
    it "If false" $ eval (If (BoolLit False) (Lit 1) (Lit 2)) `shouldBe` 2
    it "nested" $ eval (Add (Lit 1) (If (BoolLit True) (Lit 10) (Lit 20))) `shouldBe` 11
  describe "Assignment 2: HList" $ do
    it "hHead" $ hHead (HCons (42 :: Int) (HCons True HNil)) `shouldBe` 42
    it "hTail head" $ hHead (hTail (HCons (42 :: Int) (HCons True HNil))) `shouldBe` True
