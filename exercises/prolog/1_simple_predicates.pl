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

% This works, but doesn't print the output for ?- brother(X,Y).
% As I underestand, this is due to commit on '!' predicate.
% But prints true for ?- brother(b, c).
	% brother(X, X) :- !, false.
	% brother(X, Y) :- father(F, X), father(F, Y).
	
	brother(X, Y) :- father(F, X), father(F, Y), X \= Y.

	cousin(X, Y) :- father(Fx, X), father(Fy, Y), brother(Fx, Fy).

	grandson(X, Y) :- father(F, X), father(Y, F).

	descendent(X, Y) :- father(F, X), (F = Y; descendent(F, Y)).

% указать в каком порядке и какие ответы генерируются вашими методами
 
% ?- brother(X,Y).
% X = b,
% Y = c
% X = c,
% Y = b
% X = d,
% Y = e
% X = e,
% Y = d

% ?- cousin(X,Y).
% X = d,
% Y = f
% X = e,
% Y = f
% X = f,
% Y = d
% X = f,
% Y = e

% ?- grandson(X,Y).
% X = d,
% Y = a
% X = e,
% Y = a
% X = f,
% Y = a

% ?- descendent(X,Y).
% X = b,
% Y = a
% X = c,
% Y = a
% X = d,
% Y = b
% X = d,
% Y = a
% X = e,
% Y = b
% X = e,
% Y = a
% X = f,
% Y = c
% X = f,
% Y = a
