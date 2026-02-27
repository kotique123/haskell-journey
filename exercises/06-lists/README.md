# Exercise 06 — Lists

## Theory

Lists are the most fundamental data structure in Haskell. Understanding them deeply unlocks most of the language's expressive power.

### List literals and cons

A list is either empty `[]` or an element consed onto another list with `(:)`:

```haskell
ghci> [1,2,3]
[1,2,3]
ghci> 1 : 2 : 3 : []
[1,2,3]
ghci> head [10,20,30]
10
ghci> tail [10,20,30]
[20,30]
ghci> null []
True
ghci> null [1]
False
```

### Ranges and infinite lists

```haskell
ghci> [1..5]
[1,2,3,4,5]
ghci> [1,3..10]
[1,3,5,7,9]
ghci> take 5 [1..]   -- infinite list!
[1,2,3,4,5]
```

### Common list functions

```haskell
ghci> length [1,2,3]
3
ghci> zip [1,2,3] "abc"
[(1,'a'),(2,'b'),(3,'c')]
ghci> unzip [(1,'a'),(2,'b')]
([1,2],"ab")
ghci> take 3 [10,20..]
[10,20,30]
ghci> drop 2 [1,2,3,4]
[3,4]
ghci> elem 3 [1,2,3,4]
True
```

### List comprehensions

List comprehensions let you generate lists by combining generators and guards, similar to set-builder notation in mathematics:

```haskell
-- All even numbers up to 20:
ghci> [x | x <- [1..20], even x]
[2,4,6,8,10,12,14,16,18,20]

-- Pairs:
ghci> [(x,y) | x <- [1..3], y <- [1..3], x /= y]
[(1,2),(1,3),(2,1),(2,3),(3,1),(3,2)]

-- String transformation:
ghci> [c | c <- "Hello, World!", c `elem` ['A'..'Z']]
"HW"
```

Multiple generators nest like loops; the rightmost generator changes fastest.

### Building custom list functions

Haskell's Prelude gives you `length`, `reverse`, `sum`, etc., but understanding how to build them yourself is essential:

```haskell
-- Using explicit recursion:
myLength :: [a] -> Int
myLength []     = 0
myLength (_:xs) = 1 + myLength xs

-- Using an accumulator:
myReverse :: [a] -> [a]
myReverse = go []
  where
    go acc []     = acc
    go acc (x:xs) = go (x:acc) xs
```

### Run-length encoding

Run-length encoding compresses consecutive identical elements into `(count, element)` pairs. The key insight is to group consecutive equal elements:

```haskell
-- "aaabbc" → [(3,'a'),(2,'b'),(1,'c')]
```

Think about processing the list one element at a time, accumulating a count for the current run.

---

## Practice Assignments

### Assignment 1: myLength

Write `myLength :: [a] -> Int` without using Prelude's `length`. Use recursion.

### Assignment 2: myReverse

Write `myReverse :: [a] -> [a]` without using Prelude's `reverse`.

### Assignment 3: mySum

Write `mySum :: Num a => [a] -> a` without using Prelude's `sum`.

### Assignment 4: pythagorean

Write `pythagorean :: Int -> [(Int,Int,Int)]` that returns all Pythagorean triples `(a,b,c)` where `a ≤ b < c` and all legs are ≤ n. Use a list comprehension.

### Assignment 5: runLengthEncode

Write `runLengthEncode :: Eq a => [a] -> [(Int, a)]` that compresses consecutive identical elements. `"aabb"` → `[(2,'a'),(2,'b')]`.
