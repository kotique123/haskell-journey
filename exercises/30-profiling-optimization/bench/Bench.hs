import Criterion.Main
import Exercise

main :: IO ()
main = defaultMain
  [ bgroup "sum"
    [ bench "lazy"   $ whnf lazySum [1..10000 :: Int]
    , bench "strict" $ nf   strictSum [1..10000 :: Int]
    ]
  , bgroup "fib"
    [ bench "naive" $ whnf naiveFib 30
    , bench "memo"  $ whnf memoFib 30
    ]
  ]
