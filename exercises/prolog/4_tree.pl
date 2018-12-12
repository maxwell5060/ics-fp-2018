% используя предикат qsort(L,K) из предыдущего задания разработать предикат:
% balanced_tree(L,T) - который по заданном списку строит сбалансированное бинарное дерево поиска
% для построения дерева использовать следующие  нотации:
% empty - пустое дерево
% instant(R, L, R) - бинарное дерево с корнем R и двумя поддеревьями L и R соотвественно (левое и правое)

splitHelper([H | T], 0, Left, Left, H, T).
splitHelper([H | T], Ind, CurLeft, Left, Mid, Right) :-
  NewInd is Ind - 1,
  append(CurLeft, [H | []], NewLeft),
  splitHelper(T, NewInd, NewLeft, Left, Mid, Right).
splitByInd(List, Ind, Left, Mid, Right) :-
  splitHelper(List, Ind, [], Left, Mid, Right).

buildTree([], empty).
buildTree(List, Tree) :-
  length(List, Len),
  (Ind is Len / 2; Ind is (Len - 1) / 2),
  splitByInd(List, Ind, Left, Root, Right),
  tree(Left, LeftChild),
  tree(Right, RightChild),
  Tree = instant(Root, LeftChild, RightChild).

tree(List, Tree) :-
  qsort(List, Sorted),
  buildTree(Sorted, Tree).


% ?- tree([5,4,6,7,2,3,1,9,8,0], R).
% R = instant(5, instant(2, instant(1, instant(0, empty, empty), empty), instant(4, instant(3, empty, empty), empty)), instant(8, instant(7, instant(6, empty, empty), empty), instant(9, empty, empty))) .
%
% formatted:
%                     5
%               2           8
%            1     4     7     9
%           0 _   3 _   6 _   _ _
%          _ _   _ _   _ _
%
% ?- tree([3,4,2,0,1,9,6,5,7,8,14,10,11,13,12], R).
% R = instant(7, instant(3, instant(1, instant(0, empty, empty), instant(2, empty, empty)), instant(5, instant(4, empty, empty), instant(6, empty, empty))), instant(11, instant(9, instant(8, empty, empty), instant(10, empty, empty)), instant(13, instant(12, empty, empty), instant(14, empty, empty))))
%
% formatted:
%                      7
%              3               11
%         1        5       9        13
%      0     2   4   6   8   10  12    14
%     _ _   _ _ _ _ _ _ _ _ _ _ _  _  _  _
