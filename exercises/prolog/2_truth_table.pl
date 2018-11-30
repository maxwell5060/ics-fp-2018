
and(A,B) :- 
	A , B.


or(A,B) :- 
	A ; B.


not(A):- 
	A = false.


not2(A):- 
	A, !, false ; true.


nand(A,B) :- 
	not(and(A,B)).


nor(A,B) :- 
	not(or(A,B)).


xor(A,B) :- 
	or(A,B), nand(A,B).


equ(A,B) :-
	 A = B.


boolean(true).


boolean(false).


result(Oper, true) :- 
		Oper, writeln("true"), !.


result(_, false) :-
		writeln("false"), !.


truth_table(A, B, Oper):-
			boolean(A),
			boolean(B),
			write(A), 
			write(" "), 
			write(B), 
			write(" "),
			result(Oper, _),
			false.


truth_table(_, _, _) :- 
			true.




% ?- truth_table(A,B,and(A,or(A,B))).
% true true true
% true false true
% false true false
% false false false



