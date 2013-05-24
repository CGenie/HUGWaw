-- To co poprzednio, ale z DataKinds
{-# LANGUAGE DataKinds, ExistentialQuantification, KindSignatures, GADTs #-}
data Nat = Zero | Succ Nat
 
data Color = Black | Red
 
-- all paths from a node to a leaf have exactly n black nodes
data Node :: Color -> Nat -> * -> * where
  -- all leafs are black
  Leaf  :: Node Black (Succ Zero) a 
  -- internal black nodes can have children of either color
  B     :: Node cL n a    -> a -> Node cR n a    -> Node Black (Succ n) a 
  -- internal red nodes can only have black children
  R     :: Node Black n a -> a -> Node Black n a -> Node Red n a
