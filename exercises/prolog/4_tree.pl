% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(Root, L, R) - бинарное дерево с корнем Root и двумя поддеревьями L и R соотвественно (левое и правое)


qsplit(_, [], [], []).

qsplit(H, [Uh|T], [Uh|Lefts], Rights) :-
    Uh =< H,
    qsplit(H, T, Lefts, Rights).

qsplit(H, [Uh|T], Lefts, [Uh|Rights]) :-
    Uh > H,
    qsplit(H, T, Lefts, Rights).

qsort([], []).
qsort([H|U], Res) :-
    qsplit(H, U, L, R),
    qsort(L, SL),
    qsort(R, SR),
    append(SL, [H|SR], Res),
    !.

%%

%% Split a List into two parts with equal length
%%
%% Example:
%%
%% ?- split_into_halves([1, 3, 5, 6, 2], L, R).
%% L = [1, 3],
%% R = [5, 6, 2] ;
%% L = [1, 3, 5],
%% R = [6, 2] ;
%% false.
%% 
%% ?- split_into_halves([1, 3, 5, 6, 2], L, R), !.
%% L = [1, 3],
%% R = [5, 6, 2].
split_into_halves(List, Left, Right) :-
    append(Left, Right, List),	% Find Left and Right parts
    length(Left, ResLenLeft),	% Find Left length
    length(Right, ResLenRight), % Find Rightlength
    (ResLenLeft =:= ResLenRight; % Ok if lengths are equal
     ResLenLeft =:= (ResLenRight - 1); % ... or when one length is one off than other
     ResLenRight =:= (ResLenLeft - 1)).

%% balanced_tree_sorted assumes that list is sorted
%% It allows us to avoid unnecessary qsort() calls
balanced_tree_sorted([], empty).

%% Actually, we do not need to create a tree, if there is the only
%% element in the list
balanced_tree_sorted(L, H) :- L = [H|[]], !.

balanced_tree_sorted([Lower|[Higher]], instant(Higher, Lower, empty)).

balanced_tree_sorted(L, instant(Root, LeftSubTree, RightSubTree)) :-
    split_into_halves(L, Left, [Root|Right]), % Find Right & Left halves
    balanced_tree_sorted(Left, LeftSubTree), % Find LeftSubTree
    balanced_tree_sorted(Right, RightSubTree), % Find RightSubTree
    !.
    
    
%% balanced_tree 
balanced_tree(L, Res) :-
    qsort(L, SortedList),
    balanced_tree_sorted(SortedList, Res),
    !.


%% Examples
%%
%% ?- balanced_tree([], R).
%% R = empty.
%%
%% ?- balanced_tree([1], R).
%% R = 1.
%%
%% ?- balanced_tree([1, 7], R).
%% R = instant(7, 1, empty).
%%
%% ?- balanced_tree([1, 7, 2, 6, 3, 0, 5, 2], R).
%% R = instant(3, instant(2, instant(1, 0, empty), 2), instant(6, 5, 7)).
