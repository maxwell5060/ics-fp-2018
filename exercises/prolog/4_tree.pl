% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

% сортировка входного списка для определения позиций.

qsort(L, K):- q_sort(L, K).

q_sort([],[]).
q_sort([Lh|Lt], K):-
    pivot(Lh, Lt, Left, Right),
    q_sort(Left, Ll),
    q_sort(Right, Lr),
    append(Ll, [Lh|Lr], K).

pivot(_, [], [], []).
pivot(Lh, [H|Lt], [H|Left], Right):-
    H=<Lh, pivot(Lh, Lt, Left, Right).
pivot(Lh, [H|Lt], Left, [H|Right]):-
    H>Lh, pivot(Lh, Lt, Left, Right).

% удаление отобранных корней дерева из отсортированного списка

remove_list([], _, []).
remove_list([X|T], L, Result):- 
    member(X, L), !, 
    remove_list(T, L, Result). 
remove_list([X|T], L, [X|Result]):- 
    remove_list(T, L, Result).

% упорядочение вершин и листьев, позволяющее создать идеально сбалансированное дерево

get_order([], _, T, _, T).
get_order(L, _, [], _, T0):-                                % для первого корня
    length(L, Size),
    ind_var(Size, Ind0),
    Ind is div(Ind0, 2),
    nth1(Ind, L, Key),
    ind_var_counter(Ind, Count),
    get_order(L, Ind, [Key], Count, T0).

get_order(L, Ind0, T, Count, T0):-
    ind_var(Ind0, Ind1),
    Ind is div(Ind1, 2),
    nth1(Ind, L, Key), 
    Diff is (Ind0 - Ind)*2,  
    Diff > 2 ->  
    insert(L, Ind, Diff, Count, Count, 1, T, T1),
    get_order(L, Ind, [Key|T1], Count, T0),true;  
    reverse(T, Tr),
    remove_list(L, Tr, T1), 
    append(Tr,T1,T2),
    get_order([],_,T2,_,T0).

% расчет значений для счетчика вычисления вершин

ind_var(Ind0, Ind1):-
    1 is mod(Ind0,2) -> Ind1 is Ind0+1;
    0 is mod(Ind0,2) -> Ind1 is Ind0.
    
ind_var_counter(Ind0, Ind1):-
    1 is mod(Ind0,2) -> Ind1 is Ind0-1;
    0 is mod(Ind0,2) -> Ind1 is Ind0.

% получение значений вершин, находящихся на одной глубине с найденной на последней итерации

insert([], _, _, _, _, _, T, T):- !.
insert(L, Start, Step, Count, _, _, T, T1):-                % для первого корня
    Step = Count -> 
    Start1 is Start+Step,
    nth1(Start1, L, Key),
    insert([], Start1, Step, Count, Count, 0, [Key|T],T1), !.

insert(L, Start, Step, Count, Count_cur, Run, T, T1):-      % проход от центра до края
    Run = 2 ->
    Count_cur \= Count,
    Count_cur1 is Count_cur + Step,
    Start1 is Start+Step,
    nth1(Start1, L, Key),
    insert(L, Start1, Step, Count, Count_cur1, Run, [Key|T], T1).

insert(L, Start, Step, Count, Count_cur, Run, T, T1):-
    Run = 2 ->
    Count_cur = Count,
    insert([], Start1, Step, Count, Count_cur1, Run, T, T1).

insert(L, Start, Step, Count, Count_cur, Run, T, T1):-      % проход от начала до центра
    Count_cur = 0 -> insert(L, Start, Step, Count, 0, 2, T, T1),true;
    Count_cur < Step ->
    Start1 is (Start+Count_cur),
    nth1(Start1, L, Key),
    insert(L, Start1, Step, Count, Count_cur, 2, [Key|T], T1);
    Count_cur1 is Count_cur - Step,
    Start1 is Start+Step,
    nth1(Start1, L, Key),
    insert(L, Start1, Step, Count, Count_cur1, Run, [Key|T],T1), !.

put(X,empty,instant(X,empty,empty)).
put(X,instant(Root,L,R),instant(Root,L1,R)) :- 
    X < Root -> put(X,L,L1).
put(X,instant(Root,L,R),instant(Root,L,R1)) :- 
    X > Root -> put(X,R,R1).

construct(L,T) :- 
    qsort(L,L1),
    get_order(L,_,_,_, T0),
    construct(T0,T,empty).

construct([],T,T).
construct([N|Ns],T,T0) :- 
    put(N,T0,T1), 
    construct(Ns,T,T1).