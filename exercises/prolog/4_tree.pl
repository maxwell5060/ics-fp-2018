% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
partition(P, [H|T], [H|Less], Greater) :- H =< P, partition(P, T, Less, Greater).
partition(P, [H|T], Less, [H|Greater]) :- H > P, partition(P, T, Less, Greater).
partition(_, [], [], []).

qsort([H|T], Sorted) :- partition(H, T, Less, Greater), qsort(Less, SortedLess), qsort(Greater, SortedGreater), append(SortedLess, [H|SortedGreater], Sorted).
qsort([], []).

split(List, Left, Right) :- append(Left, Right, List), length(List, Len), Half is Len div 2, length(Left, Half).

general_balanced_tree([], empty).
general_balanced_tree(List, instant(Root, LeftChild, RightChild)) :- split(List, LeftList, [Root|RightList]), general_balanced_tree(LeftList, LeftChild), general_balanced_tree(RightList, RightChild).

balanced_tree(List, Tree) :- qsort(List, SortedList), general_balanced_tree(SortedList, Tree).
