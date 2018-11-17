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

and(A, B) :- A, B.
or(A, B) :- A; B.
not(A) :- \+A.
equ(A, B) :- A = B.
xor(A, B) :- \+equ(A, B).

eval(Exp, true) :- Exp, !.
eval(_, fail).

% row(A, B, Exp, Res) :- bool(A), bool(B), eval(Exp, Res).

truth_table(A, B, Exp) :-
bool(A), bool(B), write(A), write(" "), write(B), write(" "), eval(Exp, Res), writeln(Res), fail.
truth_table(_, _, _) :-
nl, true.

:- writeln("and(A, B):"),
truth_table(A, B, and(A, B)),
writeln("or(A, B):"),
truth_table(A, B, or(A, B)),
writeln("equ(A, B):"),
truth_table(A, B, equ(A, B)),
writeln("xor(A, B):"),
truth_table(A, B, xor(A, B)),
writeln("and(A, or(A, B)):"),
truth_table(A, B, and(A, or(A, B))).

/*
and(A, B):
true true true
true fail fail
fail true fail
fail fail fail

or(A, B):
true true true
true fail true
fail true true
fail fail fail

equ(A, B):
true true true
true fail fail
fail true fail
fail fail true

xor(A, B):
true true fail
true fail true
fail true true
fail fail fail

and(A, or(A, B)):
true true true
true fail true
fail true fail
fail fail fail
*/
