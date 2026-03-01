# Exercise 16 — State, Reader, Writer

## Theory

Haskell's `mtl` library provides three foundational effect monads that each capture a single, well-defined pattern of computation.

### State monad

`State s a` threads a mutable value of type `s` through a computation that produces an `a`.  Under the hood it is a newtype around `s -> (a, s)`.

```haskell
import Control.Monad.State

counter :: State Int String
counter = do
  n <- get           -- read current state
  put (n + 1)        -- replace it
  modify (* 2)       -- apply a function
  n' <- gets (* 10)  -- read a projection
  return (show n')

-- ghci> runState counter 3   =>  ("80", 8)
-- ghci> evalState counter 3  =>  "80"   (result only)
-- ghci> execState counter 3  =>  8      (final state only)
```

`runState` returns `(result, finalState)`, while `evalState` / `execState` discard one component.  `modify` is a convenience for `get >>= put . f`.

### Reader monad

`Reader r a` represents a computation that can consult a read-only environment of type `r`.

```haskell
import Control.Monad.Reader

data Env = Env { host :: String, port :: Int }

connectionString :: Reader Env String
connectionString = do
  e <- ask                    -- read the whole environment
  p <- asks port              -- read a projected field
  return (host e ++ ":" ++ show p)

-- ghci> runReader connectionString (Env "localhost" 5432)
-- "localhost:5432"
```

`local f m` runs `m` in a temporarily modified environment, making it easy to implement scoped configuration.

### Writer monad

`Writer w a` accumulates a log (or any `Monoid`) alongside the primary result.

```haskell
import Control.Monad.Writer

addWithLog :: Int -> Int -> Writer [String] Int
addWithLog x y = do
  tell ["adding " ++ show x ++ " and " ++ show y]
  return (x + y)

pipeline :: Writer [String] Int
pipeline = do
  a <- addWithLog 3 4
  b <- addWithLog a 10
  return b

-- ghci> runWriter pipeline
-- (17, ["adding 3 and 4","adding 7 and 10"])
-- ghci> execWriter pipeline
-- ["adding 3 and 4","adding 7 and 10"]
```

`tell` appends to the log.  `runWriter` returns `(result, log)`.

### Using `swap` and `runStack`

`Data.List.swap` from `Data.Tuple` (or you can import it from `Data.List`) flips a pair.
Since `runState m s` returns `(result, finalState)`, wrapping it with `swap` gives `(finalState, result)` — useful when callers care more about the final state than the value.

```haskell
import Data.List (swap)

runStack :: [a] -> State [a] b -> ([a], b)
runStack s m = swap (runState m s)
```

---

## Practice Assignments

### Assignment 1: stackPush / stackPop

Implement a functional stack using `State [a]`.

- `stackPush :: a -> State [a] ()` — prepend to the list (O(1) head = top).
- `stackPop :: State [a] (Maybe a)` — remove and return the top element; return `Nothing` on an empty stack *without* modifying state.

### Assignment 2: stackSize

- `stackSize :: State [a] Int` — return the number of elements currently on the stack without changing it.

### Assignment 3: getRetryMessage

Given `data Config = Config { maxRetries :: Int, timeout :: Int }`, implement:

- `getRetryMessage :: Reader Config String`

It must produce exactly `"Will retry N times with timeout T"` where N and T come from the environment.

### Assignment 4: logComputation

- `logComputation :: Int -> Writer [String] Int`

Compute the factorial of the argument.  For each step `k` (from 1 to n), append exactly one entry to the log in the form `"k! = result"`.  The final Writer value is the complete factorial.
