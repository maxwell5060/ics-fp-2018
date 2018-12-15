% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный

%% quicksort divides the list by choosing (arbitrary) the first element,
%% called a pivot, and using this element to split the list into Left and
%% Right.  Left has all elements smaller than the pivot.  Right has all
%% elements larger than the pivot.
%% The sorted list is [Left, pivot, Right].

%% split( H, U, Lefts, Rights )
%% True if Lefts = { L in U | L <= H }; Rights = { R in U | R > H }

%% H is a pivot here

split(_, [], [], []).

%% If Uh is not less than H, then it goes to Lefts
split(H, [Uh|T], [Uh|Lefts], Rights) :-
    Uh =< H,
    split(H, T, Lefts, Rights).

%% If Uh is larger than H, then it goes to Rights
split(H, [Uh|T], Lefts, [Uh|Rights]) :-
    Uh > H,
    split(H, T, Lefts, Rights).

qsort([], []).
qsort([H|U], Res) :-
    split(H, U, L, R), %% split U into Lefts (L) and Rigths (R)
    qsort(L, SL), %% Sort these parts separatelly, with qsort
    qsort(R, SR),
    append(SL, [H|SR], Res), %% Join the sorted parts
    !. %% Cut the execution since we do not need to find another sort
    
%% ?- qsort([1, 4, 3, 1, 2], L).
%% L = [1, 1, 2, 3, 4].
