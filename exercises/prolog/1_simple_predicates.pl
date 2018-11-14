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
% указать в каком порядке и какие ответы генерируются вашими методами
	
	brother(X,Y):- father(A,X), father(A,Y), X \= Y.
	cousin(X,Y):- brother(A,B), father(A,X), father(B,Y).
	grandson(X,Y):- father(Y,A), father(A,X).
	descendent(X,Y):- father(Y,X).
	descendent(X,Y):- father(Y,A), descendent(X,A).

	:- writeln('Brothers are:\n').
	:- forall(brother(X,Y), writef('[%t - %t]\n', [X, Y])).

	:- writeln('\nCousins are:\n').
	:- forall(cousin(X,Y), writef('[%t - %t]\n', [X, Y])).

	:- writeln('\nGrandsons are:\n').
	:- forall(grandson(X,Y), writef('[%t - %t]\n', [X, Y])).

	:- writeln('\nDescendents are:\n').
	:- forall(descendent(X,Y), writef('[%t - %t]\n', [X, Y])).
	
%Brothers are:
%
%[b - c]
%[c - b]
%[d - e]
%[e - d]
%
%Cousins are:
%
%[d - f]
%[e - f]
%[f - d]
%[f - e]
%
%Grandsons are:
%
%[d - a]
%[e - a]
%[f - a]
%
%Descendents are:
%
%[b - a]
%[c - a]
%[d - b]
%[e - b]
%[f - c]
%[d - a]
%[e - a]
%[f - a]