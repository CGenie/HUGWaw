-- Ostrzeżenie odnośnie defer-type-errors: to nie jest
-- dynamiczny system typów (jak np. w Pythonie)
{-# OPTIONS_GHC -fdefer-type-errors #-}
(&) :: a -> a -> a
(&) = (&&)

main = print (True & False)
