-- "Jednostki" to określenie systemu typów używanego w fizyce.

{-# LANGUAGE TypeFamilies, TypeOperators, UndecidableInstances #-}
import Prelude hiding ((*))
import qualified Prelude

-- Liczby to albo Succ (Succ (... Zero)), albo Pred (Pred ... Zero);
-- nigdy nie mieszamy Succ i Pred
data Zero
data Succ a
data Pred a

-- Dodawanie przez przypadki
type family Add a b :: *
type instance Add Zero Zero = Zero
type instance Add Zero (Succ a) = Succ a
type instance Add (Succ a) Zero = Succ a
type instance Add Zero (Pred a) = Pred a
type instance Add (Pred a) Zero = Pred a
type instance Add (Succ a) (Pred b) = Add a b
type instance Add (Succ a) (Succ b) = Succ (Succ (Add a b))
type instance Add (Pred a) (Succ b) = Add a b
type instance Add (Pred a) (Pred b) = Pred (Pred (Add a b))

type family Neg a :: *
type instance Neg Zero = Zero
type instance Neg (Succ x) = Pred (Neg x)
type instance Neg (Pred x) = Succ (Neg x)

type family Sub a b :: *
type instance Sub a b = Add a (Neg b)

type One = Succ Zero

-- Wymiary

data Dim length time mass

type Length = Dim One Zero Zero
type Time   = Dim Zero One Zero
type Mass   = Dim Zero Zero One

type family MulDim a b :: *
type instance MulDim (Dim x y z) (Dim a b c) = Dim (Add x a) (Add y b) (Add z c)
type family DivDim a b :: *
type instance DivDim (Dim x y z) (Dim a b c) = Dim (Sub x a) (Sub y b) (Sub z c)

type Velocity = Length `DivDim` Time
-- Moglibyśmy napisać też
--   type Velocity = Dim One (Neg One) Zero
-- ale tak jest nieco bardziej elegancko
-- (można w GHCi użyć :kind! Velocity aby to sprawdzić.)
type Acceleration = Velocity `DivDim` Time
type Force = Mass `MulDim` Acceleration
type Energy = Length `MulDim` Force

type Dimless = Dim Zero Zero Zero

newtype Quantity d t = Q t deriving (Show)

unitless :: t -> Quantity Dimless t
unitless = Q

(*) :: Num t => Quantity d1 t -> Quantity d2 t -> Quantity (d1 `MulDim` d2) t
Q x * Q y = Q (x Prelude.* y) 

v :: Quantity Velocity Float
v = Q 9  -- 9m/s

m :: Quantity Mass Float
m = Q 2  -- 2kg

e :: Quantity Energy Float
-- To się nie skompiluje (i bardzo dobrze! Wykryliśmy błąd w użyciu jednostek.)
e = m * v
-- To już się skompiluje, bo nie ma błędu w jednostkach.
-- e = m * v * v
-- I to też. Jak widać, poprawne użycie jednostek nie oznacza jeszcze że wzór
-- jest poprawny. Ale i tak to bardzo przydatny system typów.
-- e = m * v * v * unitless 0.5

-- Zainteresowanym polecam pakiet "dimensional" na hackage.
