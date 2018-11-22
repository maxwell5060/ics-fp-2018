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

% правила родословной
brother(X,Y) :- father(Z,X), father(Z,Y), X \= Y.
cousin(X,Y) :- father(Z,X), father(W,Y), brother(Z,W).
grandson(X,Y) :- father(Y,W), father(W,X).
descendent(X,Y) :- father(Y,X).
descendent(X,Y) :- father(Y,W), descendent(X,W).
	
% настала пора узнать, кто есть кто!
:- writeln('Bros:').
:- forall(brother(X,Y), (write(X), write(' and '), write(Y), nl)).
:- writeln('Cousins:').
:- forall(cousin(X,Y), (write(X), write(' and '), write(Y), nl)).
:- writeln('Grandsons:').
:- forall(grandson(X,Y), (write(X), write(' to '), write(Y), nl)).
:- writeln('Descendents:').
:- forall(descendent(X,Y), (write(X), write(' of '), write(Y), nl)).

% ответы таковы
/*
Bros:
b and c
c and b
d and e
e and d
Cousins:
d and f
e and f
f and d
f and e
Grandsons:
d to a
e to a
f to a
Descendents:
b of a
c of a
d of b
e of b
f of c
d of a
e of a
f of a
*/