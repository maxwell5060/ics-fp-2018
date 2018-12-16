% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

mrg([X|Xs], [Y|Ys], [X|Zs]) :- X<Y, mrg(Xs, [Y|Ys], Zs).
mrg([X|Xs], [Y|Ys], [X,X|Zs]) :- X=Y, mrg(Xs,Ys,Zs).
mrg([X|Xs], [Y|Ys], [Y|Zs]) :- X>Y, mrg([X|Xs],Ys,Zs).
mrg([], [X|Xs], [X|Xs]).
mrg(Xs, [], Xs).
