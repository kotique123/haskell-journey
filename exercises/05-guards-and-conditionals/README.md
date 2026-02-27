# Exercise 05 — Guards and Conditionals

## Theory

Guards and conditionals let you choose between different results based on boolean conditions. Haskell provides several syntactic forms for this, each with its own best use case.

### `if / then / else`

Unlike most languages, Haskell's `if` is an *expression*, not a statement — it always has a value, and both branches must exist and have the same type:

```haskell
absolute :: Int -> Int
absolute n = if n < 0 then -n else n

-- Works in any expression context:
ghci> (if True then "yes" else "no") ++ "!"
"yes!"
```

### Guards in function definitions

Guards are boolean conditions written with `|` after the function arguments. They're often more readable than nested `if` expressions:

```haskell
signOf :: Int -> String
signOf n
  | n < 0     = "negative"
  | n == 0    = "zero"
  | otherwise = "positive"
```

`otherwise` is just `True` — it always matches and serves as the catch-all clause.

Guards are checked top to bottom; the first `True` guard is used.

### Guards in `case` expressions

You can combine `case` and guards:

```haskell
classifyList :: [a] -> String
classifyList xs = case xs of
  []  -> "empty"
  [_] -> "singleton"
  _   | length xs < 5 -> "short"
      | otherwise      -> "long"
```

### Multi-way `if` (GHC extension)

With `{-# LANGUAGE MultiWayIf #-}` you can write:

```haskell
describe :: Int -> String
describe n = if
  | n < 0     -> "negative"
  | n == 0    -> "zero"
  | otherwise -> "positive"
```

### `Ord` typeclass

Guards often use comparison operators: `(<)`, `(>)`, `(<=)`, `(>=)`. These come from the `Ord` typeclass, which is available for `Int`, `Double`, `Char`, `String`, and many more types.

```haskell
ghci> 3 < 5
True
ghci> "apple" < "banana"
True
ghci> compare 3 5
LT
```

### FizzBuzz pattern

The classic FizzBuzz requires testing divisibility. The key trick: test the combined condition first:

```haskell
ghci> 15 `mod` 3 == 0 && 15 `mod` 5 == 0
True
ghci> show 7
"7"
```

### Clamping a value

Clamping restricts a value to a range `[lo, hi]`: if it's below `lo` use `lo`; if above `hi` use `hi`; otherwise keep the value. This is a common pattern in graphics, UI, and numeric code.

---

## Practice Assignments

### Assignment 1: classify

Write `classify :: (Ord a, Num a) => a -> String` returning `"negative"`, `"zero"`, or `"positive"`. Use guards.

### Assignment 2: grade

Write `grade :: Int -> String` converting a numeric score to a letter grade: 90+ → `"A"`, 80+ → `"B"`, 70+ → `"C"`, 60+ → `"D"`, below 60 → `"F"`.

### Assignment 3: fizzbuzz

Write `fizzbuzz :: Int -> String`. Return `"FizzBuzz"` if divisible by both 3 and 5, `"Fizz"` if only by 3, `"Buzz"` if only by 5, otherwise `show` the number.

### Assignment 4: between

Write `between :: Ord a => a -> a -> a -> Bool` so that `between lo hi x` returns `True` when `lo <= x && x <= hi`.

### Assignment 5: clamp

Write `clamp :: Ord a => a -> a -> a -> a` so that `clamp lo hi x` returns `lo` if `x < lo`, `hi` if `x > hi`, and `x` otherwise.
