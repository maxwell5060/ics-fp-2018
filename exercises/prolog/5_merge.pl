$ определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

mrg([], L1, L1).
mrg(L2, [], L2).

mrg([H1|T1], [H2|T2], [H1|T3]) :- H1 < H2, mrg(T1, [H2|T2], T3), !.
mrg([H1|T1], [H2|T2], [H2|T3]) :- mrg([H1|T1], T2, T3).

% ?- mrg([43, 12, 42, 30], [21, 15, 22, 99], result).
% result = [12, 15, 21, 22, 30, 42, 43, 99].