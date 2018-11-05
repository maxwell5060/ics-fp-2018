% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 


split(_, [], [], []).
split(X, [Head | Body], [Head | Less], Greater)	:- Head =< X, split(X, Body, Less, Greater).
split(X, [Head | Body], Less, [Head | Greater])	:- Head > X, split(X, Body, Less, Greater).

qsort([],[]).
qsort([Head | Body], Result):- 
	split(Head, Body, Less, Greater), 
	qsort(Less, SortedLess), 
	qsort(Greater, SortedGreater), 
	append(SortedLess, [Head | SortedGreater], Result).	


% ================================
% ?- qsort([3,4,5,0,1,2],K).
% K = [0, 1, 2, 3, 4, 5] 	

% ================================
% ?- qsort([1,2,4,5],[1,4,5]).
% false.