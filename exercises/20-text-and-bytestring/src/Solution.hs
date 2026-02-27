{-# LANGUAGE OverloadedStrings #-}
module Exercise
  ( countWords, titleCase, isPalindrome, csvToRows, textToBytes, bytesToText
  ) where

import qualified Data.Text          as T
import qualified Data.Text.Encoding as TE
import qualified Data.ByteString    as BS
import           Data.Char          (toUpper, toLower)

countWords :: T.Text -> Int
countWords = length . T.words

titleCase :: T.Text -> T.Text
titleCase = T.unwords . map capitalise . T.words
  where
    capitalise w = case T.uncons w of
      Nothing      -> w
      Just (c, cs) -> T.cons (toUpper c) cs

isPalindrome :: T.Text -> Bool
isPalindrome t = cleaned == T.reverse cleaned
  where cleaned = T.map toLower $ T.filter (/= ' ') t

csvToRows :: T.Text -> [[T.Text]]
csvToRows = map (T.splitOn ",") . T.lines

textToBytes :: T.Text -> BS.ByteString
textToBytes = TE.encodeUtf8

bytesToText :: BS.ByteString -> Maybe T.Text
bytesToText bs = case TE.decodeUtf8' bs of
  Left  _ -> Nothing
  Right t -> Just t
