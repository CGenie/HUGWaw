-- To był interaktywny tutorial: widzieliśmy jak GHC sugeruje co należy
-- wpisać w dziurę, i stopniowo napisaliśmy definicję
{-# LANGUAGE TypeHoles #-}

data W x = W x

instance Functor W where
  fmap = _a
