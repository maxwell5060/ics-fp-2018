% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

Используем разбиение Ломуто, вытаскиваем сублисты без элемента pivot, рекурсивно вычисляя qsort записываем pivot между вычисляемыми сублистами.

leftArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD =< PIVOT, leftArray(PIVOT,TAIL,INRESULT), append([HEAD],INRESULT,RESULT).
leftArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD > PIVOT, leftArray(PIVOT,TAIL,INRESULT), append([],INRESULT,RESULT).
leftArray(PIVOT,[HEAD|TAIL],[]) :- length(TAIL,L), L == 0.

rightArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD > PIVOT, rightArray(PIVOT,TAIL,INRESULT), append([HEAD],INRESULT,RESULT).
rightArray(PIVOT,[HEAD|TAIL],RESULT):- length(TAIL,L), L > 0, HEAD =< PIVOT, rightArray(PIVOT,TAIL,INRESULT), append([],INRESULT,RESULT).
rightArray(PIVOT,[HEAD|TAIL],[]) :- length(TAIL,L), L == 0.

qsort(ARRAY,ARRAY) :- length(ARRAY,1).
qsort([],[]).

qsort(ARRAY,RESULT) :- last(ARRAY,PIVOT), leftArray(PIVOT,ARRAY,LEFTARRAY), rightArray(PIVOT,ARRAY,RIGHTARRAY), qsort(LEFTARRAY,LEFTRESULT), qsort(RIGHTARRAY,RIGHTRESULT), append(LEFTRESULT,[PIVOT],PROMRESULT), append(PROMRESULT,RIGHTRESULT,RESULT).

?- qsort([2,1,2],R).
R = [1, 2, 2] .

?- qsort([1,1,2],R).
R = [1, 1, 2] .

?- qsort([1,1,1],R).
R = [1, 1, 1] .

?- qsort([],R).
R = [] .

?- qsort([1,2,3,4,5,6,7,8,9],R).
R = [1, 2, 3, 4, 5, 6, 7, 8, 9] .

?- qsort([9,8,7,6,5,4,3,2,1],R).
R = [1, 2, 3, 4, 5, 6, 7, 8, 9] .

?- qsort([1,10,1,20,0,0,1],R).
R = [0, 0, 1, 1, 1, 10, 20] .

?- qsort([1,0,2,9,3,8,4,7,5],R).
R = [0, 1, 2, 3, 4, 5, 7, 8, 9] .

?- qsort([1,1,1,2,2,2,3,3,3],R).
R = [1, 1, 1, 2, 2, 2, 3, 3, 3] .

?- qsort([9,1,8,9,2,9,3,2,3],R).
R = [1, 2, 2, 3, 3, 8, 9, 9, 9] .