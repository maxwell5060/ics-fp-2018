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
or(A,B):- A;B.
not(A):- \+A.
and(A,B):- not(or(not(A),not(B))).
xor(A, B):- or(and(not(A), B), and(A, not(B))).
equ(A,B):- or(and(A, B), and(not(A), not(B))).

bool(true).
bool(false).

% Отсечение избавляет от "лишних" решений
mapping(Expr, true) :- Expr, !.
mapping(_, false).

make_row(A, B, Expr, Result) :- bool(A), bool(B), mapping(Expr, Result).

truth_table(A, B, Expr) :- forall(make_row(A, B, Expr, Result), format("~w\t~w\t~w~n", [A, B, Result])).
truth_table(A, Expr) :- truth_table(A, true, Expr).
