# Learn Haskell — From Zero to Advanced

A structured, hands-on Haskell curriculum with 30 progressive exercises. Each exercise is a self-contained Stack project containing:

- **README.md** — theory explanation + numbered practice assignments
- **`src/Exercise.hs`** — skeleton with `undefined` stubs for you to fill in
- **`test/ExerciseSpec.hs`** — pre-written Hspec tests (do not modify these)

## Quick Start

Prerequisites: [Stack](https://docs.haskellstack.org/en/stable/README/)

```bash
# Enter an exercise
cd exercises/01-hello-haskell

# Run the tests (they will all fail until you implement the stubs)
stack test

# Open a REPL for the exercise
stack ghci src/Exercise.hs
```

Your job for each exercise: read `README.md`, then edit `src/Exercise.hs` to replace `undefined` with working implementations until all tests pass.

---

## Curriculum

### Part 1 — Foundations

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 01 | [hello-haskell](exercises/01-hello-haskell) | GHCi, `main`, `putStrLn`, expressions, `let` |
| 02 | [types-and-signatures](exercises/02-types-and-signatures) | `Int`, `Integer`, `Double`, `Bool`, `Char`, `String`, type signatures |
| 03 | [functions](exercises/03-functions) | Function definitions, `where`, `let`, currying, partial application |
| 04 | [pattern-matching](exercises/04-pattern-matching) | Case expressions, function clauses, wildcards, tuple patterns |
| 05 | [guards-and-conditionals](exercises/05-guards-and-conditionals) | Guards, `if/then/else`, `when` |
| 06 | [lists](exercises/06-lists) | List literals, `:`, ranges, list comprehensions, common functions |
| 07 | [recursion](exercises/07-recursion) | Base/recursive cases, structural recursion, accumulator pattern |
| 08 | [higher-order-functions](exercises/08-higher-order-functions) | `map`, `filter`, `foldr`, `foldl'`, `zipWith`, `(.)`, `($)` |
| 09 | [algebraic-data-types](exercises/09-algebraic-data-types) | `data`, product/sum types, `newtype`, record syntax, `deriving` |
| 10 | [typeclasses](exercises/10-typeclasses) | `Eq`, `Ord`, `Show`, `Read`, `Enum`, `Bounded`, defining instances |

### Part 2 — Core Abstractions

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 11 | [maybe-and-either](exercises/11-maybe-and-either) | `Maybe`, `Either`, safe operations, `fromMaybe`, monadic chaining |
| 12 | [functor-applicative](exercises/12-functor-applicative) | `Functor` (`fmap`, `<$>`), `Applicative` (`<*>`, `pure`, `liftA2`) |
| 13 | [monad](exercises/13-monad) | `Monad`, `>>=`, `>>`, `return`, `do`-notation desugaring |
| 14 | [common-monads](exercises/14-common-monads) | `Maybe`/`Either`/`List` monads in practice |
| 15 | [io-and-effects](exercises/15-io-and-effects) | `getLine`, file IO, `IORef`, `catch`, `IOException` |

### Part 3 — Intermediate

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 16 | [state-reader-writer](exercises/16-state-reader-writer) | `State`, `Reader`, `Writer` monads (`mtl`) |
| 17 | [monad-transformers](exercises/17-monad-transformers) | `ExceptT`, `StateT`, `ReaderT`, transformer stacks, `lift`/`liftIO` |
| 18 | [lazy-evaluation](exercises/18-lazy-evaluation) | Thunks, `seq`, `BangPatterns`, `force`, infinite lists |
| 19 | [data-structures](exercises/19-data-structures) | `Data.Map.Strict`, `Data.Set`, `Data.Sequence`, `Data.IntMap` |
| 20 | [text-and-bytestring](exercises/20-text-and-bytestring) | `Data.Text`, `Data.ByteString`, `OverloadedStrings` |

### Part 4 — Advanced

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 21 | [foldable-traversable](exercises/21-foldable-traversable) | `Foldable` (`toList`, `foldMap`), `Traversable` (`traverse`, `sequenceA`) |
| 22 | [concurrency](exercises/22-concurrency) | `forkIO`, `MVar`, `STM`, `TVar`, `atomically`, `async`/`wait` |
| 23 | [type-families-gadts](exercises/23-type-families-gadts) | `TypeFamilies`, `GADTs`, `DataKinds`, type-safe containers |
| 24 | [lenses](exercises/24-lenses) | `lens` library, `(^.)`, `(.~)`, `(%~)`, `makeLenses` |
| 25 | [template-haskell-generics](exercises/25-template-haskell-generics) | `TemplateHaskell`, `GHC.Generics`, `deriving via` |

### Part 5 — GHC Extensions & Mastery

| # | Exercise | Key Concepts |
|---|----------|-------------|
| 26 | [ghc-extensions-syntax](exercises/26-ghc-extensions-syntax) | `LambdaCase`, `TupleSections`, `MultiWayIf`, `BlockArguments` |
| 27 | [ghc-extensions-types](exercises/27-ghc-extensions-types) | `RankNTypes`, `ScopedTypeVariables`, `TypeApplications` |
| 28 | [ghc-extensions-deriving](exercises/28-ghc-extensions-deriving) | `DerivingStrategies`, `DerivingVia`, `GeneralizedNewtypeDeriving` |
| 29 | [type-level-programming](exercises/29-type-level-programming) | `PolyKinds`, `KindSignatures`, `TypeOperators`, `ConstraintKinds` |
| 30 | [profiling-optimization](exercises/30-profiling-optimization) | `+RTS -p`, strictness analysis, `criterion` benchmarks, heap profiling |

---

## Running All Tests

```bash
# Run every exercise's test suite
for dir in exercises/*/; do (cd "$dir" && stack test --silent); done
```
