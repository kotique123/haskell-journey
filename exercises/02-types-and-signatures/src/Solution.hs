module Exercise
  ( factorial, isEven, digitToChar, charToDigit, initials
  ) where

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

isEven :: Int -> Bool
isEven n = n `mod` 2 == 0

digitToChar :: Int -> Char
digitToChar n = toEnum (fromEnum '0' + n)

charToDigit :: Char -> Int
charToDigit c = fromEnum c - fromEnum '0'

initials :: String -> String -> String
initials first last = [head first] ++ "." ++ [head last] ++ "."
