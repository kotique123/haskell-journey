# Exercise 09 — Algebraic Data Types

## Theory

Algebraic Data Types (ADTs) are Haskell's mechanism for defining new types. They can model anything from simple enumerations to complex tree structures, and the compiler enforces exhaustive handling of every case.

### Product types

A *product type* combines multiple fields into one value. In Haskell you define them with `data`:

```haskell
data Point = Point Double Double
  deriving (Show, Eq)

origin :: Point
origin = Point 0.0 0.0
```

You can also use *record syntax* to give fields names:

```haskell
data Rectangle = Rectangle
  { width  :: Double
  , height :: Double
  } deriving (Show, Eq)

area :: Rectangle -> Double
area r = width r * height r
```

### Sum types (variants / enums)

A *sum type* can be one of several alternatives, each with its own constructor:

```haskell
data Color = Red | Green | Blue
  deriving (Show, Eq, Ord, Enum, Bounded)

data Result a = Success a | Failure String
  deriving (Show, Eq)
```

Pattern matching dispatches on which constructor was used:

```haskell
showResult :: Result Int -> String
showResult (Success n) = "Got: " ++ show n
showResult (Failure msg) = "Error: " ++ msg
```

### `deriving`

The `deriving` clause asks the compiler to auto-generate typeclass instances:

| Typeclass | What it provides                             |
|-----------|----------------------------------------------|
| `Show`    | Convert to a `String` for display            |
| `Eq`      | `(==)` and `(/=)`                            |
| `Ord`     | `compare`, `(<)`, `(>)`, etc.                |
| `Enum`    | `succ`, `pred`, `[minBound..maxBound]`        |
| `Bounded` | `minBound` and `maxBound`                    |

```haskell
ghci> [minBound..maxBound] :: [Color]
[Red,Green,Blue]
ghci> succ Red
Green
```

### Recursive types

ADTs can refer to themselves, enabling data structures like lists and trees:

```haskell
data Tree a = Leaf | Node a (Tree a) (Tree a)
  deriving (Show, Eq)

depth :: Tree a -> Int
depth Leaf         = 0
depth (Node _ l r) = 1 + max (depth l) (depth r)
```

### Heron's formula

For a triangle with sides `a`, `b`, `c`:

```
s = (a + b + c) / 2
area = sqrt (s * (s-a) * (s-b) * (s-c))
```

```haskell
ghci> let s = (3+4+5)/2 in sqrt (s*(s-3)*(s-4)*(s-5))
6.0
```

### Record accessors

Record syntax auto-generates accessor functions:

```haskell
data Person = Person { name :: String, yearsOld :: Int } deriving (Show)

ghci> let p = Person { name = "Alice", yearsOld = 30 }
ghci> name p
"Alice"
ghci> yearsOld p
30
```

---

## Practice Assignments

### Assignment 1: area

Implement `area :: Shape -> Double` for the `Shape` type defined in `Exercise.hs`:
- `Circle r` → π × r²
- `Rectangle w h` → w × h
- `Triangle a b c` → Heron's formula

### Assignment 2: perimeter

Implement `perimeter :: Shape -> Double`:
- `Circle r` → 2 × π × r
- `Rectangle w h` → 2 × (w + h)
- `Triangle a b c` → a + b + c

### Assignment 3: opposite

Implement `opposite :: Direction -> Direction` mapping each compass direction to the one facing the other way.

### Assignment 4: fullName

Implement `fullName :: Person -> String` that concatenates `firstName` and `lastName` with a space.

### Assignment 5: isAdult

Implement `isAdult :: Person -> Bool` returning `True` if `age >= 18`.
