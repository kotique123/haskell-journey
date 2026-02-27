# Exercise 11 — Maybe and Either

## Theory

### Maybe: a box that might be empty

`Maybe a` represents an optional value. It has exactly two constructors:

```haskell
data Maybe a = Nothing | Just a
```

Think of it as a box: `Just 42` is a box containing `42`; `Nothing` is an empty box. This lets you model the *absence* of a value without resorting to null pointers or exceptions.

**Pattern matching:**
```haskell
describe :: Maybe Int -> String
describe Nothing  = "nothing here"
describe (Just n) = "got " ++ show n
```

**Useful helpers from `Data.Maybe`:**
```haskell
fromMaybe :: a -> Maybe a -> a
fromMaybe 0 Nothing   -- 0
fromMaybe 0 (Just 7)  -- 7

maybe :: b -> (a -> b) -> Maybe a -> b
maybe "empty" show (Just 42)  -- "42"
maybe "empty" show Nothing    -- "empty"
```

**Functor/Monad instance** lets you transform or chain `Maybe` values without unwrapping:
```haskell
fmap (+1) (Just 4)   -- Just 5
fmap (+1) Nothing    -- Nothing
```

Chaining with `>>=` (bind) — if any step produces `Nothing`, the whole chain short-circuits:
```haskell
Just 10 >>= \x -> if x > 5 then Just x else Nothing  -- Just 10
Nothing >>= \x -> Just (x + 1)                        -- Nothing
```

### Either: a box that holds a result *or* an error

`Either e a` has two constructors:

```haskell
data Either e a = Left e | Right a
```

By convention `Left` carries the *error* and `Right` carries the *success* value (mnemonic: "right is right"). This is richer than `Maybe` because the failure carries information.

```haskell
safeDivE :: Int -> Int -> Either String Int
safeDivE _ 0 = Left "division by zero"
safeDivE x y = Right (x `div` y)

-- GHCi:
safeDivE 10 2   -- Right 5
safeDivE 10 0   -- Left "division by zero"
```

**`either` function:**
```haskell
either :: (e -> c) -> (a -> c) -> Either e a -> c
either show (*2) (Right 5)          -- 10
either show (*2) (Left "oops")      -- "oops"
```

**Monadic chaining** works the same way — a `Left` anywhere short-circuits:
```haskell
Right 100 >>= \x -> if x > 50 then Right x else Left "too small"
-- Right 100
Right 10  >>= \x -> if x > 50 then Right x else Left "too small"
-- Left "too small"
```

### Do-notation with Maybe

Do-notation desugars `>>=` and `>>` into readable sequential steps:
```haskell
-- Without do-notation:
safeCalc x y z =
  safeDivE x y >>= \r1 ->
  safeDivE r1 z

-- With do-notation (identical meaning):
safeCalc x y z = do
  r1 <- safeDivE x y
  safeDivE r1 z
```

### Parsing and validation patterns

A common pattern is to parse a raw `String` and either return a validated value or an error message:
```haskell
import Text.Read (readMaybe)

parseInt :: String -> Maybe Int
parseInt = readMaybe   -- returns Nothing on failure
```

You can lift `Maybe` into `Either` when you need to carry an error message:
```haskell
toEither :: e -> Maybe a -> Either e a
toEither err Nothing  = Left err
toEither _   (Just x) = Right x
```

---

## Practice Assignments

### Assignment 1: safeDiv

Implement `safeDiv :: Int -> Int -> Maybe Int` that performs integer division, returning `Nothing` when the divisor is zero.

### Assignment 2: safeIndex

Implement `safeIndex :: [a] -> Int -> Maybe a` that returns the element at the given index, or `Nothing` for out-of-bounds or negative indices.

### Assignment 3: chainMaybe

Implement `chainMaybe :: Maybe Int -> Maybe Int` that takes a `Maybe Int`, divides it by 2 (using `safeDiv`), then divides the result by 3. Use `>>=` to chain the steps.

### Assignment 4: parseAge

Implement `parseAge :: String -> Either String Int` that parses a string as a positive integer:
- `Left "not a number"` if it cannot be parsed as an `Int`
- `Left "age must be positive"` if the parsed number is ≤ 0
- `Right n` otherwise

### Assignment 5: validateName

Implement `validateName :: String -> Either String String` that:
- Returns `Left "name too short"` if the name has fewer than 2 characters
- Returns `Right name` otherwise
