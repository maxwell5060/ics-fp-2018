% определить предикаты:
% ипользовать предикат truth_table(A,B, expression) для построения таблиц истинности, например:

and(A,B) :- A, B.
or(A,B)  :- A ; B.
not(A)	 :- \+ A.
xor(A,B) :- not(equ(A,B)).
equ(A,B) :- A == B.

var_bool(true).
var_bool(false).

operation(Expr,true) :- Expr,!.
operation(_, false).

table(A,B,Expr) :- var_bool(A), var_bool(B), print(A,B,Expr), false.
print(A,B,Expr) :- write(A), write('\t'), write(B), write('\t'), operation(Expr, Result), write(Result), write('\n'), false.



% ================================
% truth_table(A,B,and(A,or(A,B))).
% true	true	true
% true	false	true
% false	true	false
% false	false	false

% ================================
% table(A,B,and(A,not(B))).
% true	true	false
% true	false	true
% false	true	false
% false	false	false

% ================================
% table(A,B,and(A,or(A,not(B)))).
% true	true	true
% true	false	true
% false	true	false
% false	false	false
