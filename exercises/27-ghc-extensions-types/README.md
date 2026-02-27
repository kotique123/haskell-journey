# Exercise 27 — GHC Extensions: Types

## Theory

Haskell's type system is already powerful, but several extensions unlock
*higher-rank types*, *explicit type application*, and *scoped type variables*
that make it possible to express constraints that vanilla Haskell 2010 cannot.

### RankNTypes and `forall`

A *rank-1* type like `a -> a` means "for all types `a`, a function from `a`
to `a`" — the caller chooses `a`.  A *rank-2* type places a `forall` *inside*
an argument position, so the *callee* chooses the type:

```haskell
{-# LANGUAGE RankNTypes #-}

-- The caller supplies a function that must work for ANY Num type.
applyTwice :: (forall a. Num a => a -> a) -> Int -> Double -> (Int, Double)
applyTwice f i d = (f i, f d)

-- This works:
applyTwice negate 3 4.5   -- (-3, -4.5)

-- This does NOT compile — (+1) is not polymorphic enough for rank-2:
-- applyTwice (+1) 3 4.5
```

Higher ranks enable patterns like `runST`, where the `s` phantom token must
never escape:

```haskell
runST :: (forall s. ST s a) -> a
```

### ScopedTypeVariables

Normally a type variable in a type signature is invisible inside the function
body.  `ScopedTypeVariables` + an explicit `forall` brings it into scope:

```haskell
{-# LANGUAGE ScopedTypeVariables #-}

replicateN :: forall a. Int -> a -> [a]
replicateN n x =
  let xs :: [a]   -- 'a' refers to the same 'a' as above
      xs = replicate n x
  in  xs
```

### TypeApplications

`TypeApplications` lets you supply a type argument directly at a call site
using `@`:

```haskell
{-# LANGUAGE TypeApplications #-}

ghci> read @Int "42"
42
ghci> show @Bool True
"True"
ghci> maxBound @Word
4294967295
```

The order follows the left-to-right order of `forall`-bound variables.

### AllowAmbiguousTypes

Normally GHC rejects a type like `forall a. Show a => String` because `a`
cannot be inferred.  `AllowAmbiguousTypes` permits the definition; the caller
must supply `@a` explicitly:

```haskell
{-# LANGUAGE AllowAmbiguousTypes, TypeApplications #-}

typeName :: forall a. Show a => String
typeName = show (undefined :: a)   -- illustration only

-- call site: typeName @Int
```

---

## Practice Assignments

### Assignment 1: applyToInt

Write `applyToInt :: (forall a. Num a => a -> a) -> Int -> Int`.
Apply the rank-2 polymorphic function to the given `Int`.

### Assignment 2: applyToBoth

Write `applyToBoth :: (forall a. Num a => a -> a) -> (Int, Double) -> (Int, Double)`.
Apply the rank-2 function to both elements of the pair.

### Assignment 3: showWithProxy

Write `showWithProxy :: forall a. Read a => String -> a`.
Use `read @a` (TypeApplications) to parse the string into the type `a`.
At the call site the caller provides `@Int`, `@Bool`, etc.

### Assignment 4: sizeOf

Write `sizeOf :: forall a. [a] -> (Int, [a])`.
Use `ScopedTypeVariables` to annotate the local binding: the returned pair
contains the length and the original list unchanged.
