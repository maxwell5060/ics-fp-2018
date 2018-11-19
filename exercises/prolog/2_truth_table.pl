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

bool(true).
bool(fail).

evaluate(Expr, true):- Expr, !.
evaluate(_, fail).

and(A,B):- A, B.
or(A,B):- A; B.
not(A):- \+A.
xor(A,B):- or(and(not(A), B), and(A, not(B))).
equ(A,B):- A = B.

truth_table(A,B,Expr):- bool(A), bool(B), write(A), write(" "), write(B), write(" "), evaluate(Expr, Res), write(Res), nl, fail.
truth_table(_,_,_):- nl, true.

:- write("and(A,B)"), nl.
:- truth_table(A,B,and(A,B)).

:- write("xor(A,B)"), nl.
:- truth_table(A,B,xor(A,B)).

:- write("equ(A,B)"), nl.
:- truth_table(A,B,equ(A,B)).

:- write("and(A,or(A,B))"), nl.
:- truth_table(A,B,and(A,or(A,B))).

:- halt.
