-- To samo co poprzednio, ale z inną składnią
-- na listy. Zauważcie analogię z prawami potęgowania
-- a^n a^m = a^(n+m)
-- a^n b^n = (ab)^n
-- (a^n)^m = a^(n*m)
{-# LANGUAGE DataKinds, GADTs, TypeOperators, StandaloneDeriving #-}
import GHC.TypeLits
import Prelude hiding (zip, concat)

data a :^ n where
  Nil :: a :^ 0
  Cons :: a -> a :^ n -> a :^ (n+1)

deriving instance Show a => Show (a :^ n)

append :: a :^ n -> a :^ m -> a :^ (n+m)
append Nil ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

zip :: a :^ n -> b :^ n -> (a,b) :^ n
zip Nil Nil = Nil
zip (Cons x xs) (Cons y ys) = Cons (x,y) (zip xs ys)

concat :: (a :^ n) :^ m -> a :^ (n*m)
concat Nil = Nil
concat (Cons x y) = x `append` concat y
