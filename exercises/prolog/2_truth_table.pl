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
eq(A, B):- A = B.
xor(A, B):- not(eq(A, B)).

eval(Expr, true):- Expr, !.
eval(_, fail).

truth_table(A, B, Expr):- bool(A), bool(B), eval(Expr, Result), writef('%t %t %t\n', [A, B, Result]), fail.
truth_table(_, _, _):- true.

:- writeln("AND truth table\n").
:- truth_table(A, B, and(A, B)).

:- writeln("\nOR truth table\n").
:- truth_table(A, B, or(A, B)).

:- writeln("\nXOR truth table\n").
:- truth_table(A, B, xor(A, B)).

:- writeln("\nEQ truth table\n").
:- truth_table(A, B, eq(A, B)).

:- writeln("\nA AND (A OR B) truth table\n").
:- truth_table(A, B, and(A, or(A, B))).

% AND truth table

% true true true
% true fail fail
% fail true fail
% fail fail fail

% OR truth table

% true true true
% true fail true
% fail true true
% fail fail fail

% XOR truth table

% true true fail
% true fail true
% fail true true
% fail fail fail

% EQ truth table

% true true true
% true fail fail
% fail true fail
% fail fail true

% A AND (A OR B) truth table

% true true true
% true fail true
% fail true fail
% fail fail fail