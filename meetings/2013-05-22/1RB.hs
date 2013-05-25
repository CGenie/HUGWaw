-- Krótki fragment o drzewach czerwono-czarnych - jak
-- można napisać niezmienniki opisujące zbalansowanie drzewa
-- patrz: 
-- https://gist.github.com/rampion/2659812
-- https://gist.github.com/michaelt/2660297
{-# LANGUAGE ExistentialQuantification, KindSignatures, GADTs #-}
data Zero 
data Succ n
type One = Succ Zero
 
data Black
data Red
 
-- red-black trees are rooted at a black node
data RedBlackTree a = forall n. T ( Node Black n a )
deriving instance Show a => Show (RedBlackTree a)
 
-- all paths from a node to a leaf have exactly n black nodes
data Node c n a where
  -- all leafs are black
  Leaf  :: Node Black One a 
  -- internal black nodes can have children of either color
  B     :: Node cL n a    -> a -> Node cR n a    -> Node Black (Succ n) a 
  -- internal red nodes can only have black children
  R     :: Node Black n a -> a -> Node Black n a -> Node Red n a
