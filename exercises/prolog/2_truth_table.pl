% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)
% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail

and(A,B) :- A, B.
or(A,B) :- A; B.
xor(A,B) :- or(A,B), not(and(A,B)).
not(A) :- A == false.
equ(A,B) :- A == B.

boolean(true).
boolean(false).

solve(E,true) :- E,!.
solve(_,false).

truth_table(A,B,E) :- boolean(A), boolean(B), solve(E,R), write(A), write(" "), write(B), write(" "), write(R).

?- truth_table(A,B,and(A,B)).
true true true
A = B, B = true ;
true false false
A = true,
B = false ;
false true false
A = false,
B = true ;
false false false
A = B, B = false.

?- truth_table(A,B,or(A,B)).
true true true
A = B, B = true ;
true false true
A = true,
B = false ;
false true true
A = false,
B = true ;
false false false
A = B, B = false.

?- truth_table(A,B,xor(A,B)).
true true false
A = B, B = true ;
true false false
A = true,
B = false ;
false true false
A = false,
B = true ;
false false false
A = B, B = false

?- truth_table(A,B,equ(A,B)).
true true true
A = B, B = true ;
true false false
A = true,
B = false ;
false true false
A = false,
B = true ;
false false true
A = B, B = false.

?- truth_table(A,B,and(A,or(A,B))).
true true true
A = B, B = true ;
true false true
A = true,
B = false ;
false true false
A = false,
B = true ;
false false false
A = B, B = false.