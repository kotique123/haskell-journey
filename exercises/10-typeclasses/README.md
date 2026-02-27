# Exercise 10 — Typeclasses

## Theory

Typeclasses are Haskell's mechanism for ad-hoc polymorphism — they let you define a common interface that multiple types can implement in their own way. Think of them as interfaces in Java or traits in Rust, but more powerful.

### What is a typeclass?

A typeclass declaration introduces a *class name*, one or more *type variables*, and a set of *method signatures*:

```haskell
class Printable a where
  display :: a -> String
```

Any type can be made an *instance* of `Printable` by providing `display`:

```haskell
instance Printable Bool where
  display True  = "yes"
  display False = "no"

instance Printable Int where
  display n = "the integer " ++ show n
```

Now `display` works for any type that has a `Printable` instance.

### Built-in typeclasses

| Typeclass | Key methods                         | Examples of instances      |
|-----------|-------------------------------------|---------------------------|
| `Eq`      | `(==)`, `(/=)`                      | `Int`, `Bool`, `String`   |
| `Ord`     | `compare`, `(<)`, `(>)`             | `Int`, `Char`, `Double`   |
| `Show`    | `show :: a -> String`               | Almost everything          |
| `Read`    | `read :: String -> a`               | `Int`, `Double`, etc.      |
| `Enum`    | `succ`, `pred`, `fromEnum`, `toEnum`| `Int`, `Char`, `Bool`     |
| `Bounded` | `minBound`, `maxBound`              | `Int`, `Bool`, `Char`     |
| `Num`     | `(+)`, `(*)`, `negate`, `abs`       | `Int`, `Double`           |

### `deriving` vs manual instances

For many typeclasses the compiler can auto-derive an instance based on the type's structure:

```haskell
data Season = Spring | Summer | Autumn | Winter
  deriving (Show, Eq, Ord, Enum, Bounded)

ghci> [minBound..maxBound] :: [Season]
[Spring,Summer,Autumn,Winter]
ghci> succ Spring
Summer
ghci> Spring < Winter
True
```

You write manual instances when the auto-derived behaviour isn't what you want (e.g., a custom `Show`).

### Typeclass constraints in signatures

When a function works for any type with a certain typeclass, you write the constraint before `=>`:

```haskell
showAndCompare :: (Show a, Ord a) => a -> a -> String
showAndCompare x y = show x ++ " vs " ++ show y ++ ": " ++ result
  where result = case compare x y of
          LT -> "less"
          EQ -> "equal"
          GT -> "greater"
```

### Higher-kinded typeclasses

Typeclasses can abstract over *type constructors* (types that take type arguments like `Maybe`, `[]`, or your own `Stack`):

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
```

Here `f` is a type constructor (kind `* -> *`), not a plain type. This is what allows `map` to work uniformly on lists, `Maybe`, trees, etc.

### `newtype`

`newtype` wraps a single existing type into a brand new type with zero runtime overhead:

```haskell
newtype Metres = Metres Double deriving (Show, Eq, Ord)
newtype Seconds = Seconds Double deriving (Show, Eq, Ord)

-- The compiler now prevents mixing metres and seconds!
```

---

## Practice Assignments

### Assignment 1: allColors

Using the `Color` type defined in `Exercise.hs`, implement `allColors :: [Color]` that returns all three colours. Use the `Enum` and `Bounded` instances via the range syntax `[minBound..maxBound]`.

### Assignment 2: Describable Color

Write an instance of the `Describable` typeclass for `Color` mapping `Red` → `"red"`, `Green` → `"green"`, `Blue` → `"blue"`.

### Assignment 3: Describable Bool

Write an instance of `Describable` for `Bool` mapping `True` → `"yes"`, `False` → `"no"`.

### Assignment 4: Container Stack

Write a `Container` instance for `Stack`. `empty` should be an empty stack, `insert` should push to the front of the internal list, and `toList` should return the underlying list.
