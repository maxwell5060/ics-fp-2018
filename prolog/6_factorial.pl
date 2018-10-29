% factorial
factorial1(0,R) :- R is 1.
factorial1(N,R) :- N > 0, N1 is N-1, factorial1(N1,R1), R is R1*N.

% tail recursion factorial
factorial2(N, R) :- factorial2(N, 1, R).
factorial2(0, R, R) :- !.
factorial2(N, Acc, R) :- N2 is N - 1, Acc2 is Acc * N, factorial2(N2, Acc2, R).

% Example

% ?- factorial1(5,R).
% R = 120 .

% ?- factorial2(5,R).
% R = 120.
