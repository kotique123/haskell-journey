# Exercise 02 — Types and Signatures

## Theory

Haskell is a *statically typed* language: every expression has a type that is known at compile time. Types are not just documentation — the compiler uses them to catch entire categories of bugs before your program runs.

### Type signatures

You write a type signature above a definition using `::` ("has type"):

```haskell
age :: Int
age = 30

greet :: String -> String
greet name = "Hello, " ++ name
```

The compiler infers types automatically, but explicit signatures are strongly encouraged as they serve as machine-checked documentation.

### Basic types

| Type      | Description                            | Example values       |
|-----------|----------------------------------------|----------------------|
| `Int`     | Fixed-precision integer (at least 30 bits) | `42`, `-7`       |
| `Integer` | Arbitrary-precision integer            | `factorial 100`      |
| `Double`  | 64-bit floating-point                  | `3.14`, `2.718`      |
| `Bool`    | Boolean                                | `True`, `False`      |
| `Char`    | Unicode character                      | `'a'`, `'\n'`        |
| `String`  | Alias for `[Char]`                     | `"hello"`            |

```haskell
ghci> :type True
True :: Bool
ghci> :type 'x'
'x' :: Char
ghci> :type "hello"
"hello" :: String
```

### `Int` vs `Integer`

Use `Int` when you need speed and know values fit in machine word size. Use `Integer` when you need exact results for arbitrarily large numbers (e.g., factorials of large numbers):

```haskell
ghci> (2 :: Int) ^ 62
4611686018427387904
ghci> (2 :: Integer) ^ 200
1606938044258990275541962092341162602522202993782792835301376
```

### Characters and `toEnum` / `fromEnum`

Every `Char` maps to a Unicode code point (an `Int`). The Prelude functions `toEnum` and `fromEnum` convert between them:

```haskell
ghci> fromEnum 'A'
65
ghci> toEnum 65 :: Char
'A'
ghci> fromEnum '0'
48
ghci> toEnum (fromEnum '0' + 3) :: Char
'3'
```

This is very useful for digit↔character conversions.

### Function types with multiple arguments

Haskell functions are *curried* — a two-argument function has type `a -> b -> c`, meaning it takes one argument and returns a new function expecting the second:

```haskell
add :: Int -> Int -> Int
add x y = x + y

-- Equivalent:
add x = \y -> x + y
```

### Type errors

The compiler rejects programs where types don't match. This is a feature, not a bug:

```haskell
-- ERROR: can't add a String and an Int
bad = "hello" + 42
```

---

## Practice Assignments

### Assignment 1: factorial

Write `factorial :: Integer -> Integer`. `factorial 0 = 1`, and for `n > 0`, `factorial n = n * factorial (n-1)`. Use `Integer` (not `Int`) to handle large values without overflow.

### Assignment 2: isEven

Write `isEven :: Int -> Bool` that returns `True` if its argument is even. Hint: use `mod` or the Prelude's `even`.

### Assignment 3: digitToChar

Write `digitToChar :: Int -> Char` that converts a digit `0–9` to its character representation `'0'–'9'`. Use `toEnum` and `fromEnum`.

### Assignment 4: charToDigit

Write `charToDigit :: Char -> Int` — the inverse of `digitToChar`. Given a character `'0'–'9'`, return the corresponding integer.

### Assignment 5: initials

Write `initials :: String -> String -> String` that takes a first name and last name and returns a string like `"J.D."` — the first character of each name followed by a dot.
