# Exercise 20 — Text and ByteString

## Theory

Haskell has three primary string-like types, each with different performance characteristics and intended use:

| Type | Module | Best for |
|------|--------|----------|
| `String` (= `[Char]`) | `Prelude` | small strings, prototyping |
| `Text` | `Data.Text` | human-readable Unicode text |
| `ByteString` | `Data.ByteString` | raw binary data, network I/O |

### `Data.Text`

`Text` is a packed array of UTF-16 code units.  It is dramatically more memory-efficient and faster than `String` for any non-trivial text processing.

Enable `OverloadedStrings` so that string literals are automatically typed as `Text`:

```haskell
{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Text as T

greeting :: T.Text
greeting = "Hello, Haskell!"   -- literal is Text, not String

-- Basic operations
T.length "hello"               -- 5
T.toUpper "hello"              -- "HELLO"
T.words "one two three"        -- ["one","two","three"]
T.unwords ["one","two","three"] -- "one two three"
T.lines "a\nb\nc"              -- ["a","b","c"]
T.intercalate ", " ["a","b"]   -- "a, b"
T.splitOn "," "a,b,c"          -- ["a","b","c"]
T.isPrefixOf "He" "Hello"      -- True
T.strip "  hi  "               -- "hi"
```

Convert between `String` and `Text` with `T.pack` / `T.unpack`:

```haskell
T.pack "hello"     -- :: T.Text
T.unpack greeting  -- :: String
```

### `Data.ByteString`

`ByteString` is a packed array of bytes (`Word8`).  Use it for binary data, network payloads, and file I/O where encoding matters.

```haskell
import qualified Data.ByteString       as BS
import qualified Data.ByteString.Char8 as BC

raw :: BS.ByteString
raw = BS.pack [72, 101, 108, 108, 111]   -- [Word8]

BC.pack "Hello"   -- construct from a String (ASCII only)
BS.length raw     -- 5
```

### UTF-8 encoding/decoding

`Data.Text.Encoding` bridges `Text` and `ByteString`:

```haskell
import qualified Data.Text.Encoding as TE

TE.encodeUtf8 "こんにちは"   -- :: BS.ByteString  (safe, always succeeds)
TE.decodeUtf8 bytes          -- :: T.Text          (throws on invalid UTF-8!)
```

For safe decoding use `decodeUtf8'` which returns `Either`:

```haskell
import qualified Data.Text.Encoding.Error as TEE

TE.decodeUtf8' bytes
-- Right t  — valid UTF-8
-- Left  e  — decoding error; convert to Maybe with either (const Nothing) Just
```

### Working with characters

`Data.Char` provides character classification and transformation functions that compose well with `T.map`:

```haskell
import Data.Char (toUpper, toLower, isAlpha)

T.map toUpper "hello"               -- "HELLO"
T.filter isAlpha "h3ll0 w0rld"      -- "hllwrld"
T.uncons "hello"                    -- Just ('h', "ello")
```

---

## Practice Assignments

### 1. countWords

- `countWords :: T.Text -> Int` — return the number of whitespace-separated words; empty input gives 0.

### 2. titleCase

- `titleCase :: T.Text -> T.Text` — capitalise the first character of every word, leaving the rest unchanged.

### 3. isPalindrome

- `isPalindrome :: T.Text -> Bool` — return `True` when the text reads the same forwards and backwards, ignoring spaces and letter case.

### 4. csvToRows

- `csvToRows :: T.Text -> [[T.Text]]` — split the input on newlines to get rows, then split each row on commas to get fields.

### 5. textToBytes / bytesToText

- `textToBytes :: T.Text -> BS.ByteString` — UTF-8 encode the Text.
- `bytesToText :: BS.ByteString -> Maybe T.Text` — safely decode UTF-8; return `Nothing` for invalid byte sequences.
