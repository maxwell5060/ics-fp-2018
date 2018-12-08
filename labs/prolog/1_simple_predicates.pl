 father(a,b).  % 1                 
	father(a,c).  % 2
	father(b,d).  % 3
	father(b,e).  % 4
	father(c,f).  % 5
brother(X,Y):- father(Z,X),father(Z,Y), not(X=Y).
grandson(X,Y):- father(Y,Z), father(Z,X).
cousin(X,Y):- father(Z,X), father(C,Y),brother(Z,C), not(X=Y).
descendent(X,Y):- father(Y,X);father(Y,Z),descendent(X,Z).
:- writeln('all brothers:').
	:-forall(brother(X,Y), (write(X), write(' '), writeln(Y))).
	:- writeln('all grondsons:').
	:-forall(grandson(X,Y), (write(X), write(' '), writeln(Y))).
        :- writeln('all cousins:').
	:-forall(cousin(X,Y), (write(X), write(' '), writeln(Y))).
	:- writeln('all descendents:').
	:-forall(descendent(X,Y), (write(X), write(' '), writeln(Y))).
% указать в каком порядке и какие ответы генерируются вашими методами
%?- all brothers:
%b c
%c b
%d e
%e d
%all grondsons:
%d a
%e a
%f a
%all cousins:
%d f
%e f
%f d
%f e
%all descendents:
%b a
%c a
%d b
%e b
%f c
%d a
%e a
%f a 