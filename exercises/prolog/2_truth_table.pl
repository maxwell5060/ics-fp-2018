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

and(A, B) :-
    A, B.

or(A, B) :-
    A; B.

not(A) :-
    \+ A.

xor(A, B) :-
    or(and(A, not(B)), and(not(A), B)).

equ(A, B) :-
    not(xor(A, B)).

evaluate(Expr, true) :-
    Expr, !.
evaluate(_, fail).

truth_table(A, B, Expr) :-
    bool(A),
    bool(B),
    evaluate(Expr, Res),
    writef('%t %t %t\n', [A, B, Res]),
    fail.
truth_table(_, _, _).

% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail

% truth_table(A, B, equ(not(A), B)).
% true true fail
% true fail true
% fail true true
% fail fail fail

% truth_table(A, B, xor(not(A), B)).
% true true true
% true fail fail
% fail true fail
% fail fail true
