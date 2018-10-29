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

and(A,B):- 
	A, B.

or(A,B):-
	A; B.	

xor(A,B):-
	A = true, B = fail;
	A = fail, B = true.

not(A):-
	A = fail.

equ(A,B):-
	A = B.

get_result(Expression, true) :- Expression, !.
get_result(_, fail).

truth_table(A,B,Expression) :-
  bool(A),
  bool(B),
  write(A), write(' '),
  write(B), write(' '),
  get_result(Expression, Result),
  write(Result),nl,fail.
  
% первая версия - менее компактная

/*formated_print([]) :- !.
formated_print([H|T]) :-
	write(H),
	write('  '),
	formated_print(T),
	nl.

truth_table(A, B, Expression) :- 
	A=true, B=true,
	truth_table(A, B, Expression, Result), 
	formated_print([A, B, Result]),
	A1=true, B1=false,
	truth_table(A1, B1, Expression, Result), 
	formated_print([A1, B1, Result]),
	A2=false, B2=true,
	truth_table(A2, B2, Expression, Result), 
	formated_print([A2, B2, Result]),
	A3=false, B3=false,
	truth_table(A3, B3, Expression, Result), 
	formated_print([A3, B3, Result]). 

truth_table(A, B, and(X,Y), Result):-
	truth_table(A, B, X, R1),
	truth_table(A, B, Y, R2),
	and(R1, R2)->Result=true, !; 
	Result = false, !.

truth_table(A, B, or(X,Y), Result):-
	truth_table(A, B, X, R1),
	truth_table(A, B, Y, R2),
	or(R1, R2)->Result=true, !; 
	Result = false, !.

truth_table(A, B, xor(X,Y), Result):-
	truth_table(A, B, X, R1),
	truth_table(A, B, Y, R2),
	xor(R1, R2)->Result=true, !; 
	Result = false, !.

truth_table(A, B, not(X), Result):-
	truth_table(A, B, X, R1),
	not(X)->Result=true, !; 
	Result = false, !.

truth_table(A, B, equ(X,Y), Result):-
	truth_table(A, B, X, R1),
	truth_table(A, B, Y, R2),
	equ(R1, R2)->Result=true, !; 
	Result = false, !.

truth_table(A, B, X, Result):-
	X = A -> Result = X;
	X = B -> Result = X.

truth_table(A, B, X, X).*/
