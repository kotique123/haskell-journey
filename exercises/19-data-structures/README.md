# Exercise 19 — Data Structures

## Theory

Haskell's `containers` package provides battle-tested, purely functional implementations of the most common data structures.  All operations preserve the old version and return a new one — there is no in-place mutation.

### `Data.Map.Strict`

`Map k v` is a balanced binary search tree keyed on `k` (requires `Ord k`).  Common operations:

```haskell
import qualified Data.Map.Strict as Map

m :: Map.Map String Int
m = Map.fromList [("alice", 1), ("bob", 2)]

-- Lookup: O(log n)
Map.lookup "alice" m       -- Just 1
Map.lookup "carol" m       -- Nothing

-- Insert / update: O(log n)
Map.insert "carol" 3 m     -- adds carol
Map.insertWith (+) "alice" 10 m  -- alice => 11

-- Delete: O(log n)
Map.delete "bob" m

-- Folding over (key, value) pairs
Map.foldlWithKey' (\acc k v -> acc + v) 0 m  -- sum of values

-- Combining two maps, resolving conflicts with a function
Map.unionWith (+) m (Map.fromList [("alice", 5), ("dave", 4)])
-- alice => 6, bob => 2, dave => 4
```

`Map.toList` returns pairs sorted by key; `Map.fromListWith f pairs` collapses duplicate keys using `f new old`.

### `Data.Set`

`Set a` is a balanced BST of unique elements (requires `Ord a`).

```haskell
import qualified Data.Set as Set

s1 = Set.fromList [1,2,3,4 :: Int]
s2 = Set.fromList [3,4,5,6 :: Int]

Set.member 3 s1             -- True
Set.union        s1 s2      -- {1,2,3,4,5,6}
Set.intersection s1 s2      -- {3,4}
Set.difference   s1 s2      -- {1,2}
Set.toList s1               -- [1,2,3,4]   (sorted)
```

### `Data.Sequence`

`Seq a` offers O(1) append to *both* ends and O(log n) indexing, unlike lists.

```haskell
import qualified Data.Sequence as Seq
import Data.Sequence ((<|), (|>))

q = Seq.empty |> 1 |> 2 |> 3   -- append right
q' = 0 <| q                     -- prepend left
Seq.index q' 0                  -- 0
Seq.length q'                   -- 4
```

### Inverting a map

A common pattern is reversing a `Map k v` into a `Map v [k]`.  `Map.fromListWith` handles collisions gracefully:

```haskell
invertMap :: (Ord v) => Map.Map String v -> Map.Map v [String]
invertMap m =
  Map.fromListWith (++) [(v, [k]) | (k, v) <- Map.toList m]
-- Note: because (++) prepends the newer list, inner lists may not be sorted.
-- Apply `Map.map sort` when deterministic ordering is required.
```

### Selecting top-N entries

Sort the association list by value (descending) then take:

```haskell
import Data.List (sortBy)
import Data.Ord  (comparing, Down(..))

topN :: Int -> Map.Map String Int -> [(String, Int)]
topN n m = take n $ sortBy (comparing (Down . snd)) (Map.toList m)
```

---

## Practice Assignments

### 1. wordCount

- `wordCount :: String -> Map.Map String Int` — split the string on whitespace and count occurrences of each word.

### 2. invertMap

- `invertMap :: (Ord v) => Map.Map String v -> Map.Map v [String]` — produce a map from each value to the sorted list of keys that mapped to it.

### 3. uniqueWords

- `uniqueWords :: String -> Set.Set String` — return the set of distinct words in the string.

### 4. commonElements

- `commonElements :: Ord a => [a] -> [a] -> [a]` — return the elements present in both input lists.  Use `Set.intersection` internally; the result order does not matter.

### 5. topN

- `topN :: Int -> Map.Map String Int -> [(String, Int)]` — return the top `n` entries sorted by value descending.  If the map has fewer than `n` entries, return all of them.
