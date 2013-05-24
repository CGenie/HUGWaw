-- Prosty przykład defer-type-errors.
-- Można kompilować w GHC 7.6 z opcją -fdefer-type-errors
main = do x <- readLn
          if x > 0 then
            print True
          else
            False + 2

