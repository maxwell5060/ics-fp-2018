% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

qsort(L,K):-temp_sort(L,[],K).

temp_sort([],Tmp,Tmp).

temp_sort([H|T],Tmp,K):-
    bubble(H,T,Next,Max),
    temp_sort(Next,[Max|Tmp],K).

bubble(X,[],[],X).

bubble(X,[Y|T],[Y|Next],Max):-
    X<Y,bubble(X,T,Next,Max).

bubble(X,[Y|T],[X|Next],Max):-
    X>=Y,bubble(Y,T,Next,Max).

mrg(L1,L2, R):-
    qsort(L1,R1),
    qsort(L2,R2),
    merge_lists(R1, R2, [], R).

merge_lists([],[],R,R).

merge_lists([X|T1], [Y|T2], Tmp, R):-
    X<Y, merge_lists([X|T1], T2, [Y|Tmp], R);
    %X>=Y, merge_lists(T1, [Y|T2], [X|Tmp], R).     % с повторами
    X>Y, merge_lists(T1, [Y|T2], [X|Tmp], R);       % без повторов
    X=Y, merge_lists(T1, T2, [X|Tmp], R).

merge_lists([], [Y|T], Tmp, R):-
    merge_lists([], T, [Y|Tmp], R).
    
merge_lists([X|T], [], Tmp, R):-
    merge_lists(T, [], [X|Tmp], R).