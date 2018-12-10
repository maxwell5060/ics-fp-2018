% есть набор фактов вида father(person1, person2) (person1 is the father of person2)
% Необходимо определить набор предикатов:
    father(a,b).  % 1
    father(a,c).  % 2
    father(b,d).  % 3
    father(b,e).  % 4
    father(c,f).  % 5
% указать в каком порядке и какие ответы генерируются вашими методами
%	?- brother(X,Y).
%	?- cousin(X,Y).
%	?- grandson(X,Y).
%	?- descendent(X,Y).
% 1. brother(X,Y)    -  определяющий являются ли аргументы братьями
    brother(X,Y):-father(Z,X),father(Z,Y),X\=Y.
% 2. cousin(X,Y)     -  определяющий являются ли аргументы двоюродными братьями
    cousin(X,Y):-father(Z,X),father(C,Y),brother(Z,C).
% 3. grandson(X,Y)   -  определяющий является ли аргумент Х внуком аргумента Y
    grandson(X,Y):-father(V,X),father(Y,V).
% 4. descendent(X,Y) -  определяющий является ли аргумент X потомком аргумента Y
    descendent(X,Y):-father(Y,X).
    descendent(X,Y):-father(Z,X),descendent(Z,Y).
