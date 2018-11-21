% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 
partition([], _, [], []).
partition([Head | Tail], Pivot, [Head | LessOrEqual], Greater) :- 
	Head =< Pivot, partition(Tail, Pivot, LessOrEqual, Greater).

partition([Head | Tail], Pivot, Less, [Head | Greater]) :-
	Head > Pivot, partition(Tail, Pivot, Less, Greater).


quick_sort([Head | Tail], SortedList) :-
	partition(Tail,Head,LessList,GreaterList),
	quick_sort(LessList,LessListSorted),
	quick_sort(GreaterList, GreaterListSorted),
	append(LessListSorted, [Head | GreaterListSorted], SortedList).

quick_sort([],[]).
