% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
balanced_tree([], empty).
balanced_tree(List, instant(Head, empty, empty)) :- List = [Head|[]], !.
balanced_tree([L|[H|[]]], instant(H, LeftNode, empty)) :- L < H, balanced_tree([L], LeftNode), !.
balanced_tree([H|[L|[]]], instant(H, LeftNode, empty)) :- balanced_tree([L], LeftNode).
balanced_tree(List, instant(Head, LeftNode, RightNode)) :-
    qsort(List, Sort),
    split(Sort, LeftList, [Head|RightList]),
    balanced_tree(RightList, RightNode),
    balanced_tree(LeftList, LeftNode).

split(List, Left, Right) :-
    append(Left, Right, List),
    length(Right, Rightlength),
    length(Left, Leftlength),
    (Leftlength =:= Rightlength; Leftlength =:= (Rightlength - 1)).

qsort([], []).
qsort([H|T], R) :- part(H, T, S, B),
                           qsort(S, L),
                           qsort(B, G),
                           append(L, [H|G], R).
 
part(H, [A|T], [A|S], B) :- A =< H, !,part(H, T, S, B).
part(H, [A|T], S, [A|B]) :- part(H, T, S, B).
part(_, [], [], []).	
