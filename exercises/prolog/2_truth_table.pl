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

and(A, B):- A, B.
or(A, B):- A; B.
not(A):- \+A.
equ(A, B):- A = B.
xor(A, B):- not(equ(A, B)).

calc(E, true):- E, !.
calc(_, fail).

truth_table(A, B, E):- bool(A), bool(B), write(A), write(' '), write(B), write(' '), calc(E, Res), writeln(Res), fail.
truth_table(_,_,_):- nl, true.

:- writeln("AND:").
:- truth_table(A, B, and(A,B)).

:- writeln("OR:").
:- truth_table(A, B, or(A,B)).

:- writeln("XOR:").
:- truth_table(A, B, xor(A,B)).

:- writeln("EQU:").
:- truth_table(A, B, equ(A,B)).

/* Results:

AND:
true true true
true fail fail
fail true fail
fail fail fail

OR:
true true true
true fail true
fail true true
fail fail fail

XOR:
true true fail
true fail true
fail true true
fail fail fail

EQU:
true true true
true fail fail
fail true fail
fail fail true

*/