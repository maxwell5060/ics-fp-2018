% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

pivot(_, [], [], []).
pivot(Pivot, [Head|Tail], [Head|LessOrEqualThan], GreaterThan) :- Pivot >= Head, pivot(Pivot, Tail, LessOrEqualThan, GreaterThan).
pivot(Pivot, [Head|Tail], LessOrEqualThan, [Head|GreaterThan]) :- pivot(Pivot, Tail, LessOrEqualThan, GreaterThan).

qsort(L, K) :- quicksort(L, K).
quicksort([], []).
quicksort([Head|Tail], Sorted) :- pivot(Head, Tail, List1, List2), quicksort(List1, SortedList1), quicksort(List2, SortedList2), append(SortedList1, [Head|SortedList2], Sorted).


split(List, L, R) :-
    append(L, R, List),
    length(L, LL),
    length(R, RL),
    (LL =:= RL; LL =:= (RL - 1)), !.

balanced_tree([], empty).
balanced_tree(List, instant(H, empty, empty)) :- List = [H|[]], !.
balanced_tree([Lo|[Hi|[]]], instant(Hi, LeftChild, empty)) :- Lo < Hi, balanced_tree([Lo], LeftChild), !.
balanced_tree([Hi|[Lo|[]]], instant(Hi, LeftChild, empty)) :- balanced_tree([Lo], LeftChild), !.
balanced_tree(List, instant(Mid, LeftChild, RightChild)) :-
    qsort(List, Sorted),
    split(Sorted, LeftList, [Mid|RightList]),
    balanced_tree(LeftList, LeftChild),
    balanced_tree(RightList, RightChild), !.

% ?- balanced_tree([5,3,2,6,7], T)
% T = instant(5, instant(3, instant(2, empty, empty), empty), instant(7, instant(6, empty, empty), empty))
