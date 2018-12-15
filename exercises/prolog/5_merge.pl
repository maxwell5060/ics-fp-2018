% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов


mrg([], [], []).
mrg(X, [], X).
mrg([], X, X).

mrg([H1|T1], [H2|T2], [H1|T3]):-
    H1 < H2,                 % If Head1 (H1) is less than Head2
                             % (H2), then we 'extract' Head1 from
                             % List1, and prepend it to ResList
    mrg(T1, [H2|T2], T3),
    !.

mrg([H1|T1], [H2|T2], [H2|T3]):-
    H1 >= H2,                % If Head2 (H2) is less than or equal to
                             % Head1 (H1), then we 'extract' Head2
                             % from List2, and prepend it to ResList
    mrg([H1|T1], T2, T3),
    !.

%% Example
%% 
%% ?- mrg([1, 5, 11, 16, 93], [2, 5, 6, 10], R).
%% R = [1, 2, 5, 5, 6, 10, 11, 16, 93].
