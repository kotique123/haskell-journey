# Exercise 08 — Higher-Order Functions

## Theory

Higher-order functions (HOFs) take functions as arguments or return functions as results. They are the primary abstraction mechanism in functional programming, replacing loops, inheritance, and design patterns with composable building blocks.

### `map`, `filter`, and folds

These three form the core toolkit:

```haskell
ghci> map (*3) [1,2,3,4]
[3,6,9,12]

ghci> filter odd [1..10]
[1,3,5,7,9]

ghci> foldr (+) 0 [1..5]
15

-- foldl' (strict left fold) for efficiency:
import Data.List (foldl')
ghci> foldl' (+) 0 [1..1000000]
500000500000
```

### Function composition `(.)`

`(.)` chains functions right-to-left: `(f . g) x = f (g x)`.

```haskell
-- Count words longer than 4 chars:
countLong :: [String] -> Int
countLong = length . filter (\w -> length w > 4)

ghci> countLong ["hi","hello","world","it"]
2
```

### Point-free style

A definition is *point-free* when the argument doesn't appear explicitly — the function is defined purely through composition:

```haskell
-- With argument (pointed):
double xs = map (*2) xs

-- Point-free:
double = map (*2)
```

Point-free code is concise but should still be readable.

### `zipWith`

`zipWith` combines two lists element-by-element using a function:

```haskell
ghci> zipWith (*) [1,2,3] [4,5,6]
[4,10,18]
ghci> zipWith max [1,5,3] [4,2,6]
[4,5,6]
```

When lists have different lengths, the result is as long as the shorter one.

### `flip`

`flip f x y = f y x` — swaps the first two arguments:

```haskell
ghci> flip div 2 10    -- 10 `div` 2
5
ghci> map (flip (:) []) [1,2,3]
[[1],[2],[3]]
```

### `iterate`

`iterate f x` produces an infinite list `[x, f x, f(f x), …]`:

```haskell
ghci> take 6 (iterate (*2) 1)
[1,2,4,8,16,32]
ghci> take 5 (iterate (++ "!") "hi")
["hi","hi!","hi!!","hi!!!","hi!!!!"]
```

### Applying a sequence of functions

Sometimes you have a list of transformations to apply in order. `foldl` (or `foldr`) can sequence them:

```haskell
ghci> let fs = [(+1), (*2), (subtract 3)]
ghci> foldl (\x f -> f x) 5 fs
9   -- ((5+1)*2)-3
```

---

## Practice Assignments

### Assignment 1: sumSquaresOfEvens

Write `sumSquaresOfEvens :: [Int] -> Int` that sums the squares of all even numbers in the list. Write it in point-free style using `filter`, `map`, and `sum`.

### Assignment 2: myZipWith

Write `myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]` — a recursive implementation of `zipWith`.

### Assignment 3: applyAll

Write `applyAll :: [a -> a] -> a -> a` that applies each function in the list to the value in sequence (left to right).

### Assignment 4: countWhere

Write `countWhere :: (a -> Bool) -> [a] -> Int` that counts how many elements satisfy the predicate. Express it using `filter` and `length`.

### Assignment 5: myIterate

Write `myIterate :: (a -> a) -> a -> [a]` — an infinite list starting with `x`, then `f x`, then `f (f x)`, and so on. Be careful: this must be lazy (don't try to compute the whole list!).
