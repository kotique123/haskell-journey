# Exercise 17 — Monad Transformers

## Theory

Real programs need more than one effect at a time — errors *and* state, configuration *and* IO.  Monad transformers let you stack monads vertically, combining their effects.

### How transformer stacks work

Each transformer wraps an inner monad.  The outermost layer is the one you peel off first.

```haskell
import Control.Monad.Except
import Control.Monad.State

-- ExceptT on top of State Int
type AppM a = ExceptT String (State Int) a

-- To run it you unwrap from outside in:
-- 1. runExceptT  => State Int (Either String a)
-- 2. runState    => (Either String a, Int)
runApp :: AppM a -> Int -> (Either String a, Int)
runApp m s = runState (runExceptT m) s
```

### `ExceptT` — short-circuiting errors

`throwError` aborts the computation; `catchError` recovers from it.  Crucially, when `throwError` fires, subsequent state updates in the same branch are still observable because `State` is below `ExceptT` — state changes made *before* the error are preserved.

```haskell
safeDiv :: Int -> Int -> AppM Int
safeDiv _ 0 = throwError "division by zero"
safeDiv x y = return (x `div` y)
```

### `lift` and `liftIO`

`lift` promotes an action from the inner monad into the transformer:

```haskell
increment :: AppM ()
increment = lift $ modify (+ 1)   -- modify lives in State Int
```

`liftIO` is a specialised variant for any stack whose base is `IO`.

### `ReaderT` over IO

```haskell
import Control.Monad.Reader

type ConfigM a = ReaderT String IO a

fetchData :: ConfigM String
fetchData = do
  baseUrl <- ask
  -- liftIO lets you run IO actions inside the transformer
  liftIO $ putStrLn ("Fetching from " ++ baseUrl)
  return "data"

-- ghci> runReaderT fetchData "https://example.com"
-- Fetching from https://example.com
-- "data"
```

### `ExceptT` over IO for safe I/O

`Control.Exception.try` catches synchronous exceptions and returns `Either IOException a`.  Wrapping it in `ExceptT` converts the exception into a pure `Left`:

```haskell
import Control.Exception (try, IOException)
import Control.Monad.Except

readConfig :: FilePath -> ExceptT String IO String
readConfig path = do
  res <- liftIO (try (readFile path) :: IO (Either IOException String))
  case res of
    Left  e -> throwError (show e)
    Right c -> return c
```

### Ordering matters

The order of transformers in a stack determines semantics.  `ExceptT e (State s)` vs `StateT s (Except e)` behave differently: in the former, the state is still accessible after an error; in the latter, an error discards the state.

---

## Practice Assignments

### Assignment 1: increment / runApp

- `type AppM a = ExceptT String (State Int) a`
- `increment :: AppM ()` — increment the integer counter in the State layer.
- `runApp :: AppM a -> Int -> (Either String a, Int)` — unwrap the full stack starting from an initial counter value.

### Assignment 2: guardPositive

- `guardPositive :: Int -> AppM Int` — if the argument is ≤ 0, throw `"non-positive"`; otherwise return it unchanged.  Verify that state changes made *before* a call to `guardPositive` are preserved even when the guard fires.

### Assignment 3: greetUser

- `type ConfigM a = ReaderT String IO a`
- `greetUser :: String -> ConfigM String` — read the prefix string from the Reader environment and return `"<prefix> <name>"`.

### Assignment 4: safeReadFile

- `safeReadFile :: FilePath -> ExceptT String IO String` — attempt to read a file; convert any `IOException` into a `Left String`.  A missing path must produce `Left`, not an uncaught exception.
