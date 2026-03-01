# Exercise 03 — Functions

## Theory

Functions are the primary building block in Haskell. This exercise explores the tools Haskell gives you to write clear, composable, and reusable functions.

### `where` clauses

A `where` clause lets you define helper values or functions that are local to the enclosing definition. This keeps top-level scope clean and can improve readability:

```haskell
cylinderVolume :: Double -> Double -> Double
cylinderVolume r h = baseArea * h
  where
    baseArea = pi * r * r
```

The names bound in `where` are only visible within that function definition.

### `let … in …` expressions

`let` can also be used as an expression anywhere a value is expected:

```haskell
circleStats :: Double -> (Double, Double)
circleStats r =
  let area      = pi * r * r
      circumf   = 2 * pi * r
  in (area, circumf)
```

Inside a `do`-block you can write `let` without `in`:

```haskell
main :: IO ()
main = do
  let x = 42
  print x
```

### Currying and partial application

Every Haskell function takes exactly one argument. A "two-argument" function actually returns a function:

```haskell
add :: Int -> Int -> Int
add x y = x + y

-- Partial application:
addFive :: Int -> Int
addFive = add 5

ghci> addFive 3
8
```

This lets you build specialised functions from general ones without writing any lambdas.

### The `$` operator

`($)` is just function application, but with very low precedence, so it lets you avoid parentheses:

```haskell
-- These are equivalent:
print (negate (abs (-5)))
print $ negate $ abs (-5)
```

### Function composition `(.)`

The `(.)` operator combines two functions, piping output of the right one into the input of the left:

```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
(f . g) x = f (g x)

shout :: String -> String
shout = (++ "!") . map toUpper

ghci> shout "hello"
"HELLO!"
```

### Lambdas

Anonymous functions (lambdas) use backslash notation:

```haskell
ghci> (\x -> x * x) 5
25
ghci> map (\x -> x + 1) [1,2,3]
[2,3,4]
```

### Temperature conversion formulas

- Celsius to Fahrenheit: `°F = °C × 9/5 + 32`
- Fahrenheit to Celsius: `°C = (°F − 32) × 5/9`

```haskell
ghci> let c2f c = c * 9/5 + 32
ghci> c2f 0
32.0
ghci> c2f 100
212.0
```

---

## Practice Assignments

### Assignment 1: hypotenuse

Write `hypotenuse :: Double -> Double -> Double` using the Pythagorean theorem: `c = sqrt(a² + b²)`.

### Assignment 2: celsiusToFahrenheit

Write `celsiusToFahrenheit :: Double -> Double`.

### Assignment 3: fahrenheitToCelsius

Write `fahrenheitToCelsius :: Double -> Double`. It should be the exact inverse of `celsiusToFahrenheit`.

### Assignment 4: applyTwice

Write `applyTwice :: (a -> a) -> a -> a` that applies a function to a value, then applies it again to the result.

### Assignment 5: compose3

Write `compose3 :: (c -> d) -> (b -> c) -> (a -> b) -> a -> d` that composes three functions — implement it **without** using the `(.)` operator. Think about what `(f . g . h) x` expands to.
