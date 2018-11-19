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

and(A, B) :- A, B.
or(A, B) :- A; B.
not(A) :- A = fail.
equ(A, B) :- A = B.
xor(A, B) :- and(A, not(B)); and(B, not(A)).


%% find(Symbol) matches symbol to true or to fail
find(true).
find(fail).

%% find(Expression, Res), matches the result of expression, same as above
find(Expr, true) :- Expr, !. % ! to stop finding
find(_, fail).

truth_table(A, B, Expr) :-
    %% find values at the top to prevent inconsistent backtracking
    find(A), find(B), find(Expr, Res),
    %% write a row
    write(A), write(' '), write(B), write(' '), write(Res), nl,
    %% return fail to find other solutions
    fail.
