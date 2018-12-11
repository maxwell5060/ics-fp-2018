% определить предикат mrg(L1, L2, R) который для двух отсортированных списков L1 и L2
% определяет список R, составленный из этих элементов

    :- use_module(library(clpfd)).

    mrg([], Ys, Ys).
    mrg([X|Xs], Ys, Zs) :- h1_t1_mrg(Ys, X, Xs, Zs).

    h1_t1_h2_t2_mrg(X, Xs, Y, Ys, Zs) :- zcompare(Op, X, Y), op_mrg(Op, X, Xs, Y, Ys, Zs).

    h2_t2_mrg([], Y, Ys, [Y|Ys]).
    h2_t2_mrg([X|Xs], Y, Ys, Zs) :- h1_t1_h2_t2_mrg(X, Xs, Y, Ys, Zs).

    h1_t1_mrg([], X, Xs, [X|Xs]).
    h1_t1_mrg([Y|Ys], X, Xs, Zs) :- h1_t1_h2_t2_mrg(X, Xs, Y, Ys, Zs).

    op_mrg(<, X, Xs, Y, Ys, [X|Zs]) :- h2_t2_mrg(Xs, Y, Ys, Zs).
    op_mrg(=, X, Xs, Y, Ys, [X|Zs]) :- h2_t2_mrg(Xs, Y, Ys, Zs).
    op_mrg(>, X, Xs, Y, Ys, [Y|Zs]) :- h2_t2_mrg(Ys, X, Xs, Zs).
