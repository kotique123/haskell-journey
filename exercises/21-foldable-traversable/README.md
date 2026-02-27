# Exercise 21 — Foldable & Traversable

## Theory

### The `Foldable` Type Class

`Foldable` abstracts the idea of "folding" a container into a summary value.  Any type that can be reduced to a list of elements can be made `Foldable`.  The minimal definition is either `foldMap` or `foldr`.

```haskell
class Foldable t where
  foldMap :: Monoid m => (a -> m) -> t a -> m
  foldr   :: (a -> b -> b) -> b -> t a -> b
  -- ... many derived methods
```

Once you have `Foldable`, you get a rich set of derived operations for free:

```haskell
-- In GHCi (after `import Data.Foldable`):
toList  [1,2,3]           -- [1,2,3]
null    []                -- True
length  (Just 'x')        -- 1
elem    3 [1,2,3,4]       -- True
sum     [1..10]           -- 55
minimum [5,3,8,1]         -- 1
maximum [5,3,8,1]         -- 8
fold    ["hello"," ","world"]  -- "hello world"
```

A classic example is a binary tree with in-order traversal:

```haskell
data Tree a = Leaf | Node (Tree a) a (Tree a)

instance Foldable Tree where
  foldMap _ Leaf         = mempty
  foldMap f (Node l x r) = foldMap f l <> f x <> foldMap f r
```

With `foldMap`, in-order traversal falls out naturally because `<>` for lists is concatenation.

### The `Traversable` Type Class

`Traversable` goes one step further than `Foldable`: it lets you run an effectful (Applicative) function over each element and collect the results back into the *same* structure.

```haskell
class (Functor t, Foldable t) => Traversable t where
  traverse  :: Applicative f => (a -> f b) -> t a -> f (t b)
  sequenceA :: Applicative f => t (f a) -> f (t a)
```

`sequenceA` is just `traverse id`.  Both `mapM` and `sequence` are monadic
specialisations.

Common usage patterns:

```haskell
-- Validate every element with Maybe
traverse (\x -> if x > 0 then Just x else Nothing) [1,2,3]
-- Just [1,2,3]

traverse (\x -> if x > 0 then Just x else Nothing) [1,-2,3]
-- Nothing

-- Run IO actions in order and collect results
traverse putStrLn ["hello", "world"]
-- (prints both lines)  returns IO [(),()]

-- sequenceA on a list of Maybes
sequenceA [Just 1, Just 2, Just 3]   -- Just [1,2,3]
sequenceA [Just 1, Nothing, Just 3]  -- Nothing
```

### Implementing `Traversable` for `Tree`

The key insight is that `Node` has three sub-expressions; you lift the `Node`
constructor into the applicative:

```haskell
instance Traversable Tree where
  traverse _ Leaf         = pure Leaf
  traverse f (Node l x r) =
    Node <$> traverse f l <*> f x <*> traverse f r
```

This preserves the tree shape while "threading" the effect through each node.

### `foldMap` for Free Operations

`toSortedList` for a BST can be written in one line using `foldMap`:

```haskell
toSortedList :: Tree a -> [a]
toSortedList = foldMap (:[])
-- (:[]) wraps each element in a singleton list;
-- the Monoid instance for lists concatenates them left-to-right (in-order).
```

---

## Practice Assignments

### Assignment 1: Foldable Tree

Implement the `Foldable` instance for `Tree` using in-order traversal via `foldMap`.  Verify that `toList`, `sum`, and `length` all behave correctly on trees built with `fromListBST`.

### Assignment 2: Functor Tree

Implement the `Functor` instance for `Tree` so that `fmap f` applies `f` to every node value while preserving the tree structure.  Confirm the functor identity law holds.

### Assignment 3: Traversable Tree

Implement the `Traversable` instance for `Tree`.  Test that `traverse` with `Maybe` returns `Just` only when all elements satisfy the predicate, and `Nothing` if any element fails.

### Assignment 4: toSortedList

Implement `toSortedList` using `foldMap`.  Because a BST stores elements in sorted order and `foldMap` over a `Tree` performs an in-order traversal, the result should already be sorted.
