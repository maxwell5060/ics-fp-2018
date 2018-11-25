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
	xor(A, B) :- not(equ(A, B)).
	
	eval(Expression) :- call(Expression), writeln("true"), !.
 	eval(_) :- writeln("fail"), !.

	truth_table(A, B, Expression) :- bool(A), bool(B),
  write(A), write(' '),
  write(B), write(' '),
  evaluate(Expression, Result),
  write(Result), nl, fail.
  
