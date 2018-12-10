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

and(A, B):- A, B.
or(A, B):- A; B.
or(A,_):- A.
or(_,B):- B.
not(A):- \+A.
equ(A, B):- A = B.
xor(A, B):- or(and(not(A), B),and(A, not(B))).

boolean(true).
boolean(false).

truth_table(Expr, true):- Expr, !.
truth_table(_, false).

truth_table(A, B, Expr):-
	boolean(A),
	boolean(B),
	write(A), write('\t'), write(B), write('\t'), truth_table(Expr, Res), writeln(Res), fail.

truth_table(_,_,_):- nl, true.

test:-
	writeln('AND:'),
	truth_table(A, B, and(A,B)),
	writeln('OR:'),
	truth_table(A, B, or(A,B)),
	writeln('EQU:'),
	truth_table(A, B, equ(A,B)),
	writeln('XOR:'),
	truth_table(A, B, xor(A,B)),
	writeln('and(A,or(A,B))'),
	truth_table(A,B,and(A,or(A,B))).

% ?- test.
% AND:
% true    true    true
% true    false   false
% false   true    false
% false   false   false

% OR:
% true    true    true
% true    false   true
% false   true    true
% false   false   false

% EQU:
% true    true    true
% true    false   false
% false   true    false
% false   false   true

% XOR:
% true    true    false
% true    false   true
% false   true    true
% false   false   false

% and(A,or(A,B))
% true    true    true
% true    false   true
% false   true    false
% false   false   false

% true.