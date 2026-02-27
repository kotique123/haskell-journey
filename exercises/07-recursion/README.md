# Exercise 07 — Recursion

## Theory

Recursion is the primary mechanism for repetition in Haskell — there are no `for` or `while` loops. Once you internalize the patterns, recursive functions become natural and elegant.

### Structural recursion on lists

The shape of a list (`[]` or `x:xs`) directly drives the structure of most recursive functions:

1. **Base case**: what to do with an empty list?
2. **Recursive case**: how to combine the head `x` with the result of processing the tail `xs`?

```haskell
myProduct :: Num a => [a] -> a
myProduct []     = 1             -- base case: empty product is 1
myProduct (x:xs) = x * myProduct xs  -- combine head with recursive result
```

### Tracing a recursive call

To understand recursion, trace the calls manually:

```haskell
myProduct [2,3,4]
= 2 * myProduct [3,4]
= 2 * (3 * myProduct [4])
= 2 * (3 * (4 * myProduct []))
= 2 * (3 * (4 * 1))
= 24
```

### The accumulator pattern (tail recursion)

Naive recursion builds up a chain of deferred operations. An accumulator turns this into a loop-like tail-recursive form:

```haskell
-- Naive (not tail-recursive):
sumList :: [Int] -> Int
sumList []     = 0
sumList (x:xs) = x + sumList xs

-- Tail-recursive with accumulator:
sumListTR :: [Int] -> Int
sumListTR xs = go 0 xs
  where
    go acc []     = acc
    go acc (y:ys) = go (acc + y) ys
```

The tail-recursive version doesn't grow the call stack because `go` is always the last thing evaluated.

### Mapping over a list

`map` applies a function to every element:

```haskell
myMap :: (a -> b) -> [a] -> [b]
myMap _ []     = []
myMap f (x:xs) = f x : myMap f xs

ghci> myMap (*2) [1,2,3]
[2,4,6]
```

### Filtering a list

`filter` keeps only elements satisfying a predicate:

```haskell
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ []     = []
myFilter p (x:xs)
  | p x       = x : myFilter p xs
  | otherwise = myFilter p xs
```

### `foldr` — folding from the right

`foldr` captures the pattern of structural recursion on lists. It replaces `[]` with an initial value and `(:)` with a combining function:

```haskell
-- foldr f z [a,b,c] = f a (f b (f c z))
ghci> foldr (+) 0 [1,2,3]
6
ghci> foldr (:) [] [1,2,3]   -- rebuilds the list
[1,2,3]
```

Many list functions can be expressed as a `foldr`.

### Concatenation via recursion

Flattening a list of lists is just appending them one by one:

```haskell
-- concat [[1,2],[3],[4,5]] = [1,2,3,4,5]
```

The `(++)` operator appends two lists and is itself recursive.

---

## Practice Assignments

### Assignment 1: myMap

Write `myMap :: (a -> b) -> [a] -> [b]` using recursion. Do not use the Prelude `map`.

### Assignment 2: myFilter

Write `myFilter :: (a -> Bool) -> [a] -> [a]` using recursion. Do not use the Prelude `filter`.

### Assignment 3: myFoldr

Write `myFoldr :: (a -> b -> b) -> b -> [a] -> b` — a recursive implementation of `foldr`.

### Assignment 4: myTake

Write `myTake :: Int -> [a] -> [a]` that returns the first `n` elements of a list. Handle both the `n <= 0` case and the empty-list case.

### Assignment 5: flatten

Write `flatten :: [[a]] -> [a]` that concatenates a list of lists into a single list. Do not use `concat` or `concatMap`.
