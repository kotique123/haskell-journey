module Exercise
  ( wordCount, invertMap, uniqueWords, commonElements, topN
  ) where

import qualified Data.Map.Strict as Map
import qualified Data.Set        as Set
import           Data.List       (sort, sortBy)
import           Data.Ord        (comparing, Down(..))

wordCount :: String -> Map.Map String Int
wordCount = foldl count Map.empty . words
  where count m w = Map.insertWith (+) w 1 m

invertMap :: Ord v => Map.Map String v -> Map.Map v [String]
invertMap m = Map.map sort $
  Map.fromListWith (++) [(v, [k]) | (k, v) <- Map.toList m]

uniqueWords :: String -> Set.Set String
uniqueWords = Set.fromList . words

commonElements :: Ord a => [a] -> [a] -> [a]
commonElements xs ys = Set.toList $ Set.intersection (Set.fromList xs) (Set.fromList ys)

topN :: Int -> Map.Map String Int -> [(String, Int)]
topN n m = take n $ sortBy (comparing (Down . snd)) (Map.toList m)
