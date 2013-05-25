-- Listy pamiętające długość
{-# LANGUAGE DataKinds, GADTs, TypeOperators, StandaloneDeriving #-}
import GHC.TypeLits
import Prelude hiding (zip, concat)

data List n a where
  Nil :: List 0 a
  Cons :: a -> List n a -> List (n+1) a

deriving instance Show a => Show (List n a)

-- Kompilowanie następnych dwóch wymaga obecnie typenats
-- (gałąź GHC, jeszcze nie jest złączona z HEAD).
-- Ale przyjrzyjcie się komunikatom o błędach przy
-- próbie kompilacji z wcześniejszym GHC:
-- jeden z nich to
--     Could not deduce (((n1 + m) + 1) ~ (n + m))
--    from the context (n ~ (n1 + 1))
-- innymi słowy, sprawdzanie typów oznacza tutaj
-- udowadnianie zależności algebraicznych
append :: List n a -> List m a -> List (n+m) a
append Nil ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

-- Tym razem mamy bezpieczny zip. Wiemy, że
-- długości list na wejściach są równe.
-- typenats co prawda da warninga, że zapomnieliśmy o
-- przypadku "zip Nil (Cons _ _)" ale to jest bug
-- (sprawdzanie czy pattern matching jest wyczerpujący
-- od dawna leży w GHC.)
zip :: List n a -> List n b -> List n (a,b)
zip Nil Nil = Nil
zip (Cons x xs) (Cons y ys) = Cons (x,y) (zip xs ys)

-- Z tym nawet typenats obecnie sobie nie radzi.
-- Błąd: 
--    Could not deduce ((m + (n1 * m)) ~ (n * m))
--    from the context (n ~ (n1 + 1))
-- co wynika z rozdzielności.
concat :: List n (List m a) -> List (n*m) a
concat Nil = Nil
concat (Cons x y) = x `append` concat y
