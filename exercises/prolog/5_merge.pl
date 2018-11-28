% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2 
% определяет список R, составленный из этих элементов

mrg([], L2, L2).

mrg(L1, [], L1).

mrg([LHead|LTail], [RHead|RTail], Result) :- 
    LHead < RHead -> mrg(LTail, [RHead|RTail], SubResult), Result = [LHead|SubResult];
	mrg([LHead|LTail], RTail, SubResult), Result = [RHead|SubResult].
	
% ?- mrg([1, 3, 5, 7],[-10, 2, 2, 4, 6], R).
% R = [-10, 1, 2, 2, 3, 4, 5, 6, 7] .