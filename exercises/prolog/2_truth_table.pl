% определить предикаты:
and(A,B) :- A,B.
not(A) :- \+ A.
or(A,B) :- not(and(not(A),not(B))).
equ(A,B) :- or(not(A),B), or(A,not(B)).
xor(A,B) :- not(equ(A,B)).

bool(true).
bool(false).

evaluate(E,false) :- not(E).
evaluate(E,true) :- E.

printVars(X,Y,Z):- write(X), write("\t"), write(Y), write("\t"), write(Z), nl.

tableRow(A,B,E,Result) :- bool(A), bool(B), evaluate(E,Result).

truth_table(A,B,E) :- write("A\tB\t"),write(E), nl, forall(tableRow(A,B,E,Result), printVars(A,B,Result)).

?- truth_table(A,B,equ(and(A,B),not(B))).

/*

Output:

A	B	equ(and(_3012,_3014),not(_3014))
true	true	false
true	false	false
false	true	true
false	false	false

*/


