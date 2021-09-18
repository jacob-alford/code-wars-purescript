module EvenOrOdd where

import Prelude

evenOrOdd :: Int -> String
evenOrOdd n = case n `mod` 2 == 0 of
  true -> "Even"
  false -> "Odd"
