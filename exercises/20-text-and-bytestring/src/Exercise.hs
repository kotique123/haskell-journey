{-# LANGUAGE OverloadedStrings #-}
module Exercise
  ( countWords
  , titleCase
  , isPalindrome
  , csvToRows
  , textToBytes
  , bytesToText
  ) where

import qualified Data.Text          as T
import qualified Data.Text.Encoding as TE
import qualified Data.ByteString    as BS
import           Data.Char          (toUpper, toLower)

-- | Count whitespace-separated words in a Text value.
countWords :: T.Text -> Int
countWords = undefined -- TODO: implement

-- | Capitalise the first character of every word.
titleCase :: T.Text -> T.Text
titleCase = undefined -- TODO: implement

-- | Return True if the text reads the same forwards and backwards,
-- ignoring spaces and case.
isPalindrome :: T.Text -> Bool
isPalindrome = undefined -- TODO: implement

-- | Parse a simple CSV: split on newlines then on commas.
csvToRows :: T.Text -> [[T.Text]]
csvToRows = undefined -- TODO: implement

-- | Encode Text to UTF-8 bytes.
textToBytes :: T.Text -> BS.ByteString
textToBytes = undefined -- TODO: implement

-- | Decode UTF-8 bytes to Text; return Nothing on invalid UTF-8.
bytesToText :: BS.ByteString -> Maybe T.Text
bytesToText = undefined -- TODO: implement
