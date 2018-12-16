% есть набор фактов вида father(person1, person2) (person1 is the father of person2)
% Необходимо определить набор предикатов:
% 1. brother(X,Y)    -  определяющий являются ли аргументы братьями
% 2. cousin(X,Y)     -  определяющий являются ли аргументы двоюродными братьями
% 3. grandson(X,Y)   -  определяющий является ли аргумент Х внуком аргумента Y
% 4. descendent(X,Y) -  определяющий является ли аргумент X потомком аргумента Y
% 5. используя в качестве исходных данных следующий граф отношений
	% father(a,b).  % 1
	% father(a,c).  % 2
	% father(b,d).  % 3
	% father(b,e).  % 4
	% father(c,f).  % 5
% указать в каком порядке и какие ответы генерируются вашими методами
	% ?- brother(X,Y).
	% ?- cousin(X,Y).
	% ?- grandson(X,Y).
	% ?- descendent(X,Y).
father(a,b).  % 1
father(a,c).  % 2
father(b,d).  % 3
father(b,e).  % 4
father(c,f).  % 5
father(d,i).  % 6
male(a).
male(b).
male(c).
male(d).
brother(X,Y):- male(X), father(Z,X), father(Z,Y).
cousin(X,Y):- father(Z, X), father(Q, Y), brother(Z, Q).
grandson(X,Y):- male(X), father(Z,X), father(Y, Z).
descendent(X,Y):- father(Y,X).
descendent(X,Y):- father(Z,X), descendent(Z,Y).