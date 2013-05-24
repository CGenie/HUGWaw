{-
Restricted monad:
Normalnie nie możemy napisać monady dla Set, bo zbiory, pamiętane
przez drzewa BST, muszą mieć porządek liniowy.
Definiujemy tutaj klasę RMonad, wraz z ograniczeniem (constraint);
dla zwykłych instancji ograniczenia nie ma, i stąd ()
[co odpowiada pisaniu x :: () => a zamiast x :: a]
dla Set mamy ograniczenie Ord a.
-}

{-# LANGUAGE TypeFamilies, ConstraintKinds #-}
import Prelude hiding (map)
import Data.Set
import GHC.Prim (Constraint)

class RMonad m where
  type RMonadConstraint m a :: Constraint
  ret :: RMonadConstraint m a => a -> m a
  bind :: (RMonadConstraint m a, RMonadConstraint m b) => m a -> (a -> m b) -> m b

instance RMonad [] where
  type RMonadConstraint [] a = ()
  ret = return
  bind = (>>=)

instance RMonad Set where
  type RMonadConstraint Set a = Ord a
  ret = singleton
  bind x f = unions (toList (map f x))

k = bind ([1,2,3]) (\x ->
    bind ([3,4]) (\y ->
    ret (x+y)))
