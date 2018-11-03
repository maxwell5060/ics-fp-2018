% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

reorder([],_Num,Left,Right,Left,Right).

reorder(Arr, Num, Left, Right,NewLeft,NewRight) :-
	Arr = [Head | Tail],
	Head >= Num,
	append(Right,[Head],NewRight2),
	reorder(Tail,Num,Left,NewRight2,NewLeft,NewRight).

reorder(Arr, Num, Left, Right, NewLeft, NewRight) :-
	Arr = [Head | Tail],
	Head < Num,
	append(Left,[Head],NewLeft2),
	reorder(Tail,Num,NewLeft2,Right,NewLeft,NewRight).

qsort([],K) :- K = [], !.
qsort(L,K) :- integer(L), K = [L], !.
qsort(L,K) :- L = [_Head | Tail], Tail = [], K = L, !.

qsort(L,K) :- 
	L = [Head | Tail], 
	reorder(Tail, Head, [], [],NewLeft,NewRight),
	qsort(NewLeft,SortedLeft),
	qsort(NewRight,SortedRight),
	append(SortedLeft, [Head | SortedRight],K), !.

% ?- qsort([1,3,9,-1,7,0,-12,39,6],K).

/*

Output:

K = [-12, -1, 0, 1, 3, 6, 7, 9, 39].

*/

