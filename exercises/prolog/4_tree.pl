% используя предикат quicksort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево 
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

quicksort([X|Xs],Ys) :-
  partition(Xs,X,Left,Right),
  quicksort(Left,Ls),
  quicksort(Right,Rs),
  append(Ls,[X|Rs],Ys).
quicksort([],[]).

partition([X|Xs],Y,[X|Ls],Rs) :-
  X =< Y, partition(Xs,Y,Ls,Rs).
partition([X|Xs],Y,Ls,[X|Rs]) :-
  X > Y, partition(Xs,Y,Ls,Rs).
partition([],Y,[],[]).

append([],Ys,Ys).
append([X|Xs],Ys,[X|Zs]) :- append(Xs,Ys,Zs).

divide(L, L1, L2):-divide2([_|L], L, L1, L2).
divide2([_,_|T], [A|L], [A|L1], L2):-!, divide2(T, L, L1, L2).
divide2(_, L2, [], L2).

deletelast([_|[]],[]).
deletelast([H|T1],[H|T2]):-deletelast(T1,T2).
deletelast(T1,T2):-T1=[], T2=[].

getlast(X, Y) :- X=[], Y=[].
getlast(X, Y) :- last(X,Z), Y=[Z].

getelem(L,X) :- divide(L,L1,L2), getlast(L1, R), R=X.

put(L1,L2,X,R) :- length(L1,0), length(L2,0), R=X.
put(L1,L2,X,R) :- getelem(L1,X1), getelem(L2,X2), append(X,X1,R1), append(R1,X2,R2),
divide(L1,L11,L12), deletelast(L11,L111), put(L111, L12, R2, R3),
divide(L2,L21,L22), deletelast(L21,L211), put(L211, L22, R3, R4), R=R4.

getlist(L,Y):-R=[], getelem(L,X), append(R,X,R2), divide(L,L1,L2), deletelast(L1,L11), put(L11, L2, R2, R3), Y=R3.

add(X,empty,T) :- T = instant(X,empty,empty).
add(X,instant(Root,L,R),T) :- X @< Root, T = instant(Root,L1,R), add(X,L,L1).
add(X,instant(Root,L,R),T) :- X @> Root, T = instant(Root,L,R1), add(X,R,R1).
balanced_tree(L,T) :- quicksort(L, S), getlist(S, L2), balanced_tree(L2,T,empty).
balanced_tree([],T,T0) :- T = T0.
balanced_tree([N|Ns],T,T0) :- add(N,T0,T1), balanced_tree(Ns,T,T1).

% Example
% ?- balanced_tree([15,19,2,4,9,99,100,0],T).
% T =  instant(9, instant(2, instant(0, empty, empty), instant(4, empty, empty)), instant(19, instant(15, empty, empty), instant(99, empty, instant(100, empty, empty))))  .