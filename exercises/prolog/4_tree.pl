% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% Quicksort

qsort(L, K) :- quicksort(L, K).
quicksort([], []).
quicksort([Head|Tail], Sorted) :-
pivot(Head, Tail, List1, List2),
quicksort(List1, SortedList1),
quicksort(List2, SortedList2),
append(SortedList1, [Head|SortedList2],
Sorted).

pivot(_, [], [], []).

pivot(Pivot, [Head|Tail], [Head|Left], Right) :- Pivot >= Head, pivot(Pivot, Tail, Left, Right).
pivot(Pivot, [Head|Tail], Left, [Head|Right]) :- pivot(Pivot, Tail, Left, Right).

% Balanced tree

balanced_tree([], empty).
