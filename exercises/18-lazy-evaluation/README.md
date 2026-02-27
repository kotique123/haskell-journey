# Exercise 18 — Lazy Evaluation

## Theory

Haskell is a *non-strict* (lazy) language: expressions are not evaluated until their value is needed.  This single property enables infinite data structures, concise pipelines, and elegant abstractions — but it also introduces the risk of space leaks if you're not careful.

### Thunks and WHNF

Every unevaluated expression is stored as a *thunk* — a suspended computation.  Evaluation proceeds to *Weak Head Normal Form* (WHNF), meaning the outermost constructor is exposed but the arguments remain as thunks.

```haskell
-- This list is never fully evaluated in memory;
-- only the prefix you consume is forced.
ones :: [Int]
ones = 1 : ones

-- take 5 ones  =>  [1,1,1,1,1]  (only 5 thunks ever forced)
```

### Infinite lists

Because evaluation is demand-driven, you can define infinite lists as long as you only ever consume a finite prefix:

```haskell
-- Standard idiom: co-recursive, sharing via zipWith
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- ghci> take 10 fibs
-- [0,1,1,2,3,5,8,13,21,34]
```

The `zipWith` version is *O(n)* in both time and space for the prefix because the spine is shared.

### `Data.List.unfoldr`

`unfoldr :: (b -> Maybe (a, b)) -> b -> [a]` is the canonical way to build a list from a seed:

```haskell
import Data.List (unfoldr)

countdown :: Int -> [Int]
countdown = unfoldr step
  where step 0 = Nothing
        step n = Just (n, n - 1)

-- ghci> countdown 5
-- [5,4,3,2,1]
```

`Nothing` terminates the list; `Just (value, nextSeed)` emits `value` and continues.

### Avoiding space leaks with `foldl'`

Lazy `foldl` builds a chain of thunks that lives in memory until the final result is demanded — a classic space leak on large lists.  `Data.List.foldl'` forces the accumulator at every step:

```haskell
import Data.List (foldl')

-- Leaks O(n) thunks:
badSum :: [Int] -> Int
badSum = foldl (+) 0

-- Constant stack space:
goodSum :: [Int] -> Int
goodSum = foldl' (+) 0
```

`seq a b` evaluates `a` to WHNF before returning `b`.  The bang-pattern extension `!x` in a function argument is syntactic sugar for `seq`.  `Control.DeepSeq.force` fully evaluates a structure to Normal Form (NF).

### Lazy Sieve of Eratosthenes

A beautiful example of lazy evaluation producing an infinite list of primes:

```haskell
sieve :: [Integer] -> [Integer]
sieve (p : xs) = p : sieve [x | x <- xs, x `mod` p /= 0]

primes :: [Integer]
primes = sieve [2..]
-- ghci> take 6 primes  =>  [2,3,5,7,11,13]
```

---

## Practice Assignments

### 1. naturals

- `naturals :: [Integer]` — the infinite list `[1, 2, 3, …]`.

### 2. fibs

- `fibs :: [Integer]` — the infinite Fibonacci sequence starting `[0, 1, 1, 2, 3, 5, …]`.  Use the efficient `zipWith` co-recursive definition.

### 3. primes

- `primes :: [Integer]` — infinite list of primes produced by a lazy Sieve of Eratosthenes.

### 4: strictSum

- `strictSum :: [Int] -> Int` — sum the list using `foldl'` so that the accumulator is forced at each step, avoiding a space leak.

### 5: collatz

- `collatz :: Integer -> [Integer]` — the Collatz sequence from `n` to `1` inclusive.  Use `Data.List.unfoldr`.  The rule: if `n` is even, next is `n/2`; if odd, next is `3n+1`; stop after emitting `1`.
