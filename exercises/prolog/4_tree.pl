% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% ?- balanced_tree([1,0,-1,3,18,19], T).
% T = instant(3, instant(0, instant(-1, empty, empty), instant(1, empty, empty)), instant(18, instant(19, empty, empty), empty)) 

balanced_tree([], empty).

balanced_tree(List, Tree) :-
    Tree = instant(Root, empty, empty),
    List = [Root].

balanced_tree(List, Tree) :-
    List = [Root|[E]],
    Tree = instant(Root, L, empty),
    E >= Root,
    balanced_tree([E], L).

balanced_tree(List, Tree) :-
    List = [E|[Root]],
    Tree = instant(Root, L, empty),
    Root > E,
    balanced_tree([E], L).

balanced_tree(List, Tree) :-
    Tree = instant(Root, L, R),
    qsort(List, Sorted),
    append(ListL, [Root|ListR], Sorted),
    length(ListL, LenL),
    length([Root|ListR], LenR),
    (LenL =:= LenR;
    LenL =:= (LenR - 1)),
    balanced_tree(ListL, L),
    balanced_tree(ListR, R).



qsort([], []).
qsort(L, K) :-
    L = [H|T],
    partition(H, T, Lp, Rp),
    qsort(Lp, Ls),
    qsort(Rp, Rs),
    append(Ls, [H|Rs], K).

partition(_, [], [], []).
partition(A, L, Lp, Rp) :-
    L = [H|T],
    Lp = [H|Tp],
    A >= H,
    partition(A, T, Tp, Rp).
partition(A, L, Lp, Rp) :-
    L = [H|T],
    Rp = [H|Tp],
    A < H,
    partition(A, T, Lp, Tp).
