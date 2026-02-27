# Exercise 26 — GHC Extensions: Syntax

## Theory

GHC ships dozens of language extensions that go beyond Haskell 2010.  The six
extensions in this exercise all make **everyday syntax more concise** without
changing the type system.

### LambdaCase

`\case` is shorthand for `\x -> case x of`.  It is most useful when you would
otherwise write a one-argument lambda whose sole purpose is pattern-matching:

```haskell
{-# LANGUAGE LambdaCase #-}

describeList :: [a] -> String
describeList = \case
  []  -> "empty"
  [_] -> "singleton"
  _   -> "longer"
```

### TupleSections

A *tuple section* leaves one or more positions of a tuple constructor blank,
turning it into a function:

```haskell
{-# LANGUAGE TupleSections #-}

-- (True,) :: b -> (Bool, b)
-- (,42)   :: a -> (a, Int)

tag :: a -> (String, a)
tag = ("item",)
```

### MultiWayIf

Instead of nested `if-then-else` chains, `MultiWayIf` lets you write a
guarded expression with `if`:

```haskell
{-# LANGUAGE MultiWayIf #-}

grade :: Int -> String
grade score = if
  | score >= 90 -> "A"
  | score >= 75 -> "B"
  | score >= 60 -> "C"
  | otherwise   -> "F"
```

### BlockArguments

Normally `do` or `\` after a function application requires parentheses.
`BlockArguments` removes that need:

```haskell
{-# LANGUAGE BlockArguments #-}

main :: IO ()
main = when True do          -- no parens around `do`
  putStrLn "BlockArguments!"
```

### NamedFieldPuns

When pattern-matching on a record you often write `Config { host = host, port = port }`.
`NamedFieldPuns` lets you drop the repetition:

```haskell
{-# LANGUAGE NamedFieldPuns #-}

showAddr :: Config -> String
showAddr Config{host, port} = host ++ ":" ++ show port
-- `host` and `port` are bound automatically
```

### RecordWildCards

`RecordWildCards` goes one step further: `Config{..}` brings *every* field
into scope under its own name:

```haskell
{-# LANGUAGE RecordWildCards #-}

showAll :: Config -> String
showAll Config{..} = "host=" ++ host ++ " port=" ++ show port
```

It also works in *construction*:

```haskell
makeConfig :: String -> Int -> Config
makeConfig host port = Config{..}
```

---

## Practice Assignments

### Assignment 1: describeWithLambdaCase

Write `describeWithLambdaCase :: Maybe Int -> String` using `\case` syntax.
`Nothing` should return `"nothing"`; `Just n` should return `"just " ++ show n`.

### Assignment 2: pairWithIndex

Write `pairWithIndex :: [a] -> [(Int, a)]` that pairs each element with its
0-based index.  Use a TupleSections or `(,)` section style.

### Assignment 3: classify

Write `classify :: Int -> String` using `MultiWayIf`:
- negative → `"neg"`
- 0 → `"zero"`
- 1–99 → `"small"`
- 100+ → `"big"`

### Assignment 4: formatConfig

Define `data Config = Config { host :: String, port :: Int }` and write
`formatConfig :: Config -> String` that returns `"host:port"` using
`NamedFieldPuns`.  Also define a `defaultConfig :: Config`.
