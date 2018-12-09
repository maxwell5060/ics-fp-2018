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

and(A,B):- A,B.
not(A):- \+A.
or(A,B):- A;B.
xor(A, B):- or(and(not(A), B), and(A, not(B))).
equ(A,B):- A=B.


bool(true).
bool(false).

evaluate(E,false) :- not(E).
evaluate(E,true) :- E.

printVars(X,Y,Z):- write(X), write("\t"), write(Y), write("\t"), write(Z), nl.

tableRow(A,B,E,Result) :- bool(A), bool(B), evaluate(E,Result).

truth_table(A,B,E) :- write("A\tB\t"),write(E), nl, forall(tableRow(A,B,E,Result), printVars(A,B,Result)).

%?- truth_table(A,B,or(A,and(A,B))).
%A       B       or(_2550,and(_2550,_2552))
%true    true    true
%true    true    true
%true    false   true
%false   true    false
%false   false   false
%true.

