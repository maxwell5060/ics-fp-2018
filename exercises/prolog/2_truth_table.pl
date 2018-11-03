% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)

	bool(true).
	bool(fail).

	and(A, B) :- A, B.
	or(A, B) :- A; B.
	not(A) :- \+A.
	equ(A, B) :- A = B.
	xor(A, B) :- not(equ(A, B)).

	evaluate(Expr, true) :- Expr, !.
	evaluate(_, fail).

	row_generator(A, B, Expr, Result) :- bool(A), bool(B), evaluate(Expr, Result).

	truth_table(A, B, Expr) :-
		forall(row_generator(A, B, Expr, Result), format("~w\t~w\t~w~n", [A, B, Result])).

% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail

	:- initialization
		truth_table(A, B, and(A, or(A, B))),

		halt.
