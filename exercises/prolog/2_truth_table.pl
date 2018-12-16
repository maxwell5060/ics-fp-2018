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
% 12 fail fail fail

and(A,B) :- A, B.
or(A,B) :- A; B.
not(A) :- A = false.
equ(A,B) :- A = B.
xor(A,B) :- A,not(B); not(A),B.

e(true).
e(false).

count(Exp,true) :- Exp, !.
count(Exp,false).


% 27 truth_table(A, B, E) :- forall((e(A), e(B)), (write(A), write(' '), write(B), write(' '), writeln(Res))).
truth_table(A, B, E) :- e(A), e(B), write(A), write(' '), write(B), write(' '), count(E,Res), writeln(Res), false.
% truth_table(A, B, E) :- e(A), e(B), write(A), write(B), count(Exp,Res), writeln(Res).

% ?- truth_table(A,B,equ(A,B)).
% true true true
% true false false
% false true false
% false false true
% false.

% ?- truth_table(A,B,xor(A,B)).
% true true false
% true false true
% false true true
% false false false
% false.

% ?- truth_table(A,B,or(A,B)).
% true true true
% true false true
% false true true
% false false false
% false.

% ?- truth_table(A,B,and(A,B)).
% true true true
% true false false
% false true false
% false false false
% false.
