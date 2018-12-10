% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов
mrg(L1, L2, R):-
	L1 = [Head1|Tail1],
	L2 = [Head2|Tail2],
	merge([Head1|Tail1],[Head2|Tail2], R).

mrg(L1, [], L1).
mrg([], L2, L2).
mrg([],[],[]).

merge([Head1|Tail1], [Head2|Tail2], [Head1|Tail]):-
	Head1 < Head2, !,
	merge(Tail1, [Head2|Tail2], Tail).

merge([Head1|Tail1], [Head2|Tail2], [Head2|Tail]):-
	merge([Head1|Tail1], Tail2, Tail).

merge(L1, [], L1).
merge([], L2, L2).
merge([],[],[]).

run:-
	L1 = [1,3,5],
	L2 = [2,4,6],
	L3 = [],
	write(L1), write(' merge with '), write(L2), nl,
	mrg(L1,L2,R1),
	write(R1), nl,
	write(L1), write(' merge with '), write(L3), nl,
	mrg(L1,[],R2),
	write(R2), nl,
	write(L3), write(' merge with '), write(L2), nl,
	mrg([],L2,R3),
	write(R3).


% ?- run.
% [1,3,5] merge with [2,4,6]
% [1,2,3,4,5,6]
% [1,3,5] merge with []
% [1,3,5]
% [] merge with [2,4,6]
% [2,4,6]
% true