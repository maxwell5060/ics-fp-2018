% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
qsort([], []).

qsort([ELEM], [ELEM]).

qsort([PIV|TAIL], SORTED):- divide(TAIL, PIV, BigP, SmallP), qsort(BigP, SortedBigP),
  		qsort(SmallP, SortedSmallP),!, append(SortedSmallP, [PIV|SortedBigP], SORTED).

divide([], _, [], []):-!.

divide([HEAD|TAIL], PIV, [HEAD|BigP], SmallP):- HEAD >= PIV, !, divide(TAIL, PIV, BigP, SmallP).

divide([HEAD|TAIL], PIV, BigP, [HEAD|SmallP]):- divide(TAIL, PIV, BigP, SmallP).

balanced_tree([], empty).

balanced_tree(LIST, instant(HEAD, empty, empty)) :- LIST = [HEAD|[]], !.

balanced_tree([L1|[H1|[]]], instant(H1, LCH1LD, empty)) :- L1 < H1, balanced_tree([L1], LCHILD), !.

balanced_tree([H1|[L1|[]]], instant(H1, LCHILD, empty)) :- balanced_tree([L1], LCHILD), !.

balanced_tree(LIST, instant(MID, LCHILD, RCHILD)) :- qsort(LIST, SORTED), split_tree(SORTED, LLIST, [MID|RLIST]),
    balanced_tree(LLIST, LCHILD), balanced_tree(RLIST, RCHILD), !.

split_tree(LIST, L, R) :- append(L, R, LIST), length(L, LLENGTH), length(R, RLENGTH),
	(LLENGTH =:= RLENGTH; LLENGTH =:= (RLENGTH - 1)), !.

% ?- balanced_tree([1,2],T).
% instant(2, empty, instant(1, empty, empty)) .