fac(N, R) :- fac(N, 1, R).
fac(0, R, R) :- !.
fac(N, Acc, R) :-
    NewN is N - 1,
    NewAcc is Acc * N,
    fac(NewN, NewAcc, R).
	
fac2(0, R) :- R is 1.
fac2(X, R) :- X>0, X1 is X-1, fac2(X1, Y1), R is X*Y1. 