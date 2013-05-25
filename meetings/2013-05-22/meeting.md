Co nowego w rozszerzeniach GHC 7.x?
===================================
Było trochę ćwiczeń na inferencję rodzajów, omówiłem constraint kinds (monada dlaa `Set`), polimorfizm na rodzajach (`Typeable`), data kinds (drzewa czerwono-czarne), liczby naturalne na poziomie typów (sprawdzanie jednostek we wzorach fizycznych, długości tablic), safe haskell (strony interaktywne jak te co wyżej, hackage), defer type errors, dziury, defer type errors i dziury razem. Więcej na slajdach i kodzie (w tym folderze). Ostrzegam, że bez GHC HEAD lub typenats nie można skompilować przykładów z dziurami i długością wektorów, ale myślę że i tak warto się im przyjrzeć.

Ciekawsze linki o których wspomniałem:

* [Learn You a Haskell for Great Good!](http://learnyouahaskell.com/making-our-own-types-and-typeclasses#kinds-and-some-type-foo) - rozdział o kindach
* [Bardzo dobry opis rozszerzenia Constraint Kinds](http://blog.omega-prime.co.uk/?p=127)
* [Drzewa czerwono-czarne gdzie system typów wymusza niezmienniki](https://gist.github.com/michaelt/2660297)
* [Interaktywne diagramy](http://pnyf.inf.elte.hu/fp/Diagrams_en.xml] - całkiem fajna zabawa
* [Elm](http://elm-lang.org/edit/examples/Intermediate/Mario.elm) - o tym było wspomniane po referacie. Można edytować. Elm to FRP który działa.
* [Monoidy i monady](monoidal.blogspot.com/2010/07/kind-polymorphism-in-action.html) jako jedna klasa - stary post z mojego bloga który pokazuje związki monoidów i monad
