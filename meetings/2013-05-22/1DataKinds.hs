{-
Prosty przykład DataKinds. Zauważcie, że rodzaj W
to Typ -> * - zdefiniowaliśmy własny *rodzaj* Typ,
tą samą składnią co definicja *typu* Typ.
-}

{-# LANGUAGE DataKinds, KindSignatures, GADTs #-}
data Typ = A | B
data W :: Typ -> * where
  X :: Int -> Int -> W A
  Y :: Int -> Bool -> W B

-- To działa dla W A jak i W B - może być polimorficzne
f :: W p -> Int
f (X k _) = k
f (Y k _) = k

-- A to nie
g :: W B -> Bool
g (Y _ l) = l
