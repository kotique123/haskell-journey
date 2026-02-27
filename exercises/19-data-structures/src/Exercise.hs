module Exercise
  ( wordCount
  , invertMap
  , uniqueWords
  , commonElements
  , topN
  ) where

import qualified Data.Map.Strict as Map
import qualified Data.Set        as Set
import           Data.List       (sort, sortBy)
import           Data.Ord        (comparing, Down(..))

-- | Count how many times each word appears in the input string.
wordCount :: String -> Map.Map String Int
wordCount = undefined -- TODO: implement

-- | Invert a map: each value becomes a key mapping to a sorted list
-- of the original keys that had that value.
invertMap :: Ord v => Map.Map String v -> Map.Map v [String]
invertMap = undefined -- TODO: implement

-- | Collect the unique words in a string into a Set.
uniqueWords :: String -> Set.Set String
uniqueWords = undefined -- TODO: implement

-- | Return the elements that appear in both lists (any order).
commonElements :: Ord a => [a] -> [a] -> [a]
commonElements = undefined -- TODO: implement

-- | Return the top N entries from a map, ordered by value descending.
topN :: Int -> Map.Map String Int -> [(String, Int)]
topN = undefined -- TODO: implement
