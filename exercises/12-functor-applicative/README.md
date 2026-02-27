# Exercise 12 — Functor and Applicative

## Theory

### Functor: mapping over a context

A `Functor` is any type constructor `f` that supports a mapping operation:

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

The `<$>` operator is an infix alias for `fmap`:
```haskell
(+1) <$> Just 4    -- Just 5
(+1) <$> Nothing   -- Nothing
(+1) <$> [1,2,3]   -- [2,3,4]
(+1) <$> Right 7   -- Right 8 :: Either e Int
```

Think of `f a` as a *context* holding values of type `a`. `fmap` reaches inside the context and transforms every `a` into a `b`, leaving the context structure intact.

**Functor laws** (must hold for all lawful instances):
```haskell
fmap id x      == x             -- identity
fmap (f . g) x == fmap f (fmap g x)  -- composition
```

### Applicative: applying functions inside a context

`Applicative` extends `Functor` with two new abilities:

```haskell
class Functor f => Applicative f where
  pure  :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
```

- `pure` lifts a plain value into the context.
- `<*>` applies a *wrapped* function to a *wrapped* argument.

```haskell
-- GHCi examples:
pure 42 :: Maybe Int      -- Just 42
pure 42 :: [Int]          -- [42]

Just (+10) <*> Just 5     -- Just 15
Just (+10) <*> Nothing    -- Nothing
Nothing    <*> Just 5     -- Nothing
```

**`liftA2`** combines two contexts using a binary function:
```haskell
import Control.Applicative (liftA2)

liftA2 (+) (Just 3) (Just 4)   -- Just 7
liftA2 (+) Nothing  (Just 4)   -- Nothing
liftA2 (,) [1,2] [3,4]         -- [(1,3),(1,4),(2,3),(2,4)]
```

### Applicative for lists: non-determinism

The list `Applicative` models *non-determinism* — every function in the first list is applied to every value in the second:

```haskell
[(+1), (*2)] <*> [10, 20]
-- [11, 21, 20, 40]

(,) <$> "AB" <*> "12"
-- [('A','1'),('A','2'),('B','1'),('B','2')]
```

This is the standard way to generate Cartesian products with `Applicative`.

### Applicative laws

```haskell
pure id <*> v            == v                          -- identity
pure f  <*> pure x       == pure (f x)                 -- homomorphism
u       <*> pure y       == pure ($ y) <*> u           -- interchange
pure (.) <*> u <*> v <*> w == u <*> (v <*> w)         -- composition
```

### Functor vs Applicative

| Operation | Type | Use |
|-----------|------|-----|
| `fmap` / `<$>` | `(a -> b) -> f a -> f b` | Apply a plain function inside a context |
| `<*>` | `f (a -> b) -> f a -> f b` | Apply a wrapped function to a wrapped value |
| `liftA2` | `(a -> b -> c) -> f a -> f b -> f c` | Combine two contexts with a binary function |

When you need to chain operations where each step *depends* on the previous result, you need `Monad`. When steps are independent, `Applicative` suffices and is more compositional.

---

## Practice Assignments

### Assignment 1: addOne

Implement `addOne :: Maybe Int -> Maybe Int` that adds 1 to the value inside a `Maybe` using `fmap`.

### Assignment 2: safeSquareRoot

Implement `safeSquareRoot :: Double -> Maybe Double` that returns `Nothing` for negative inputs and `Just (sqrt x)` otherwise.

### Assignment 3: applyMaybe

Implement `applyMaybe :: Maybe (a -> b) -> Maybe a -> Maybe b` that manually replicates the `<*>` behaviour for `Maybe` using pattern matching (do not use `<*>` directly).

### Assignment 4: liftAdd

Implement `liftAdd :: Maybe Int -> Maybe Int -> Maybe Int` that adds two `Maybe Int` values using `liftA2`.

### Assignment 5: cartesianProduct

Implement `cartesianProduct :: [a] -> [b] -> [(a, b)]` that produces the Cartesian product of two lists using the `Applicative` instance of `[]` (i.e., `<$>` and `<*>`).
