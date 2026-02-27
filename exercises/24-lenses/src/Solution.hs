{-# LANGUAGE TemplateHaskell #-}

module Exercise
  ( Address(..), Person(..)
  , street, city, zip, name, age, address
  , updateCity, incrementAge, getFullAddress, updateAllAges
  ) where

import Prelude hiding (zip)
import Control.Lens

data Address = Address
  { _street :: String
  , _city   :: String
  , _zip    :: String
  } deriving (Show, Eq)

data Person = Person
  { _name    :: String
  , _age     :: Int
  , _address :: Address
  } deriving (Show, Eq)

makeLenses ''Address
makeLenses ''Person

updateCity :: String -> Person -> Person
updateCity newCity = address . city .~ newCity

incrementAge :: Person -> Person
incrementAge = age %~ (+1)

getFullAddress :: Person -> String
getFullAddress p = p ^. address . street ++ ", " ++ p ^. address . city ++ " " ++ p ^. address . zip

updateAllAges :: [Person] -> [Person]
updateAllAges = map incrementAge
