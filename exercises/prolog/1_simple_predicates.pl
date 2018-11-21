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
	?- brother(X,Y).
	?- cousin(X,Y).
	?- grandson(X,Y).
	?- descendent(X,Y).
	
brother(PERSON1,PERSON2) :- father(FATHER,PERSON1), father(FATHER,PERSON2), PERSON1 \= PERSON2.
cousin(PERSON1,PERSON2) :- father(FATHER1,PERSON1), father(FATHER2,PERSON2), brother(FATHER1,FATHER2), PERSON1 \= PERSON2.
grandson(PERSON1,PERSON2) :- father(FATHER1,PERSON1), father(PERSON2,FATHER1), PERSON1 \= PERSON2.
descendent(PERSON1,PERSON2) :- father(PERSON2,PERSON1), PERSON1 \= PERSON2.
descendent(PERSON1,PERSON2) :- father(PERSON2,CHILD2), descendent(PERSON1,CHILD2), PERSON1 \= PERSON2.

?- brother(PERSON1,PERSON2).
PERSON1 = b,
PERSON2 = c ;
PERSON1 = c,
PERSON2 = b ;
PERSON1 = d,
PERSON2 = e ;
PERSON1 = e,
PERSON2 = d ;
false.

?- cousin(PERSON1,PERSON2).
PERSON1 = d,
PERSON2 = f ;
PERSON1 = e,
PERSON2 = f ;
PERSON1 = f,
PERSON2 = d ;
PERSON1 = f,
PERSON2 = e ;
false.

?- grandson(PERSON1,PERSON2).
PERSON1 = d,
PERSON2 = a ;
PERSON1 = e,
PERSON2 = a ;
PERSON1 = f,
PERSON2 = a.

?- descendent(PERSON1,PERSON2).
PERSON1 = b,
PERSON2 = a ;
PERSON1 = c,
PERSON2 = a ;
PERSON1 = d,
PERSON2 = b ;
PERSON1 = e,
PERSON2 = b ;
PERSON1 = f,
PERSON2 = c ;
PERSON1 = d,
PERSON2 = a ;
PERSON1 = e,
PERSON2 = a ;
PERSON1 = f,
PERSON2 = a ;
false.