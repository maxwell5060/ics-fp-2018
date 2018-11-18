% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

part(_, [], [], []).
part(P, [H|T], [H|L], R) :- P > H, part(P, T, L, R).
part(P, [H|T], L, [H|R]) :- part(P, T, L, R).

qsort([], []).
qsort([H|T], S) :- part(H, T, L, R), qsort(L, SL), qsort(R, SR), append(SL, [H|SR], S).

% no nodes
balanced_tree([], empty).

% one node
balanced_tree(A, instant(H, empty, empty)) :- A = [H|[]], !.

% multiple nodes
balanced_tree([T|[H|[]]], instant(H, L, empty)) :- T < H,
    balanced_tree([T], L), !.
balanced_tree([H|[T|[]]], instant(H, L, empty)) :-
    balanced_tree([T], L), !.

balanced_tree(A, instant(M, L, R)) :-
    qsort(A, S),
    append(AL, [M|AR], S),
    length(AL, LL),
    length([M|AR], RL),
    (LL =:= RL; LL =:= (RL - 1)),
    balanced_tree(AL, L),
    balanced_tree(AR, R), !.

:-
write("balanced_tree([0,9,1,8,2,7,5], T): "),
balanced_tree([0,9,1,8,2,7,5], T),
writeln(T),
writeln("").

% balanced_tree([0,9,1,8,2,7,5], T):
% instant(5,instant(1,instant(0,empty,empty),instant(2,empty,empty)),
%     instant(8,instant(7,empty,empty),instant(9,empty,empty)))

/*
        5
       / \
      1   8
     /\   /\
    0 2   7 9
*/
