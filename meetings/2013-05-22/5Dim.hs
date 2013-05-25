-- To co poprzednio, ale z DataKinds.
-- Zwróćcie uwagę na rodzaj Quantity:
-- Quantity :: Dimensional -> * -> *
-- a nie * -> * -> * jak poprzednio.
-- Mamy podane, że do Quantity należy podać wpierw wymiar.
-- Podobnie, dodawanie liczb naturalnych to TInt -> TInt -> TInt,
-- a nie * -> * -> * jak poprzednio.
-- Co prawda definicje niekiedy są dłuższe, ale końcowy efekt
-- jest dużo dużo lepszy.
{-# LANGUAGE TypeFamilies, TypeOperators, UndecidableInstances, DataKinds #-}
import Prelude hiding ((*))
import qualified Prelude

data TInt = Zero | Succ TInt | Pred TInt

type family Add (a :: TInt) (b :: TInt) :: TInt
type instance Add Zero Zero = Zero
type instance Add Zero (Succ a) = Succ a
type instance Add Zero (Pred a) = Pred a
type instance Add (Succ a) Zero = Succ a
type instance Add (Pred a) Zero = Pred a
type instance Add (Succ a) (Pred b) = Add a b
type instance Add (Pred a) (Succ b) = Add a b
type instance Add (Succ a) (Succ b) = Succ (Succ (Add a b))
type instance Add (Pred a) (Pred b) = Pred (Pred (Add a b))

type family Neg (a :: TInt) :: TInt
type instance Neg Zero = Zero
type instance Neg (Succ x) = Pred (Neg x)
type instance Neg (Pred x) = Succ (Neg x)

type family Sub (a :: TInt) (b :: TInt) :: TInt
type instance Sub a b = Add a (Neg b)

type One = Succ Zero

-- Wymiary
data Dimensional = Dim TInt TInt TInt

type Length = Dim One Zero Zero
type Time   = Dim Zero One Zero
type Mass   = Dim Zero Zero One

type family MulDim (a :: Dimensional) (b :: Dimensional) :: Dimensional
type instance MulDim (Dim x y z) (Dim a b c) = Dim (Add x a) (Add y b) (Add z c)
type family DivDim (a :: Dimensional) (b :: Dimensional) :: Dimensional
type instance DivDim (Dim x y z) (Dim a b c) = Dim (Sub x a) (Sub y b) (Sub z c)

type Velocity = Length `DivDim` Time
type Acceleration = Velocity `DivDim` Time
type Force = Mass `MulDim` Acceleration
type Energy = Length `MulDim` Force

type Dimless = Dim Zero Zero Zero

newtype Quantity (d :: Dimensional) t = Q t deriving (Show)

unitless :: t -> Quantity Dimless t
unitless = Q

(*) :: Num t => Quantity d1 t -> Quantity d2 t -> Quantity (d1 `MulDim` d2) t
Q x * Q y = Q (x Prelude.* y) 

v :: Quantity Velocity Float
v = Q 9

m :: Quantity Mass Float
m = Q 2
