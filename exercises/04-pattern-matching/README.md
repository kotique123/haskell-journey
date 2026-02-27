# Exercise 04 — Pattern Matching

## Theory

Pattern matching is one of Haskell's most powerful features. It lets you simultaneously test the *shape* of a value and bind its parts to names, all in a single syntactic construct.

### Function clause patterns

You can define a function with multiple clauses, each matching a different pattern:

```haskell
-- Matching on specific values:
isZero :: Int -> Bool
isZero 0 = True
isZero _ = False   -- _ is wildcard: matches anything, binds nothing
```

Clauses are tried top to bottom; the first matching clause wins.

### `case` expressions

`case` brings pattern matching to expression context:

```haskell
describeSign :: Int -> String
describeSign n = case n of
  0 -> "zero"
  1 -> "one"
  _ -> "something else"
```

### List patterns

Lists have two constructors: `[]` (empty) and `(x:xs)` (head `x` consed onto tail `xs`):

```haskell
firstElement :: [a] -> String
firstElement []    = "empty list"
firstElement (x:_) = "starts with something"

-- Multiple elements:
twoOrMore :: [a] -> Bool
twoOrMore (_:_:_) = True
twoOrMore _       = False
```

### Tuple patterns

Tuples are matched by wrapping the pattern in the appropriate parentheses:

```haskell
addPair :: (Int, Int) -> Int
addPair (x, y) = x + y

swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)
```

### `Maybe` type

`Maybe a` is either `Nothing` or `Just a`. It represents optional or potentially absent values — a safe alternative to null:

```haskell
ghci> :info Maybe
data Maybe a = Nothing | Just a

safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

ghci> safeDiv 10 2
Just 5
ghci> safeDiv 10 0
Nothing
```

Pattern matching on `Maybe` is natural:

```haskell
showResult :: Maybe Int -> String
showResult Nothing  = "no result"
showResult (Just n) = "result: " ++ show n
```

### Wildcard `_`

Use `_` when you don't need a value:

```haskell
third :: (a, b, c) -> c
third (_, _, z) = z
```

### Irrefutable patterns with `~`

A lazy/irrefutable pattern `~pat` always succeeds at match time (the actual match is deferred). Useful in certain performance scenarios; you'll rarely need them as a beginner.

---

## Practice Assignments

### Assignment 1: describeList

Write `describeList :: [a] -> String` returning `"empty"` for `[]`, `"singleton"` for a one-element list, and `"longer list"` otherwise. Use pattern matching.

### Assignment 2: fst3/snd3/thd3

Write three functions to extract each component of a 3-tuple:
- `fst3 :: (a,b,c) -> a`
- `snd3 :: (a,b,c) -> b`
- `thd3 :: (a,b,c) -> c`

### Assignment 3: fibonacci

Write `fibonacci :: Int -> Int` using pattern matching on the base cases `0` and `1`, and a recursive case for larger values. Remember: fib(0)=0, fib(1)=1.

### Assignment 4: describeNumber

Write `describeNumber :: Int -> String` that returns `"zero"` for 0, `"one"` for 1, `"two"` for 2, `"small"` for 3–9, and `"large"` for 10 and above.

### Assignment 5: safeHead

Write `safeHead :: [a] -> Maybe a` that returns `Nothing` for an empty list and `Just` the first element otherwise.
