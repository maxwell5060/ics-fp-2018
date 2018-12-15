	father(a,b).  % 1                 
	father(a,c).  % 2
	father(b,d).  % 3
	father(b,e).  % 4
	father(c,f).  % 5

	brother(X,Y) :- father(Z,Y), father(Z,X), not(X=Y).
	cousin(X,Y) :- father(Z,X), father(w,Y), brother(Z,W).
	grandson(X,Y) :- father(Y,Z), father(Z,X).
	descendent(X,Y) :- father(Y,X); father(Y,Z), descendent(X,Z).
 
	:- writeln('Brothers:').
	:-forall(brother(X,Y), (write(X), write(' '), writeln(Y))).
	:- writeln('Cousins:').
	:-forall(cousin(X,Y), (write(X), write(' '), writeln(Y))).
	:- writeln('Grandsons:').
	:-forall(grandson(X,Y), (write(X), write(' '), writeln(Y))).
	:- writeln('Descendents:').
	:-forall(descendent(X,Y), (write(X), write(' '), writeln(Y))).

% указать в каком порядке и какие ответы генерируются вашими методами
%?- Brothers:
%b c
%c b
%d e
%e d
%Cousins:
%d f
%e f
%f d
%f e
%Grandsons:
%d a
%e a
%f a
%Descendents:
%b a
%c a
%d b
%e b
%f c
%d a
%e a
%f a 