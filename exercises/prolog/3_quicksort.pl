% Определить предикат qsort(L, K) который для заданного списка целых чисел возвращает отсортированный 

qsort([],[]).
qsort([Head|Tail],Sorted) :-

	% нам нужно разделить массив на 2 части, используя "pivot"
	partition(Head,Tail,Little,Big),

	% затем мы используем qsort () для левой стороны, которая имеет элементы меньше чем pivot
	qsort(Little,SortedLittle),

	% и для правой стороны, где элементы больше, чем pivot
	qsort(Big,SortedBig),

	% мы используем append, чтобы собрать отсортированные части вместе
	append(SortedLittle,[Head|SortedBig],Sorted).

partition(_,[],[],[]).
% здесь мы анализируем и сравниваем все элементы с pivot
partition(Pivot,[Head|Tail], [Head|Little], Big) :-	
Head =< Pivot, partition(Pivot,Tail,Little,Big).
partition(Pivot,[Head|Tail], Little, [Head|Big]) :-
	% if element greater than pivot we put it into the less part
	partition(Pivot,Tail,Little,Big).

%?- qsort([8,2,1,-2,-19,10,101,-20],Sorted).
%Sorted = [-20, -19, -2, 1, 2, 8, 10, 101] 
