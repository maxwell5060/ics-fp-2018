merge([], Elem, Elem).

merge(Elem, [], Elem).

merge([H1|T1], [H2|T2], [H1|T3]) :- 
    H1 < H2, merge(T1, [H2|T2], T3), !.

merge([H1|T1], [H2|T2], [H2|T3]) :- 
    merge([H1|T1], T2, T3).

% ?- merge([0, 2, 4, 5, 6],[1, 2, 3, 15], K).
% K = [0, 1, 2, 2, 3, 4, 5, 6, 15].

