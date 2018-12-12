% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

qsort(L, K):- qsort_1(L, K).

qsort_1([],[]).
qsort_1([H|T],K):-
	pivoting(H,T,L1,L2),qsort_1(L1,Sorted1),qsort_1(L2,Sorted2),
	append(Sorted1,[H|Sorted2], K).
   
pivoting(H,[],[],[]).
pivoting(H,[X|T],[X|L],G):-X=<H,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-X>H,pivoting(H,T,L,G).

append([], K, K).
append([H|T], K, [H|E]) :- append(T, K, E).

divide(List, L, R) :-
    append(L, R, List),
    length(L, LL),
    length(R, RL),
    (LL =:= RL; LL =:= (RL - 1)), !.

balanced_tree([], empty).
balanced_tree(List, instant(H, empty, empty)) :- 
    List = [H|[]], !.
balanced_tree([Te|[Hi|[]]], instant(Bo, LN, empty)) :- 
    Te < Bo, 
    balanced_tree([Te], LN), !.
balanced_tree([Bo|[Te|[]]], instant(Bo, LN, empty)) :- 
    balanced_tree([Te], LN), !.
balanced_tree(List, instant(Mid, LN, RN)) :-
    qsort(List, Sorted),
    divide(Sorted, LeftList, [Mid|RightList]),
    balanced_tree(LeftList, LN),
    balanced_tree(RightList, RN), !.
	
% balanced_tree([4,2,6], T).
% ?- balanced_tree([4,2,6], T).
% T = instant(4, instant(2, empty, empty), instant(6, empty, empty)).