%определить предикат mrg(L1, L2, R) который для двух отсортированных
% списков L1 и L2 определяет список R, составленный из этих элементов

merge([], List, List).

merge(List, [], List).

merge([], [], []).

merge([Head1|Tail1], [Head2|Tail2], [Head1|TailRes]) :-
    Head1 < Head2, merge(Tail1, [Head2|Tail2], TailRes), !.

merge([Head1|Tail1], [Head2|Tail2], [Head2|TailRes]) :-
    merge([Head1|Tail1], Tail2, TailRes).
