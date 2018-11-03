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

and(A, B) :- A, B.
or(A, B) :- A; B.
not(A) :- A = fail.
equ(A, B) :- A = B.
xor(A, B) :- not(equ(A, B)).

bool(true).
bool(fail).
evaluate(E, true) :- E, !.
evaluate(_, fail).

truth_table(A, B, E) :-
  bool(A),
  bool(B),
  write(A), write(' '),
  write(B), write(' '),
  evaluate(E, Result),
  write(Result), nl, fail.

% true true true
% true fail true
% fail true fail
% fail fail fail