% Определить предикаты:
% and(A,B)
% or(A, B)
% xor(A, B)
% not(A)
% equ(A,B)

and(A, B) :- A, B.
or(A, B) :- A; B.
equ(A, B) :- A = B.
not(A) :- \+A.
xor(A, B) :- or(A, B), not(and(A, B)).

evaluate(E, true) :- E, !.
evaluate(_, false).

bool(true).
bool(false).

truth_table(A, B, E) :- bool(A), bool(B), evaluate(E, R), write(A), write(' '), write(B), write(' '), write(R), nl, fail.
truth_table(_, _, _) :- true.

% Использовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:
% truth_table(A,B,and(A,or(A,B))).
% true true true
% true fail true
% fail true fail
% fail fail fail

truth_table(A, B, and(A, B)).
% true true true
% true false false
% false true false
% false false false

truth_table(A, B, or(A, B)).
% true true true
% true false true
% false true true
% false false false

truth_table(A, B, equ(A, B)).
% true true true
% true false false
% false true false
% false false true

truth_table(A, B, not(equ(A, B))).
% true true false
% true false true
% false true true
% false false false

truth_table(A, B, xor(A, B)).
% true true false
% true false true
% false true true
% false false false

truth_table(A, B, and(A, or(A, B))).
% true true true
% true false true
% false true false
% false false false