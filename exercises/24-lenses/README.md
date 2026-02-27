# Exercise 24 — Lenses

## Theory

The `lens` library provides a composable way to access and update parts of
deeply nested data structures.  Rather than writing boilerplate record
accessors, you work with *optics*: values that describe a *focus* inside a
larger structure.

### Core Operations

```haskell
import Control.Lens

data Address = Address { _street :: String, _city :: String }
data Person  = Person  { _name :: String, _age :: Int, _address :: Address }

makeLenses ''Address
makeLenses ''Person
```

`makeLenses` uses Template Haskell to generate lenses named after the fields
(without the leading underscore): `street`, `city`, `name`, `age`, `address`.

The three fundamental operators are:

| Operator | Purpose              | Example                          |
|----------|----------------------|----------------------------------|
| `^.`     | view (get)           | `bob ^. name`                    |
| `.~`     | set                  | `bob & age .~ 31`                |
| `%~`     | modify (over)        | `bob & age %~ (+1)`              |

```haskell
-- Get a nested field
bob ^. address . city         -- "Springfield"

-- Set a nested field (returns a new value)
bob & address . city .~ "Shelbyville"

-- Modify a field
bob & age %~ (+1)
```

### Lens Composition

Lenses compose with `.` (ordinary function composition):

```haskell
-- address . city is a lens that focuses on the city inside a Person
view (address . city) bob     -- same as bob ^. address . city
set  (address . city) "NYC" bob
over (address . city) (map toUpper) bob
```

### Built-in Lenses

The `lens` library ships with lenses for many standard types:

```haskell
-- Tuple lenses
(1, "hello") ^. _1          -- 1
(1, "hello") & _2 .~ "bye" -- (1, "bye")

-- Maybe prism
Just 42 ^? _Just            -- Just 42
Nothing ^? _Just            -- Nothing
Just 42 & _Just %~ (*2)     -- Just 84
```

### `view`, `set`, `over`

The operators are just syntactic sugar:

```haskell
view l s      ==  s ^. l
set  l v s    ==  s & l .~ v
over l f s    ==  s & l %~ f
```

You can use whichever style you prefer; the operator style is usually more
readable in pipelines:

```haskell
-- Pipeline-style update
bob & name .~ "Alice"
    & age  %~ (+10)
    & address . city .~ "Portland"
```

### `makeLenses` Naming Convention

Fields must start with an underscore (`_fieldName`) for `makeLenses` to
generate the corresponding lens `fieldName`.  If you need to shadow a
`Prelude` name (like `zip`), hide it explicitly:

```haskell
import Prelude hiding (zip)
```

---

## Practice Assignments

### Assignment 1: updateCity

Implement `updateCity :: String -> Person -> Person` using a composed lens to
update the `_city` field nested inside `_address`.

### Assignment 2: incrementAge

Implement `incrementAge :: Person -> Person` using the `%~` operator to
increment `_age` by 1.

### Assignment 3: getFullAddress

Implement `getFullAddress :: Person -> String` which returns the string
`"<street>, <city> <zip>"` by reading each field with `^.`.

### Assignment 4: updateAllAges

Implement `updateAllAges :: [Person] -> [Person]` that increments the age of
every person in the list using `map` and your `incrementAge` function.
