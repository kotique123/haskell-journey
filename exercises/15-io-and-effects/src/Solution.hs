{-# LANGUAGE ScopedTypeVariables #-}
module Exercise
  ( countLines, appendToFile, makeCounter, safeDivIO, repeatUntil
  ) where

import Data.IORef
import Control.Exception (catch, IOException)

countLines :: FilePath -> IO Int
countLines path = do
  content <- readFile path `catch` (\(_ :: IOException) -> return "")
  return (length (lines content))

appendToFile :: FilePath -> String -> IO ()
appendToFile path content = appendFile path (content ++ "\n")

makeCounter :: IO (IO Int)
makeCounter = do
  ref <- newIORef 0
  return $ do
    n <- readIORef ref
    let n' = n + 1
    writeIORef ref n'
    return n'

safeDivIO :: Int -> Int -> IO (Either String Int)
safeDivIO _ 0 = return (Left "division by zero")
safeDivIO a b = return (Right (a `div` b))

repeatUntil :: IO Bool -> IO () -> IO ()
repeatUntil check action = do
  done <- check
  if done
    then return ()
    else do
      action
      repeatUntil check action
