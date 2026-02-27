module Exercise
  ( countLines
  , appendToFile
  , makeCounter
  , safeDivIO
  , repeatUntil
  ) where

import Data.IORef

countLines :: FilePath -> IO Int
countLines = undefined

appendToFile :: FilePath -> String -> IO ()
appendToFile = undefined

makeCounter :: IO (IO Int)
makeCounter = undefined

safeDivIO :: Int -> Int -> IO (Either String Int)
safeDivIO = undefined

repeatUntil :: IO Bool -> IO () -> IO ()
repeatUntil = undefined
