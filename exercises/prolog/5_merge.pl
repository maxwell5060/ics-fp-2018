% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

print(X,Y,List1, List2, Result)		:- write(X), write("\t"), write(Y), write("\t"), write(List1), write("\t"), write(List2), write("\t"), write(Result), write("\n").

mgr([],[],[]).
mgr([],List,List).
mgr(List,[],List)			:- List \= [].
mgr([X|Body1],[Y|Body2],[X|Body])	:- X==Y,print(X,Y,Body1,Body2,Body),     mgr(Body1,Body2,Body).
mgr([X|Body1],[Y|Body2],[X|Body])	:- X<Y, print(X,Y,Body1,[Y|Body2],Body), mgr(Body1,[Y|Body2],Body).
mgr([X|Body1],[Y|Body2],[Y|Body])	:- X>Y, print(X,Y,[X|Body1],Body2,Body), mgr([X|Body1],Body2,Body).


% =============================
% ?- mgr([1,2,7],[2,5,6],R).
%1	2	[2,7]	[2,5,6]	_6112
%2	2	[7]	[5,6]	_6160
%7	5	[7]	[6]	_6196
%7	6	[7]	[]	_6244
% R = [1, 2, 5, 6, 7]


% =============================
% ?- mgr([1,2,3],[4,5,6],R).
%1	4	[2,3]	[4,5,6]	_4000
%2	4	[3]	[4,5,6]	_4048
%3	4	[]	[4,5,6]	_4096
%R = [1, 2, 3, 4, 5, 6]
