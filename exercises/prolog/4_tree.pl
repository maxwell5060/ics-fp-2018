% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

balanced_tree([], empty).
balanced_tree(L, R) :-
	qsort(L, L1),
	balanced_tree2(L1, R).

balanced_tree2([], empty).
balanced_tree2([X], instant(X, empty, empty)).
balanced_tree2(List, instant(Middle, LTree, RTree)) :-
	middle(List, MiddleIndex, Middle),
	split_into_halves(List, MiddleIndex, Left, Right),
	balanced_tree2(Left, LTree),
	balanced_tree2(Right, RTree).

split_into_halves(List, Middle, Left, Right) :-
	split_into_halves2(List, Middle, 1, Left, Right).

split_into_halves2([], _, _, [], []).
split_into_halves2([H|T], Middle, Cnt, [H|Left], Right) :-
	Cnt < Middle,
	Cnt1 is Cnt + 1,
	split_into_halves2(T, Middle, Cnt1, Left, Right).

split_into_halves2([_|T], Middle, Cnt, Left, Right) :-
	Cnt = Middle,
	Cnt1 is Cnt + 1,
	split_into_halves2(T, Middle, Cnt1, Left, Right).

split_into_halves2([H|T], Middle, Cnt, Left, [H|Right]) :-
	Cnt > Middle,
	Cnt1 is Cnt + 1,
	split_into_halves2(T, Middle, Cnt1, Left, Right).

middle([], 0, 0).
middle(L, I, M) :-
	size(L, 0, S),
	I is ceil(S/2),
	middle2(L, I, 1, M).

size([], S, S).
size([_|T], A, S) :-
	A1 is A + 1,
	size(T, A1, S).

middle2([H|_], S, S, H).
middle2([_|T], S, C, M) :-
	C1 is C + 1,
	middle2(T, S, C1, M).


% Quick Sort

qsort([], []).
qsort([H|T], Res) :-
	quicksort(T, H, Left, Right),
	qsort(Left, RLeft),
	qsort(Right, RRight),
	append(RLeft, [H|RRight], Res).

quicksort([], _, [], []).
quicksort([H|T], Pivot, [H|Left], Right) :- 
    H =< Pivot,
    quicksort(T, Pivot, Left, Right),!.
quicksort([H|T], Pivot, Left, [H|Right]) :-
    H > Pivot,
    quicksort(T, Pivot, Left, Right).
