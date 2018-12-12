% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2
% определяет список R, составленный из этих элементов

mrgHelper([H1 | T1], [H2 | T2], Acc, R) :-
  H1 =< H2,
  append(Acc, [H1 | []], NewAcc),
  mrgHelper(T1, [H2 | T2], NewAcc, R).
mrgHelper([H1 | T1], [H2 | T2], Acc, R) :-
  H2 < H1,
  append(Acc, [H2 | []], NewAcc),
  mrgHelper([H1 | T1], T2, NewAcc, R).
mrgHelper([], L2, Acc, R) :-
  append(Acc, L2, R).
mrgHelper(L1, [], Acc, R) :-
  append(Acc, L1, R).

mrg(L1, L2, R) :-
  mrgHelper(L1, L2, [], R).

% ?- mrg([1,3,5,7], [0,2,4,6,8], R).
% R = [0, 1, 2, 3, 4, 5, 6, 7, 8] .
% 
% ?- mrg([1,2,3,4], [5,6,7,8], R).
% R = [1, 2, 3, 4, 5, 6, 7, 8] .
% 
% ?- mrg([5,6,7,8], [1,2,3,4], R).
% R = [1, 2, 3, 4, 5, 6, 7, 8] .
