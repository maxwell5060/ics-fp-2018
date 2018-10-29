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

brother(X,Y) :-
    father(Z,X),
    father(Z,Y),
    X \= Y.

    % X=b, Y=c; X=c, Y=b; X=d, Y=e; X=e, Y=d.

cousin(X,Y) :-
    brother(V,W),
    V \= W,
    father(V,X),
    father(W,Y),
    X \= Y.

    % X=d, Y=f; X=e, Y=f; X=f, Y=d; X=f, Y=e.

grandson(X,Y) :-
    father(Z,X),
    father(Y,Z).

    % X=d, Y=a; X=e, Y=a; X=f, Y=a.

descendent(X,Y):- father(X,Y).
descendent(X,Y) :-
    father(X,Z),
    descendent(Z,Y).

    % X=a, Y=b; X=a, Y=c; X=b, Y=d; X=b, Y=e; X=c, Y=f; X=a, Y=d; X=a, Y=e; X=a, Y=f.

