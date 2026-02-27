# Exercise 25 — Template Haskell & Generics

## Theory

### `GHC.Generics`

`GHC.Generics` gives Haskell a *structural* description of any data type.
By deriving `Generic`, you expose the type's representation as a sum-of-
products that library authors can inspect at the type level, allowing them
to automatically derive class instances.

```haskell
{-# LANGUAGE DeriveGeneric #-}
import GHC.Generics (Generic)

data Color = Red | Green | Blue
  deriving (Show, Eq, Generic)
```

The `Generic` instance exposes `from :: a -> Rep a x` and `to :: Rep a x -> a`,
where `Rep a` encodes the structure using type-level building blocks (`M1`,
`(:+:)`, `(:*:)`, `U1`, `K1`, …).  You rarely need to work with `Rep`
directly — instead you use libraries that are *generic-aware*.

### Auto-Derived JSON with `aeson`

`aeson`'s `ToJSON` and `FromJSON` classes can be derived for free once a type
has a `Generic` instance.  Just write empty instance bodies:

```haskell
import Data.Aeson (ToJSON, FromJSON, encode, decode)

data Color = Red | Green | Blue
  deriving (Show, Eq, Generic)

instance ToJSON   Color
instance FromJSON Color
```

```haskell
-- In GHCi:
encode Red          -- "\"Red\""
decode "\"Green\"" :: Maybe Color    -- Just Green
```

For record types, `aeson` uses the field names as JSON keys:

```haskell
data Point = Point { x :: Double, y :: Double }
  deriving (Show, Eq, Generic)

instance ToJSON   Point
instance FromJSON Point

encode (Point 1.0 2.0)
-- "{\"x\":1.0,\"y\":2.0}"

decode "{\"x\":3,\"y\":4}" :: Maybe Point
-- Just (Point {x = 3.0, y = 4.0})
```

### `newtype` Deriving

A `newtype` wraps exactly one value.  With `GeneralizedNewtypeDeriving` (or
the explicit `deriving newtype` strategy), you can inherit any instance from
the underlying type:

```haskell
{-# LANGUAGE DerivingStrategies, GeneralizedNewtypeDeriving #-}

newtype Celsius = Celsius Double
  deriving stock   (Show, Eq)
  deriving newtype (Num, Fractional)

-- Now you can do arithmetic directly:
Celsius 100 + Celsius 20   -- Celsius 120.0
Celsius 37  * 2            -- Celsius 74.0
```

### `DerivingStrategies`

`DerivingStrategies` lets you be explicit about *how* each instance is
derived, avoiding ambiguity:

| Strategy   | Meaning                                            |
|------------|----------------------------------------------------|
| `stock`    | Standard GHC-built-in derivation (`Show`, `Eq`, …) |
| `newtype`  | Inherit the instance from the wrapped type          |
| `anyclass` | Empty instance body using a class default           |
| `via`      | Derive using a different but coercible type         |

```haskell
newtype Dollars = Dollars Int
  deriving stock   (Show, Eq, Ord)
  deriving newtype (Num, Enum)
```

### `DerivingVia`

`DerivingVia` lets you derive an instance *as if* your type were some other
coercible type:

```haskell
{-# LANGUAGE DerivingVia #-}

newtype Sum a = Sum a
  deriving (Semigroup, Monoid) via (Sum a)
```

This is particularly powerful for deriving type class instances from adaptor
types without writing any implementation code.

---

## Practice Assignments

### Assignment 1: ToJSON/FromJSON Color

Derive `ToJSON` and `FromJSON` for `Color` via `Generic`.  Verify that
`encode Red` produces `"\"Red\""` and that round-tripping through `encode`/`decode`
returns the original value.

### Assignment 2: ToJSON/FromJSON Point

Derive `ToJSON` and `FromJSON` for the record type `Point`.  Verify that
encoding and decoding round-trips correctly and that the JSON output contains
the key `"x"`.

### Assignment 3: Celsius newtype

Define `newtype Celsius = Celsius Double` and use `deriving newtype` to
inherit `Num` and `Fractional` from `Double`.  Confirm that arithmetic like
`Celsius 100 + Celsius 20` works without unwrapping.

### Assignment 4: temperature conversion

Implement `toFahrenheit :: Celsius -> Fahrenheit` and
`toCelsius :: Fahrenheit -> Celsius` using the standard formulae
(°F = °C × 9/5 + 32 and °C = (°F − 32) × 5/9).  Verify that 0 °C maps to
32 °F, 100 °C maps to 212 °F, and that the round-trip conversion is lossless
within floating-point precision.
