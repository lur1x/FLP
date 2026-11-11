% Task 1
seg(1, point(1, 11), point(14, 11)).
seg(2, point(2, 4), point(13, 4)).
seg(3, point(2, 2), point(9, 2)).
seg(4, point(3, 1), point(3, 10)).
seg(5, point(7, 10), point(13, 10)).
seg(6, point(8, 0), point(8, 13)).
seg(7, point(10, 3), point(10, 12)).
seg(8, point(11, 3), point(11, 13)).
seg(9, point(12, 2), point(12, 12)).

horiz(N) :- seg(N, point(_, Y), point(_, Y)).
vertical(N) :- seg(N, point(X, _), point(X, _)).

% Task 2
cross(N, M, point(X, Y), NL, ML) :-
    % Я гений 
    (
        % N - horizontal, M - vertical
        horiz(N), vertical(M),
        seg(N, point(X1, Y), point(X2, Y)),
        seg(M, point(X, Y1), point(X, Y2)),
        X1 =< X, X =< X2, Y1 =< Y, Y =< Y2,
        NL is abs(X2 - X1),
        ML is abs(Y2 - Y1)
    ;
        % M - horizontal, N - vertical
        horiz(M), vertical(N), 
        seg(N, point(X, Y1), point(X, Y2)),
        seg(M, point(X1, Y), point(X2, Y)),
        X1 =< X, X =< X2, Y1 =< Y, Y =< Y2,
        NL is abs(Y2 - Y1),
        ML is abs(X2 - X1)
    ).
% Task 3
per_sq(A, B, C, D, P, S) :-
    cross(A, B, point(X1, Y1), _, _),
    cross(C, D, point(X2, Y2), _, _),
    cross(B, C, point(X2, Y1), _, _),
    cross(A, D, point(X1, Y2), _, _),
    A \= B, A \= C, A \= D,
    B \= C, B \= D,
    C \= D,
    P is 2 * (abs(X2 - X1) + abs(Y2 - Y1)),
    S is abs(X2 - X1) * abs(Y2 - Y1).