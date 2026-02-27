# Exercise 30 — Profiling and Optimization

## Theory

Writing correct Haskell is the first step; writing *fast* Haskell requires
understanding laziness, space leaks, and the tools GHC provides for
measurement.

### Space Leaks and `foldl` vs `foldl'`

Because Haskell is lazy, `foldl` builds up a chain of unevaluated thunks:

```haskell
foldl (+) 0 [1,2,3]
= foldl (+) (0+1) [2,3]
= foldl (+) ((0+1)+2) [3]
= foldl (+) (((0+1)+2)+3) []
= (((0+1)+2)+3)   -- forced NOW, O(n) stack
```

`Data.List.foldl'` is the strict variant — it forces the accumulator at
each step, keeping constant space:

```haskell
import Data.List (foldl')

strictSum :: [Int] -> Int
strictSum = foldl' (+) 0
```

### BangPatterns

`BangPatterns` lets you force an argument before entering a function body:

```haskell
{-# LANGUAGE BangPatterns #-}

go :: Int -> [Int] -> Int
go !acc []     = acc
go !acc (x:xs) = go (acc + x) xs
```

The `!` in `!acc` means "evaluate `acc` to WHNF before proceeding".

### Strict Fields

Prefixing a field type with `!` in a data declaration makes the field *strict*
— it is forced when the constructor is applied:

```haskell
data StrictPair a b = StrictPair !a !b
```

### NFData, deepseq, and force

`Control.DeepSeq.NFData` provides `rnf` (reduce to Normal Form), which fully
evaluates a value.  Use `deepseq` / `force` to eliminate laziness on demand:

```haskell
import Control.DeepSeq

-- Force the spine and all elements of a list:
forceList :: NFData a => [a] -> [a]
forceList xs = xs `deepseq` xs
```

### Criterion Benchmarking

`criterion` provides a statistical microbenchmarking framework:

```haskell
import Criterion.Main

main :: IO ()
main = defaultMain
  [ bench "negate 1000" $ nf (map negate) [1..1000 :: Int]
  , bench "sum lazy"    $ whnf (foldl (+) 0) [1..10000 :: Int]
  ]
```

- `nf f x` — applies `f x` and forces the result to *Normal Form*
- `whnf f x` — applies `f x` and forces only to *WHNF* (outer constructor)
- `bgroup` — groups related benchmarks under a label

Run with `stack exec bench-exercise` (after `stack build`).

### +RTS -p Profiling

Compile with `-prof -fprof-auto` and run with `+RTS -p -RTS` to generate a
`.prof` file showing cost centres:

```bash
stack build --profile
stack exec -- your-program +RTS -p -RTS
cat your-program.prof
```

---

## Practice Assignments

### Assignment 1: lazySum vs strictSum

Implement `lazySum :: [Int] -> Int` using `foldl` (space-leak version) and
`strictSum :: [Int] -> Int` using `foldl'` (correct version).
Both should return the same answer.

### Assignment 2: naiveFib

Implement `naiveFib :: Int -> Integer` — the classic doubly-recursive
Fibonacci that runs in O(2ⁿ) time.

### Assignment 3: memoFib

Implement `memoFib :: Int -> Integer` in O(n) time using a self-referential
list (`fibs = 0 : 1 : zipWith (+) fibs (tail fibs)`).

### Assignment 4: forceList

Implement `forceList :: NFData a => [a] -> [a]` that fully evaluates a list
using `deepseq` and returns it unchanged.

### Assignment 5: StrictPair

Define `data StrictPair a b = StrictPair !a !b deriving (Show, Eq)` with
strict fields and a smart constructor `mkStrictPair :: a -> b -> StrictPair a b`.
