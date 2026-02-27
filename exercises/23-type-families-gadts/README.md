# Exercise 23 — Type Families & GADTs

## Theory

### Generalized Algebraic Data Types (GADTs)

Standard Haskell data types have constructors that always produce the same
type.  GADTs relax this: each constructor can have a *different* return type,
enabling you to encode invariants at the type level.

Enable with `{-# LANGUAGE GADTs #-}`.

```haskell
{-# LANGUAGE GADTs #-}

data Expr a where
  Lit     :: Int  -> Expr Int
  BoolLit :: Bool -> Expr Bool
  Add     :: Expr Int -> Expr Int -> Expr Int
  If      :: Expr Bool -> Expr a -> Expr a -> Expr a
```

The evaluator is then *total* — GHC knows the return type at each branch:

```haskell
eval :: Expr a -> a
eval (Lit n)     = n          -- a ~ Int,  returns Int
eval (BoolLit b) = b          -- a ~ Bool, returns Bool
eval (Add l r)   = eval l + eval r
eval (If c t e)  = if eval c then eval t else eval e
```

This makes it *impossible* to write `Add (BoolLit True) (Lit 1)` — the
type checker rejects it at compile time.

### Type Families

Type families are functions on types.  They come in two flavours:

```haskell
{-# LANGUAGE TypeFamilies #-}

-- Open type family (can be extended later)
type family Elem (c :: * -> *) :: *
type instance Elem [] = Char     -- specialise for lists

-- Closed type family (all equations in one place)
type family IsInt a where
  IsInt Int = 'True
  IsInt _   = 'False
```

Associated type families are defined inside a type class:

```haskell
class Container f where
  type Element f
  empty  :: f
  insert :: Element f -> f -> f
```

### `DataKinds` and Type-Level Programming

`{-# LANGUAGE DataKinds #-}` promotes data constructors to the kind level,
letting you use values like `'True`, `'False`, `'[]`, and `'(:)` in type
positions:

```haskell
{-# LANGUAGE DataKinds, KindSignatures #-}

data Nat = Zero | Succ Nat

data Vec (n :: Nat) a where
  VNil  :: Vec 'Zero a
  VCons :: a -> Vec n a -> Vec ('Succ n) a
```

The length of a `Vec` is tracked in its type, so `head` on an empty vector
is a type error.

### Heterogeneous Lists

A heterogeneous list (`HList`) stores elements of *different* types, with
the type list tracked at the kind level:

```haskell
data HList (ts :: [*]) where
  HNil  :: HList '[]
  HCons :: t -> HList ts -> HList (t ': ts)

-- Example usage
myList :: HList '[Int, Bool, String]
myList = HCons 42 (HCons True (HCons "hello" HNil))
```

Both `hHead` and `hTail` are type-safe: calling them on `HNil` is a compile
error because the type `HList '[]` does not match `HList (t ': ts)`.

### Type-Level Length

Using a closed type family over the promoted list kind:

```haskell
import GHC.TypeLits (Nat)

type family Length (xs :: [*]) :: Nat where
  Length '[]       = 0
  Length (_ ': xs) = 1 + Length xs
```

This is checked entirely at compile time — no runtime cost.

---

## Practice Assignments

### Assignment 1: eval Expr

Implement `eval :: Expr a -> a` for the GADT `Expr` defined above.  The
evaluator must be type-safe: `Lit` returns `Int`, `BoolLit` returns `Bool`,
and the branches of `If` must have matching types.

### Assignment 2: HList

Implement `hHead` and `hTail` for the heterogeneous list type `HList`.  Both
functions should be total over non-empty lists and rejected by the type
checker when applied to `HNil`.
