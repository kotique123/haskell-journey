# Exercise 13 — Monad

## Theory

### What is a Monad?

A `Monad` is an `Applicative` that additionally supports *sequencing* — where each step can depend on the result of the previous one:

```haskell
class Applicative m => Monad m where
  return :: a -> m a          -- same as pure
  (>>=)  :: m a -> (a -> m b) -> m b   -- "bind"
  (>>)   :: m a -> m b -> m b          -- sequence, discarding left result
```

The key insight: `>>=` lets you feed the *unwrapped* value from `m a` into a function that returns a new `m b`. This is how you chain operations while keeping the context (`Maybe`, `IO`, `[]`, …) in play.

### Do-notation desugaring

Do-notation is syntactic sugar that desugars into `>>=` and `>>`. Here is a step-by-step example:

```haskell
-- Do-notation version:
safeCalc :: Int -> Int -> Int -> Maybe Int
safeCalc a b c = do
  r1 <- safeDiv a b   -- if Nothing, whole block returns Nothing
  r2 <- safeDiv r1 c
  return (r1 + r2)

-- Desugared step 1 (innermost bind last):
safeCalc a b c =
  safeDiv a b >>= \r1 ->
  safeDiv r1 c >>= \r2 ->
  return (r1 + r2)

-- Fully explicit (equivalent):
safeCalc a b c =
  safeDiv a b >>= (\r1 ->
    (safeDiv r1 c >>= (\r2 ->
      return (r1 + r2))))
```

A `let` in do-notation is just a name binding (no `<-`, no monadic context):
```haskell
do
  x <- Just 10
  let y = x * 2   -- plain let, not monadic
  return y
-- Just 20
```

### Maybe monad: safe chaining

With `Maybe`, `>>=` short-circuits on `Nothing`:
```haskell
Just 12 >>= safeDiv' 2    -- if safeDiv' 2 12 = Just 6
        >>= safeDiv' 3    -- Just 2

Nothing >>= safeDiv' 2    -- Nothing immediately
```

### Lookup chains with >>=

`Data.List.lookup` returns `Maybe v` — perfect for chaining:
```haskell
lookup "a" [("a","b"), ("b","c")]
  >>= \v -> lookup v [("b","c"), ("c","d")]
-- Just "c"
```

### sequencing: collecting Maybe values

To turn a list of `Maybe a` into a `Maybe [a]`:
```haskell
-- If any element is Nothing, the whole result is Nothing
sequence [Just 1, Just 2, Just 3]   -- Just [1,2,3]
sequence [Just 1, Nothing, Just 3]  -- Nothing
```

The standard library provides `sequence` (and `mapM`) for this pattern.

### IO monad

`IO` is the monad that models real-world effects. You sequence IO actions with do-notation:
```haskell
greet :: IO ()
greet = do
  putStr "Enter name: "
  name <- getLine
  putStrLn ("Hello, " ++ name ++ "!")
```

Useful combinators:
```haskell
when   :: Applicative f => Bool -> f () -> f ()
unless :: Applicative f => Bool -> f () -> f ()
forM_  :: (Foldable t, Monad m) => t a -> (a -> m b) -> m ()
mapM_  :: (Foldable t, Monad m) => (a -> m b) -> t a -> m ()
```

### Monad laws

```haskell
return a >>= f   == f a                  -- left identity
m >>= return     == m                    -- right identity
(m >>= f) >>= g  == m >>= (\x -> f x >>= g)  -- associativity
```

---

## Practice Assignments

### Assignment 1: safeDiv3

Implement `safeDiv3 :: Int -> Int -> Int -> Maybe Int` that divides `a` by `b`, then divides the result by `c`. Use do-notation and `safeDiv` (or your own helper) so that any zero divisor yields `Nothing`.

### Assignment 2: lookupChain

Implement `lookupChain :: String -> [(String, String)] -> Maybe String` that looks up the given key in the association list, then looks up the *result* in the same list again. Use `>>=`.

### Assignment 3: sequenceMaybe

Implement `sequenceMaybe :: [Maybe a] -> Maybe [a]` that returns `Nothing` if any element is `Nothing`, otherwise collects all values into `Just [...]`. Implement it manually (without using `sequence` from the standard library).

### Assignment 4: whenJust

Implement `whenJust :: Maybe a -> (a -> IO b) -> IO (Maybe b)` that runs the IO action and returns `Just` the result when the input is `Just`, and returns `Nothing` (without running the action) when the input is `Nothing`.

### Assignment 5: replicateM'

Implement `replicateM' :: Monad m => Int -> m a -> m [a]` that runs the monadic action `n` times and collects the results into a list. If `n <= 0`, return `return []`.
