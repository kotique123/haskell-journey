module Exercise
  ( Tree(..)
  , insertBST
  , fromListBST
  , toSortedList
  ) where

-- | A binary tree. You will write Functor, Foldable, and Traversable
-- instances for this type.
data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

-- Functor: apply a function to every value in the tree.
instance Functor Tree where
  fmap = undefined

-- Foldable: reduce the tree via an in-order traversal.
-- You only need to implement 'foldMap'; the rest of Foldable is derived.
instance Foldable Tree where
  foldMap = undefined

-- Traversable: sequence effects through the tree structure.
-- Requires Functor and Foldable instances above to be complete first.
instance Traversable Tree where
  traverse = undefined

-- | Insert a value into a BST, ignoring duplicates.
insertBST :: Ord a => a -> Tree a -> Tree a
insertBST = undefined

-- | Build a BST from a list (duplicates discarded).
fromListBST :: Ord a => [a] -> Tree a
fromListBST = undefined

-- | Return the tree elements in sorted order using 'foldMap'.
-- Hint: foldMap (\x -> [x]) gives in-order list thanks to Foldable.
toSortedList :: Ord a => Tree a -> [a]
toSortedList = undefined
