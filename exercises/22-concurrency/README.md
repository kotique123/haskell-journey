# Exercise 22 — Concurrency

## Theory

Haskell offers several layers of concurrency primitives, ranging from low-level
threads to high-level transactional memory.

### Threads and `MVar`

`forkIO` spawns a lightweight green thread:

```haskell
import Control.Concurrent

main :: IO ()
main = do
  forkIO $ putStrLn "Hello from thread 1"
  forkIO $ putStrLn "Hello from thread 2"
  threadDelay 100000   -- give threads time to run
```

An `MVar` is a mutable cell that can hold exactly one value (or be empty).
It is the fundamental building block for shared-state concurrency:

```haskell
import Control.Concurrent.MVar

-- Create an MVar with an initial value
counter <- newMVar (0 :: Int)

-- Atomically read-and-modify
modifyMVar_ counter (\n -> return (n + 1))

-- Read the current value
val <- readMVar counter
print val   -- 1
```

`modifyMVar_` ensures that the read and write happen atomically (no other
thread can interleave between the `takeMVar` and `putMVar` internally).

### Software Transactional Memory (STM)

`STM` provides composable atomic blocks.  Instead of locks, you describe
*what* you want to do inside `atomically`, and GHC's runtime handles
conflict detection and retry:

```haskell
import Control.Concurrent.STM

-- Create a transactional variable
tvar <- newTVarIO (0 :: Int)

-- Atomically increment
atomically $ modifyTVar' tvar (+1)

-- Read inside a transaction
val <- readTVarIO tvar
print val   -- 1
```

Transactions compose beautifully:

```haskell
transfer :: TVar Int -> TVar Int -> Int -> STM ()
transfer from to amount = do
  bal <- readTVar from
  if bal >= amount
    then do
      modifyTVar' from (subtract amount)
      modifyTVar' to   (+ amount)
    else retry   -- block until state changes
```

### The `async` Package

The `async` package wraps `forkIO` in a safe, exception-aware API:

```haskell
import Control.Concurrent.Async

-- Run two IO actions concurrently, wait for both
(a, b) <- concurrently (downloadFile url1) (downloadFile url2)

-- Run the faster of two actions
result <- race (timeout 1000 action) fallback

-- Map over a list concurrently (preserves order)
results <- mapConcurrently processItem items
```

`mapConcurrently` is equivalent to `traverse` but runs all actions in
parallel, collecting results in the original order:

```haskell
-- Fetch 10 URLs in parallel
pages <- mapConcurrently fetchURL urls
```

### Timeouts

`System.Timeout.timeout` wraps an `IO` action with a microsecond deadline:

```haskell
import System.Timeout (timeout)

result <- timeout 500000 expensiveComputation
-- Returns Nothing if it took > 0.5 seconds
```

---

## Practice Assignments

### Assignment 1: makeSharedCounter

Implement `makeSharedCounter :: IO (IO (), IO Int)` using `MVar`.  The
returned pair is *(increment action, read action)*.  Verify that sequential
increments and concurrent increments (via `forkIO`) both produce the correct
final count.

### Assignment 2: STMStack

Implement a LIFO stack backed by a `TVar [a]`.  Provide `newSTMStack`,
`pushSTM`, and `popSTM` — all operating inside `STM`.  Confirm that `popSTM`
on an empty stack returns `Nothing`.

### Assignment 3: parallelMap

Implement `parallelMap :: (a -> IO b) -> [a] -> IO [b]` using
`mapConcurrently`.  Verify that results arrive in the same order as the input
list.

### Assignment 4: timeout'

Implement `timeout' :: Int -> IO a -> IO (Maybe a)` as a thin wrapper around
`System.Timeout.timeout`.  Test that fast actions complete successfully and
slow actions return `Nothing`.
