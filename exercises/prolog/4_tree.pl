% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)


% разделяем список надвое, проверяя длину половин (допустима разница в 1)
division(List, LeftC, RightC) :-
    append(LeftC, RightC, List),
    length(LeftC, LeftL),
    length(RightC, RightL),
    (LeftL =:= RightL; LeftL =:= (RightL - 1)).

% для пустого дерева - empty	
balanced_tree_c([], empty).

% для списка из одного элемента
balanced_tree_c(ListAlone, instant(H, empty, empty)) :-
    ListAlone = [H|[]].

% для списка из двух элементов
balanced_tree_c([VS|[VB|[]]], instant(VS, empty, RightC)) :-
    VS < VB,
    balanced_tree_c([VB], RightC).
balanced_tree_c([VB|[VS|[]]], instant(VB, LeftC, empty)) :-
    balanced_tree_c([VS], LeftC).

% для общего случая (l > 2)
balanced_tree_c(ListCustom, instant(Root, LeftC, RightC)) :-
    qsort(ListCustom, ListSorted),
    division(ListSorted, LeftL, [Root|RightL]),
    balanced_tree(LeftL, LeftC),
    balanced_tree(RightL, RightC).

% исходный предикат
balanced_tree(L, T) :- balanced_tree_c(L, T).


/*

?- balanced_tree([],T).
T = empty .

?- balanced_tree([2],T).
T = instant(2, empty, empty) .

?- balanced_tree([2,4],T).
T = instant(2, empty, instant(4, empty, empty)) .

?- balanced_tree([4,2],T).
T = instant(4, instant(2, empty, empty), empty) .

balanced_tree([0,-5,10,8],T).
T = instant(8, instant(-5, empty, instant(0, empty, empty)), instant(10, empty, empty)) .

*/