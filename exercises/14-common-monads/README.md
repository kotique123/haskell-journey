# Exercise 14 — Common Monads in Practice

## Theory

### Using Maybe, Either, and [] together

You have now seen three fundamental monads. This exercise puts them to practical use:

| Monad | Models | Short-circuit condition |
|-------|--------|------------------------|
| `Maybe a` | Optionality | `Nothing` |
| `Either e a` | Failure with message | `Left e` |
| `[a]` | Non-determinism / multiple results | empty list `[]` |

### Maybe monad: mathematical safe operations

A common use is safe numerical operations. For example, a safe square root:

```haskell
safeSqrt :: Double -> Maybe Double
safeSqrt x
  | x < 0    = Nothing
  | otherwise = Just (sqrt x)
```

You can chain this with other safe operations using do-notation or `>>=`:
```haskell
safeHypotenuse :: Double -> Double -> Maybe Double
safeHypotenuse a b = do
  sa <- safeSqrt a
  sb <- safeSqrt b
  safeSqrt (sa*sa + sb*sb)
```

### Either monad: validation pipelines

`Either` shines when you need to validate multiple fields and report the *first* error:

```haskell
validateAge :: Int -> Either String Int
validateAge n
  | n < 0 || n > 150 = Left "age out of range"
  | otherwise         = Right n

validateName :: String -> Either String String
validateName "" = Left "name cannot be empty"
validateName n  = Right n

validatePerson :: String -> Int -> Either String (String, Int)
validatePerson name age = do
  n <- validateName name
  a <- validateAge age
  return (n, a)
```

Note: `Either` is *fail-fast* — it stops at the first `Left`. If you need to collect *all* errors, look at `Validation` from the `validation` package.

### List monad: non-determinism and search

The list monad lets you express computations with multiple possible outcomes. `>>=` applies a function to every element and concatenates the results:

```haskell
[1,2,3] >>= \x -> [x, x*10]
-- [1,10,2,20,3,30]
```

**`guard`** prunes branches that don't satisfy a condition:
```haskell
import Control.Monad (guard)

evens :: [Int]
evens = do
  n <- [1..10]
  guard (even n)
  return n
-- [2,4,6,8,10]
```

This is the idiomatic way to write list comprehensions with conditions using the list monad.

### Knight moves example

A chess knight at position `(r, c)` can move to 8 candidate positions. Using the list monad with `guard` to filter off-board positions is elegant:

```haskell
moves :: [(Int,Int)]
moves = [(-2,-1),(-2,1),(-1,-2),(-1,2),(1,-2),(1,2),(2,-1),(2,1)]
```

For each offset `(dr, dc)` in `moves`, the new position is `(r+dr, c+dc)`, valid when both coordinates are in `[1..8]`.

### Pythagorean triples with the list monad

Generating Pythagorean triples up to `n` is a classic list-monad problem:

```haskell
-- Sketch (do not use this directly — write your own):
triples n = do
  c <- [1..n]
  b <- [1..c]
  a <- [1..b]
  guard (a*a + b*b == c*c)
  return (a, b, c)
```

The key: `guard` filters out combinations that do not satisfy the Pythagorean condition.

### Solving quadratic equations with Maybe

```haskell
solveQuadratic a b c
  | disc < 0  = Nothing
  | otherwise = Just ((-b + sqrtDisc) / (2*a), (-b - sqrtDisc) / (2*a))
  where
    disc     = b*b - 4*a*c
    sqrtDisc = sqrt disc
```

---

## Practice Assignments

### Assignment 1: safeSqrt

Implement `safeSqrt :: Double -> Maybe Double` returning `Nothing` for negative inputs.

### Assignment 2: solveQuadratic

Implement `solveQuadratic :: Double -> Double -> Double -> Maybe (Double, Double)` solving `ax² + bx + c = 0`. Return `Nothing` when the discriminant is negative; otherwise return `Just (root1, root2)` where `root1 >= root2`.

### Assignment 3: validatePerson

Implement `validatePerson :: String -> Int -> Either String (String, Int)` that validates:
- Name must be non-empty; on failure: `Left "name cannot be empty"`
- Age must be in `[0, 150]`; on failure: `Left "age out of range"`
- On success: `Right (name, age)`

### Assignment 4: knightMoves

Implement `knightMoves :: (Int, Int) -> [(Int, Int)]` returning all valid knight moves from the given position on an 8×8 board (coordinates `1..8`). Use the list monad with `guard`.

### Assignment 5: pythagorean3

Implement `pythagorean3 :: Int -> [(Int, Int, Int)]` returning all Pythagorean triples `(a, b, c)` with `a <= b < c <= n` using the list monad with `guard`.
