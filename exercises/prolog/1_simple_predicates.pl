father(a,b).                   
father(a,c).  
father(b,d).  
father(b,e).  
father(c,f).

brother(X,Y) :- 
	father(F, X),
	father(F, Y),
	X \= Y.

% X=b, Y=c; 
% X=c, Y=b; 
% X=d, Y=e; 
% X=e, Y=d.

cousin(X, Y) :-
	father(F1, X),
	father(F2, Y),
	brother(F1,F2).
% X=d, Y=f; 
% X=e, Y=f; 
% X=f, Y=d; 
% X=f, Y=e.
	
grandson(X, Y) :-
	father(Y, F),
	father(F,X).

% X=d, Y=a; 
% X=e, Y=a; 
% X=f, Y=a.


descendent(X,Y) :- father(Y,X).          
 
descendent(X,Y) :- father(Z, X),          
                descendent(Z,Y).
% X=b, Y=a; 
% X=c, Y=a; 
% X=d, Y=b; 
% X=e, Y=b; 
% X=f, Y=c; 
% X=d, Y=a; 
% X=e, Y=a; 
% X=f, Y=a.
	


