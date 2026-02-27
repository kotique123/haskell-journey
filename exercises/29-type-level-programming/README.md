# Exercise 29 — Type-Level Programming

## Theory

Haskell's type system can do far more than just classify values — it can
*compute* at compile time.  This exercise introduces the core toolkit for
type-level programming.

### DataKinds and Kinds

Every type has a *kind*.  `DataKinds` promotes data constructors to the kind
level, so you can use them as type-level values:

```haskell
{-# LANGUAGE DataKinds #-}

data Color = Red | Green | Blue
-- After DataKinds:
-- 'Red, 'Green, 'Blue are type-level values of kind Color
```

### KindSignatures

Write explicit kind annotations with `::` in type positions:

```haskell
{-# LANGUAGE KindSignatures #-}
import GHC.TypeLits (Nat)

data Vec (n :: Nat) a = ...   -- n must be a type-level natural number
```

### GHC.TypeLits — Nat and Symbol

`GHC.TypeLits` provides built-in type-level naturals (`Nat`) and strings
(`Symbol`), along with the classes `KnownNat` and `KnownSymbol` that let you
*reflect* them down to runtime values:

```haskell
import GHC.TypeLits
import Data.Proxy

ghci> natVal (Proxy @3)
3
ghci> symbolVal (Proxy @"hello")
"hello"
```

### GADTs and Length-Indexed Vectors

A *GADT* (Generalised Algebraic Data Type) can carry type-level evidence in
its constructors.  A classic example is a length-indexed vector:

```haskell
{-# LANGUAGE DataKinds, GADTs, TypeOperators #-}

data Vec (n :: Nat) a where
  VNil  :: Vec 0 a
  VCons :: a -> Vec n a -> Vec (n + 1) a
```

Now `vHead` can be given a type that statically guarantees the vector is
non-empty — no runtime check needed:

```haskell
vHead :: Vec (n + 1) a -> a
vHead (VCons x _) = x
```

### TypeApplications at the Type Level

`@3` in `vReplicate @3 True` passes the type-level `Nat` `3` as an argument,
which the `KnownNat` constraint can then reflect to an `Int` at runtime:

```haskell
vReplicate :: forall n a. KnownNat n => a -> Vec n a
vReplicate x = ... (fromIntegral (natVal (Proxy @n))) ...
```

### ConstraintKinds

`ConstraintKinds` promotes `Constraint` to a first-class kind, letting you
abstract over sets of constraints:

```haskell
{-# LANGUAGE ConstraintKinds #-}

type Printable a = (Show a, Eq a)

pretty :: Printable a => a -> String
pretty = show
```

---

## Practice Assignments

### Assignment 1: Vec basics

Define the GADT `Vec (n :: Nat) a` with constructors `VNil` and `VCons`.
Implement `vHead :: Vec (n+1) a -> a`, `vTail :: Vec (n+1) a -> Vec n a`,
and `vToList :: Vec n a -> [a]`.

### Assignment 2: vLength

Implement `vLength :: KnownNat n => Vec n a -> Int` using `natVal` and `Proxy`.
The length is read entirely from the type — no pattern-matching on the vector.

### Assignment 3: vReplicate

Implement `vReplicate :: forall n a. KnownNat n => a -> Vec n a`.
Use `natVal (Proxy @n)` to get the count and build the vector recursively.

### Assignment 4: symbolName

Implement `symbolName :: forall s. KnownSymbol s => String` using
`symbolVal (Proxy @s)`.  The returned string should equal the type-level
symbol passed via TypeApplications.
