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

%getAllValues(A, B)
getAllValues(false, false).
getAllValues(false, true).
getAllValues(true, false).
getAllValues(true, true).


% and(A,B, R)
and(A, B) :- A, B.

% or(A,B)
or(A, B) :- A, B.
or(A, B) :- not(equ(A, B)).

%xor(A, B)
xor(A, B) :- not(equ(A, B)).

%not(A)
not(A): A, !, false.

%equ(A, B)
equ(A, B) :- A, B.
equ(A, B) :- not(A), not(B).

%truth_table(A, B, E)
truth_table(A, B, E) :- getAllValues(A, B), call(E), printLine(A, B, true).
truth_table(A, B, E) :- getAllValues(A, B), not(call(E)), printLine(A, B, false).
truth_table(A, B, E) :- true.

%printLine(A, B, R)
printLine(A, B, R) :- write(A), write("  "), write(B), write("  "), writeln(R), false.