% определить предикаты:
	% and(A,B)
	% or(A, B)
	% xor(A, B)
	% not(A)
	% equ(A,B)
% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности

and(A,B) :- A, B.
or(A,B) :- A; B.
xor(A,B) :- not(equ(A,B)).
not(A) :- \+A.
equ(A,B) :- A = B.

bind(X) :- X=true.
bind(X) :- X=fail.
calc(Expr, true):- Expr, !.
calc(_, fail).
truth_table(A, B, Expr):- bind(A), bind(B), write(A), write(' '), write(B), write(' '), calc(Expr, Res), writeln(Res), fail.
truth_table(_,_,_):- nl, true.

printHeaders(X,Y,R) :- write('  '), write(X), write('    '), write(Y), write('   '), write(R), nl.

:- printHeaders('A','B','XOR').
:- truth_table(A,B,xor(A,B)).

:- printHeaders('A','B','OR').
:- truth_table(A,B,or(A,B)).

:- printHeaders('A','B','CUS').
:- truth_table(A,B,and(xor(A,or(B,not(A))),not(B))).

% ответы
/*
  A    B   XOR
true true fail
true fail true
fail true true
fail fail fail

  A    B   OR
true true true
true fail true
fail true true
fail fail fail

  A    B   CUS
true true fail
true fail true
fail true fail
fail fail true
*/