module Exercise
  ( Tree(..), insertBST, fromListBST, toSortedList
  ) where

data Tree a = Leaf | Node (Tree a) a (Tree a)
  deriving (Show, Eq)

instance Functor Tree where
  fmap _ Leaf         = Leaf
  fmap f (Node l x r) = Node (fmap f l) (f x) (fmap f r)

instance Foldable Tree where
  foldMap _ Leaf         = mempty
  foldMap f (Node l x r) = foldMap f l <> f x <> foldMap f r

instance Traversable Tree where
  traverse _ Leaf         = pure Leaf
  traverse f (Node l x r) = Node <$> traverse f l <*> f x <*> traverse f r

insertBST :: Ord a => a -> Tree a -> Tree a
insertBST x Leaf = Node Leaf x Leaf
insertBST x (Node l v r)
  | x < v    = Node (insertBST x l) v r
  | x > v    = Node l v (insertBST x r)
  | otherwise = Node l v r

fromListBST :: Ord a => [a] -> Tree a
fromListBST = foldr insertBST Leaf

toSortedList :: Ord a => Tree a -> [a]
toSortedList = foldMap (:[])
