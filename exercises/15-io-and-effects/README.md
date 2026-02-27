# Exercise 15 — IO and Effects

## Theory

### The IO monad

In Haskell, all side effects — reading files, writing to a terminal, generating random numbers — live inside the `IO` monad. A value of type `IO a` is an *action* that, when executed, performs effects and produces a result of type `a`.

```haskell
-- These are IO actions — they describe effects, they don't perform them yet
getLine  :: IO String
putStrLn :: String -> IO ()
readFile :: FilePath -> IO String
```

You sequence IO actions with do-notation:
```haskell
main :: IO ()
main = do
  putStr "Enter your name: "
  name <- getLine            -- bind the result of getLine
  putStrLn ("Hello, " ++ name ++ "!")
```

### Reading and writing files

```haskell
readFile  :: FilePath -> IO String     -- reads entire file as String
writeFile :: FilePath -> String -> IO ()  -- overwrites
appendFile :: FilePath -> String -> IO () -- appends
```

**Checking existence** with `System.Directory`:
```haskell
import System.Directory (doesFileExist)

doesFileExist :: FilePath -> IO Bool
```

**Catching exceptions** — `readFile` on a missing file throws an `IOException`:
```haskell
import Control.Exception (catch, IOException)

safeReadFile :: FilePath -> IO (Maybe String)
safeReadFile path =
  (Just <$> readFile path) `catch` handler
  where
    handler :: IOException -> IO (Maybe String)
    handler _ = return Nothing
```

### IORef: mutable state in IO

`Data.IORef` provides mutable references — the closest thing to a variable in Haskell:

```haskell
import Data.IORef

newIORef    :: a -> IO (IORef a)          -- create with initial value
readIORef   :: IORef a -> IO a            -- read current value
writeIORef  :: IORef a -> a -> IO ()      -- overwrite
modifyIORef :: IORef a -> (a -> a) -> IO () -- apply a function
```

Example — a counter:
```haskell
makeCounter :: IO (IO Int)
makeCounter = do
  ref <- newIORef 0           -- fresh IORef per call
  return $ do                 -- returns an IO action
    modifyIORef ref (+1)
    readIORef ref
```

Each call to `makeCounter` creates a *new*, independent `IORef`.

### Handling errors with Either in IO

You can return `Either` from an `IO` action to signal errors without raising exceptions — a clean, pure interface:

```haskell
safeDivIO :: Int -> Int -> IO (Either String Int)
safeDivIO _ 0 = return (Left "division by zero")
safeDivIO x y = return (Right (x `div` y))
```

### Looping in IO: recursion and helpers

Haskell has no built-in loop syntax; instead you use recursion or combinators:

```haskell
-- Recursive loop until predicate
repeatUntil :: IO Bool -> IO () -> IO ()
repeatUntil predicate action = do
  done <- predicate
  if done
    then return ()
    else do
      action
      repeatUntil predicate action
```

Standard combinators for IO loops:
```haskell
forM_   :: [a] -> (a -> IO b) -> IO ()
mapM_   :: (a -> IO b) -> [a] -> IO ()
replicateM_ :: Int -> IO a -> IO ()
```

### Buffering

By default, output to a `Handle` may be buffered. You can control this:
```haskell
import System.IO (hSetBuffering, BufferMode(..))

hSetBuffering stdout NoBuffering
hSetBuffering stdout LineBuffering
```

This is especially important when interleaving `putStr` and `getLine`.

---

## Practice Assignments

### Assignment 1: countLines

Implement `countLines :: FilePath -> IO Int` that counts the number of lines in the given file. If the file does not exist, return `0` (do not throw an exception).

### Assignment 2: appendToFile

Implement `appendToFile :: FilePath -> String -> IO ()` that appends the given string followed by a newline (`'\n'`) to the file.

### Assignment 3: makeCounter

Implement `makeCounter :: IO (IO Int)` that creates a fresh counter. Each time the returned `IO Int` action is executed it should increment the counter by 1 and return the new value (starting from 1).

### Assignment 4: safeDivIO

Implement `safeDivIO :: Int -> Int -> IO (Either String Int)` that returns `Left "division by zero"` when the divisor is zero, or `Right (x \`div\` y)` otherwise.

### Assignment 5: repeatUntil

Implement `repeatUntil :: IO Bool -> IO () -> IO ()` that repeatedly executes `action` until `predicate` returns `True`. The predicate is checked *before* each execution of the action; when it is `True` at the start, the action is not executed at all.
