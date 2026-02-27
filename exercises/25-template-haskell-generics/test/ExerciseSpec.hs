module ExerciseSpec (spec) where
import Test.Hspec
import Data.Aeson (encode, decode)
import qualified Data.ByteString.Lazy.Char8 as BLC
import Exercise

spec :: Spec
spec = do
  describe "Assignment 1: ToJSON/FromJSON Color" $ do
    it "encodes Red" $ BLC.unpack (encode Red) `shouldBe` "\"Red\""
    it "round-trips" $ decode (encode Green) `shouldBe` Just Green
    it "round-trips Blue" $ decode (encode Blue) `shouldBe` Just Blue

  describe "Assignment 2: ToJSON/FromJSON Point" $ do
    it "round-trips" $ decode (encode (Point 1.0 2.0)) `shouldBe` Just (Point 1.0 2.0)
    it "encodes as object" $ BLC.unpack (encode (Point 3.0 4.0)) `shouldContain` "\"x\""

  describe "Assignment 3: Celsius newtype" $ do
    it "arithmetic via newtype deriving" $ Celsius 100 + Celsius 20 `shouldBe` Celsius 120

  describe "Assignment 4: temperature conversion" $ do
    it "0C is 32F" $ toFahrenheit (Celsius 0) `shouldBe` Fahrenheit 32.0
    it "100C is 212F" $ toFahrenheit (Celsius 100) `shouldBe` Fahrenheit 212.0
    it "round-trip" $ do
      let c = Celsius 37
      let Celsius result = toCelsius (toFahrenheit c)
      let Celsius expected = c
      abs (result - expected) `shouldSatisfy` (< 1e-9)
