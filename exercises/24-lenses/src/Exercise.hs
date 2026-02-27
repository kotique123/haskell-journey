{-# LANGUAGE TemplateHaskell #-}

module Exercise
  ( Address(..)
  , Person(..)
  , street
  , city
  , zip
  , name
  , age
  , address
  , updateCity
  , incrementAge
  , getFullAddress
  , updateAllAges
  ) where

import Prelude hiding (zip)
import Control.Lens

-- | A postal address. Fields are prefixed with '_' for makeLenses.
data Address = Address
  { _street :: String
  , _city   :: String
  , _zip    :: String
  } deriving (Show, Eq)

-- | A person with a nested address.
data Person = Person
  { _name    :: String
  , _age     :: Int
  , _address :: Address
  } deriving (Show, Eq)

-- Generate lenses: 'street', 'city', 'zip', 'name', 'age', 'address'.
makeLenses ''Address
makeLenses ''Person

-- | Set the city of a person's address using lenses.
-- Hint: use (address . city .~ newCity) or the (.~) operator.
updateCity :: String -> Person -> Person
updateCity = undefined

-- | Increment a person's age by 1 using lenses.
-- Hint: use the (%~) operator with (+1).
incrementAge :: Person -> Person
incrementAge = undefined

-- | Format the address as "<street>, <city> <zip>".
-- Hint: use the (^.) operator to read nested fields.
getFullAddress :: Person -> String
getFullAddress = undefined

-- | Increment every person's age in the list.
updateAllAges :: [Person] -> [Person]
updateAllAges = undefined
