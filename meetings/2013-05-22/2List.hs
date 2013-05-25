-- Zwykłe listy
{-# LANGUAGE GADTs, StandaloneDeriving #-}
module List where

import Prelude hiding (zip, concat)

data List a where
  Nil :: List a
  Cons :: a -> List a -> List a

deriving instance Show a => Show (List a)

append :: List a -> List a -> List a
append Nil ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

-- Zauważcie, że ta funkcja się wysypie na wektorach
-- różnej długości.
zip :: List a -> List b -> List (a,b)
zip Nil Nil = Nil
zip (Cons x xs) (Cons y ys) = Cons (x,y) (zip xs ys)

concat :: List (List a) -> List a
concat Nil = Nil
concat (Cons x xs) = append x (concat xs)
