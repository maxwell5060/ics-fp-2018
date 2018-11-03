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

brother(X,Y) :- father(Z,X), father(Z,Y), X \= Y, X @< Y.

cousine(X,Y) :- father(Z1,X), father(Z2,Y), father(Z3,Z2), father(Z3,Z1), Z2 \= Z1, X \= Y, X @< Y.

grandson(X,Y) :- father(Y,Z), father(Z,X).

descendent(X,Y) :- father(Y,X).

descendent(X,Y) :- father(Y,Z), descendent(X,Z).

printVars(X,Y,Z):- write(X), write(Y), write(Z), nl.
% указать в каком порядке и какие ответы генерируются вашими методами
?- write("Print all brothers:"), nl.
?- forall(brother(X,Y), printVars(X," is a brother of ",Y)).
?- write("Print all cousins:"), nl.
?- forall(cousine(X,Y), printVars(X," is a cousine of ",Y)).
?- write("Print all grandsons:"), nl.
?- forall(grandson(X,Y), printVars(X," is a grandson of ",Y)).
?- write("Print all descendents:"), nl.
?- forall(descendent(X,Y), printVars(X," is a descendent of ",Y)).

/*

Output:

Print all brothers:
b is a brother of c
d is a brother of e
Print all cousins:
d is a cousine of f
e is a cousine of f
Print all grandsons:
d is a grandson of a
e is a grandson of a
f is a grandson of a
Print all descendents:
b is a descendent of a
c is a descendent of a
d is a descendent of b
e is a descendent of b
f is a descendent of c
d is a descendent of a
e is a descendent of a
f is a descendent of a

*/

