% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort(L, K):- qsort_1(L, K).

qsort_1([],[]).
qsort_1([H|T],K):-
	pivoting(H,T,L1,L2),qsort_1(L1,Sorted1),qsort_1(L2,Sorted2),
	append(Sorted1,[H|Sorted2], K).
   
pivoting(H,[],[],[]).
pivoting(H,[X|T],[X|L],G):- X=<H, pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):- X>H, pivoting(H,T,L,G).

append([], K, K).
append([H|T], K, [H|E]) :- append(T, K, E).

% Test  Tri
% ?- qsort([9, 2, 6, 32, 8, 4], K).
% K = [2, 4, 6, 8, 9, 32].