% есть набор фактов вида father(person1, person2) (person1 is the father of person2)
% Необходимо определить набор предикатов:
% 1. brother(X,Y)    -  определяющий являются ли аргументы братьями
% 2. cousin(X,Y)     -  определяющий являются ли аргументы двоюродными братьями
% 3. grandson(X,Y)   -  определяющий является ли аргумент Х внуком аргумента Y
% 4. descendent(X,Y) -  определяющий является ли аргумент X потомком аргумента Y
% 5. используя в качестве исходных данных следующий граф отношений
	father(a,b).  % 1                 
	father(a,c).  % 2
	father(b,d).  % 3
	father(b,e).  % 4
	father(c,f).  % 5

	brother(X,Y):- father(Z,X), father(Z,Y), X \= Y.
	cousin(X,Y):- brother(K,P), father(K,X), father(P,Y).
	grandson(X,Y):- father(Y, Z), father(Z, X).
	descendent(X,Y):- father(Y,X).
	descendent(X,Y):- father(Y,Z), descendent(X,Z).

:- write('brother(X,Y)'), nl.
:- forall(brother(X,Y), (write(X), write(' '), write(Y), nl)).

:- write('cousin(X,Y)'), nl.
:- forall(cousin(X,Y), (write(X), write(' '), write(Y), nl)).

:- write('grandson(X,Y)'), nl.
:- forall(grandson(X,Y), (write(X), write(' '), write(Y), nl)).

:- write('descendent(X,Y)'), nl.
:- forall(descendent(X,Y), (write(X), write(' '), write(Y), nl)).

:- halt.
