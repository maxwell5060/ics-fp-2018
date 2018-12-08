% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов
mrg(L1, [], L1).
mrg([], L2, L2).
mrg([],[],[]).
mrg([Head1|Tail1], [Head2|Tail2], [Head1|T]):-
	Head1 =< Head2, !, 
	mrg(Tail1, [Head2|Tail2], T).
mrg([Head1|Tail1], [Head2|Tail2], [Head2|T]):-
	mrg([Head1|Tail1], Tail2, T).

% ?- mrg([-1,1,4,5],[-3,0,2,3,5],R).
% R = [-3, -1, 0, 1, 2, 3, 4, 5, 5] 
