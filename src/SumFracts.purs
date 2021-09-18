module SumFracts where

import Data.Rational
import Prelude (class Semiring, class Show, show, ($), (<>), (<<<), (<$>))

import Data.List (List(..))
import Data.Maybe (Maybe(..))
import Data.Tuple (Tuple, uncurry)
import Data.Foldable (sum)

newtype RatioInt = RatioInt (Ratio Int)

derive newtype instance semiringRatioInt :: Semiring RatioInt

instance showRatioInt :: Show RatioInt where
  show (RatioInt x) = case denominator x of
    1 -> show (numerator x)
    d -> show (numerator x) <> " " <> show d

foldListTuples :: List (Tuple Int Int) -> RatioInt
foldListTuples xs = sum $ RatioInt <<< (uncurry (%)) <$> xs

sumFracts :: List (Tuple Int Int) -> Maybe String
sumFracts Nil = Nothing
sumFracts xs = (Just <<< show <<< foldListTuples) xs


