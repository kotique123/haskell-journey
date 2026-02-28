module Exercise
  ( factorial
  , isEven
  , digitToChar
  , charToDigit
  , initials
  ) where

factorial :: Integer -> Integer
factorial num
  |  num <= 0 = 1
  |  otherwise = num * factorial (num - 1)


isEven :: Int -> Bool
isEven num = num `mod` 2 == 0

digitToChar :: Int -> Char
digitToChar digit = toEnum (fromEnum '0' + digit) :: Char

charToDigit :: Char -> Int
charToDigit digit = fromEnum digit - fromEnum '0'

initials :: String -> String -> String
initials firstName lastName = [head firstName, '.' , head lastName, '.']