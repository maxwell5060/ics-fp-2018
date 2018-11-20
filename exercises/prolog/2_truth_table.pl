%определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)

bool(true).
bool(fail).

and(A,B) :- A,B.
or(A,B) :- A;B.
not(A) :- \+A.
equ(A,B) :- A==B.
xor(A,B) :- not(or(A,B)).

% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail
evaluate(Expr, true) :- Expr, !.
evaluate(_, fail).

print(X,Y,Res) :-
  write(X),
  write(' '),
  write(Y),
  write(' '),
  write(Res),nl.

truth_table(A,B,Expression) :-
  bool(A),bool(B),
  evaluate(Expression, Result),
  print(A,B,Result),
  fail.
