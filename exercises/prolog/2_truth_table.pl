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

and(A,B) :- A, B.
or(A,B) :- A; B.
not(A) :- \+A.
xor(A,B) :- or(and(A,not(B)),and(not(A),B)).
equ(A,B) :- not(xor(A, B)).

calc(Exp,true) :- Exp, !.
calc(_,fail).

printTruthTable(A,B,Res) :-
  write(A),
  write('\t'),
  write(B),
  write('\t'),
  writeln(Res).

truth_table(A,B,Exp) :-
  bool(A),
  bool(B),
  calc(Exp,Res),
	printTruthTable(A,B,Res),
  fail.

% Results:
%	?- truth_table(A,B,and(A,B)).
%	true	true	true
%	true	fail	fail
%	fail	true	fail
%	fail	fail	fail
%	false.

%	?- truth_table(A,B,and(not(A),not(B))).
%	true	true	fail
%	true	fail	fail
%	fail	true	fail
%	fail	fail	true
%	false.

%	?- truth_table(A,B,xor(A,not(B))).
%	true	true	true
%	true	fail	fail
%	fail	true	fail
%	fail	fail	true
%	false.

%	?- truth_table(A,B,equ(A,not(B))).
%	true	true	fail
%	true	fail	true
%	fail	true	true
%	fail	fail	fail
%	false.
