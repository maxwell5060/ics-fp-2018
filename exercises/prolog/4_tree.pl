% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

lengthL([], 0).
lengthL([H|T], Len) :-
	lengthL(T, Len1),
	plus(Len1, 1, Len).

arrayPartition([], 0, nil, [], []).
arrayPartition([H|T], 0, H, [], T).
arrayPartition([H|T], HalfLen, MidEl, LL, RL) :-
	HalfLen1 is -(HalfLen, 1),
	arrayPartition(T, HalfLen1, MidEl, LL1, RL), LL = [H|LL1].

buildBalancedTree([], 0, empty).
buildBalancedTree(L, Len, T) :-
	Len > 0,
	divmod(Len, 2, HalfLen, Re),
	arrayPartition(L, HalfLen, MidEl, LL, RL),
	buildBalancedTree(LL, HalfLen, LefTr),
	RHalfLen is -(HalfLen, -(1, Re)),
	buildBalancedTree(RL, RHalfLen, RiTr),
	T = instance(MidEl, LefTr, RiTr).

balance_tree(Li, T) :-
	qsort(Li, SL),
	lengthL(SL, Len),
	buildBalancedTree(SL, Len, T).





%qsort(L, R)
qsort([], []).
qsort([H|T], R) :- partition(T, H, SM, GR), qsort(SM, R1), qsort(GR, R2), appened(R1, [H|R2], R).

%partition(L, P, SM, GR)
partition([], _, [], []).
partition([H|T], P, [H|TSM], GR) :- H =< P, partition(T, P, TSM, GR).
partition([H|T], P, SM, [H|TGR]) :- H > P, partition(T, P, SM, TGR).

%appened(L1, L2, R)
appened([], L2, L2).
appened([H|T1], L2, [H|TR]) :- appened(T1, L2, TR).