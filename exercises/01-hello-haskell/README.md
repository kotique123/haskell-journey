# Exercise 01 — Hello Haskell

## Theory

Welcome to Haskell! This first exercise introduces you to the most basic building blocks of the language: expressions, functions, and the interactive environment GHCi.

### GHCi — the Haskell REPL

GHCi lets you type Haskell expressions and see their results immediately. Start it with `stack ghci` inside this project.

```haskell
ghci> 2 + 3
5
ghci> "Hello" ++ ", " ++ "World"
"Hello, World!"
ghci> pi
3.141592653589793
```

### Printing values

Haskell distinguishes between *showing* a value (converting it to a string) and *printing* it to the terminal.

```haskell
ghci> putStrLn "Hello, World!"   -- prints without surrounding quotes
Hello, World!
ghci> print 42                    -- prints with Show representation
42
ghci> print "hello"               -- includes the quotes
"hello"
```

`putStrLn :: String -> IO ()` writes a `String` followed by a newline.  
`print :: Show a => a -> IO ()` calls `show` on its argument first.

### String concatenation

Strings in Haskell are lists of characters (`[Char]`). The `(++)` operator concatenates two lists:

```haskell
ghci> "Haskell" ++ " is " ++ "great"
"Haskell is great"
ghci> let name = "Alice"
ghci> "Hello, " ++ name ++ "!"
"Hello, Alice!"
```

### Basic arithmetic

Haskell supports the usual arithmetic operators. Integer division uses `div` and `mod`; floating-point uses `/`.

```haskell
ghci> 10 `div` 3
3
ghci> 10 `mod` 3
1
ghci> 7.0 / 2.0
3.5
ghci> 2 ^ 10
1024
```

### `let` expressions

In GHCi you can bind names with `let`:

```haskell
ghci> let x = 5
ghci> let square n = n * n
ghci> square x
25
```

Inside a Haskell source file, `let` is used inside `do`-blocks or as `let … in …` expressions.

### Defining functions

A simple function has a name, its arguments, an `=`, and a body:

```haskell
double :: Int -> Int
double n = n * 2

greetUser :: String -> String
greetUser name = "Hello, " ++ name ++ "!"
```

### The `pi` constant

Prelude exports the constant `pi :: Floating a => a` which is a good approximation of π:

```haskell
ghci> pi
3.141592653589793
ghci> pi * 2 ^ 2      -- area of a circle with radius 2
12.566370614359172
```

### BMI formula

Body Mass Index = weight (kg) / height² (m²).  
Common categories: BMI < 18.5 → Underweight, 18.5–25 → Normal, > 25 → Overweight.

```haskell
ghci> let w = 70.0; h = 1.75
ghci> w / (h * h)
22.857142857142858
```

---

## Practice Assignments

### Assignment 1: greet

Write `greet :: String -> String` that prepends `"Hello, "` to the given name and appends `"!"`.

```
greet "World"   -- should return "Hello, World!"
greet "Haskell" -- should return "Hello, Haskell!"
```

### Assignment 2: double

Write `double :: Int -> Int` that multiplies its argument by 2.

### Assignment 3: circleArea

Write `circleArea :: Double -> Double` that computes the area of a circle given its radius.  
Use the `pi` constant from Prelude.

### Assignment 4: bmi

Write `bmi :: Double -> Double -> String` that takes weight (kg) and height (m) and returns `"Underweight"`, `"Normal"`, or `"Overweight"` based on the BMI formula.
