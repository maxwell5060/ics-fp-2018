% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

mrg(L1, L2, R) :-
	merge(L1,L2,[],R), !.

merge([],[],Current,Current) :- !.

merge(L1,L2,Current,Result) :-
	integer(L1),
	merge([L1],L2,Current,Result).

merge(L1,L2, Current,Result) :-
	integer(L2),
	merge(L1,[L2],Current,Result).

merge([],L2,Current,Result) :-
	append(Current,L2,Result), !.

merge(L1,[],Current,Result) :-
	append(Current,L1,Result), !.

merge(L1, L2,Current,Result) :-
	L1 = [Head1 | Tail1],
	L2 = [Head2 | Tail2],
	Head1 >= Head2,
	append(Current,[Head2],NewCurrent),
	merge(L1,Tail2,NewCurrent,Result).

merge(L1, L2, Current, Result) :-
	L1 = [Head1 | Tail1],
	L2 = [Head2 | Tail2],
	Head1 < Head2,
	append(Current,[Head1],NewCurrent),
	merge(Tail1,L2,NewCurrent,Result).

?- mrg([5,6,11],[9,10,11],A).

/*

Output:

A = [5, 6, 9, 10, 11, 11].

*/	

