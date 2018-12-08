% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

mrg([], L2, L2).
mrg(L1, [], L1).

mrg([Head1|Tail1], [Head2|Tail2], [Head1|Tail]) :- Head1 < Head2, mrg(Tail1, [Head2|Tail2], Tail).
mrg([Head1|Tail1], [Head2|Tail2], [Head2|Tail]) :- Head1 >= Head2, mrg([Head1|Tail1], Tail2, Tail).


% ?- mrg([1,3,5,7,9],[2,4,6,8],R).
% R = [1, 2, 3, 4, 5, 6, 7, 8, 9]