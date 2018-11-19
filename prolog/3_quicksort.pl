% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

%% quicksort divides the list by choosing (arbitrary) the first element,
%% called a pivot, and using this element to split the list into Left and
%% Right.  Left has all elements smaller than the pivot.  Right has all
%% elements larger than the pivot.
%% The sorted list is [Left, pivot, Right].

%% splitBy( H, U, Lefts, Rights )
%% True if Lefts = { L in U | L <= H }; Rights = { R in U | R > H }
split(_, [], [], []).
split(H, [U|T], [U|Lefts], Rights) :- U =< H, split(H, T, Lefts, Rights).
split(H, [U|T], Lefts, [U|Rights]) :- U  > H, split(H, T, Lefts, Rights).

qsort([], []).
qsort([H|U], Res) :- split(H, U, L, R), qsort(L, SL), qsort(R, SR), append(SL, [H|SR], Res).
 
%% ?- qsort([1, 4, 3, 1, 2], L).
%% L = [1, 1, 2, 3, 4] .
