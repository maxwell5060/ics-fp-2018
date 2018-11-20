% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)
qsort(L, K):- q_sort(L, K).

q_sort([],[]).
q_sort([Head|Tail], Sorted):-
    partion(Head, Tail, Less, More),
    q_sort(Less, SortedLess),
    q_sort(More, SortedMore),
    append(SortedLess, [Head|SortedMore], Sorted).

partion(Head, [], [], []).
partion(Head, [E|Tail], [E|Less], More):-
    E=<Head, partion(Head, Tail, Less, More).
partion(Head, [E|Tail], Less, [E|More]):-
    E>Head, partion(Head, Tail, Less, More).

split_on_center(List, Less, More) :-
    append(Less, More, List),
    length(Less, LessLength),
    length(More, MoreLength),
    (LessLength =:= MoreLength; LessLength =:= (MoreLength - 1)), !.

balanced_tree([], empty).

balanced_tree(List, instant(Head, empty, empty)) :-
    List = [Head|[]], !.

balanced_tree([Head|[Tail|[]]], instant(Tail, LessChild, empty)) :-
    Head < Tail,
    balanced_tree([Tail], LessChild), !.

balanced_tree([Head|[Tail|[]]], instant(Head, LessChild, empty)) :-
    balanced_tree([Tail], LessChild), !.

balanced_tree(List, instant(Mid, LessChild, MoreChild)) :-
    qsort(List, Sorted),
    split_on_center(Sorted, LessList, [Mid|MoreList]),
    balanced_tree(LessList, LessChild),
    balanced_tree(MoreList, MoreChild), !.



