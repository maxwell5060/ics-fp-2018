% определить предикат mrg(L1, L2, L) который для двух отсортированных списков L1 и L2
% определяет список L, составленный из этих элементов

mrg(L1, L2, L) :- Arr = [], mrg2(L1, L2, Arr, L).
mrg2([],L2, Arr, R) :- append(Arr, L2, Arr2), R = Arr2.
mrg2(L1,[], Arr, R) :- append(Arr, L1, Arr2), R = Arr2.
mrg2([H1|L1], [H2|L2], Arr, R) :- H1 < H2, append(Arr, [H1], Arr2), mrg2(L1, [H2|L2], Arr2, R).
mrg2([H1|L1], [H2|L2], Arr, R) :- H1 >= H2, append(Arr, [H2], Arr2), mrg2([H1|L1], L2, Arr2, R).

% Example
% ?-mrg([1,2,4,5,18],[1,3,5,10],L).
% L = [1, 1, 2, 3, 4, 5, 5, 10, 18] .
