:- consult('code.pl').

% ==========================================
% 1. seg/3
% ==========================================
:- begin_tests(segments_exhaustive).
test(seg_1, [true]) :- seg(1, point(1, 11), point(14, 11)).
test(seg_2, [true]) :- seg(2, point(2, 4), point(13, 4)).
test(seg_3, [true]) :- seg(3, point(2, 2), point(9, 2)).
test(seg_4, [true]) :- seg(4, point(3, 1), point(3, 10)).
test(seg_5, [true]) :- seg(5, point(7, 10), point(13, 10)).
test(seg_6, [true]) :- seg(6, point(8, 0), point(8, 13)).
test(seg_7, [true]) :- seg(7, point(10, 3), point(10, 12)).
test(seg_8, [true]) :- seg(8, point(11, 3), point(11, 13)).
test(seg_9, [true]) :- seg(9, point(12, 2), point(12, 12)).
test(seg_10, [fail]) :- seg(10, _, _).
:- end_tests(segments_exhaustive).

% ==========================================
% 2. horiz/1 и vertical/1
% ==========================================
:- begin_tests(orientation_exhaustive).
test(horiz_1, [true]) :- horiz(1).
test(horiz_2, [true]) :- horiz(2).
test(horiz_3, [true]) :- horiz(3).
test(horiz_5, [true]) :- horiz(5).
test(horiz_4, [fail]) :- horiz(4).
test(horiz_6, [fail]) :- horiz(6).
test(horiz_7, [fail]) :- horiz(7).
test(horiz_8, [fail]) :- horiz(8).
test(horiz_9, [fail]) :- horiz(9).

test(vertical_4, [true]) :- vertical(4).
test(vertical_6, [true]) :- vertical(6).
test(vertical_7, [true]) :- vertical(7).
test(vertical_8, [true]) :- vertical(8).
test(vertical_9, [true]) :- vertical(9).
test(vertical_1, [fail]) :- vertical(1).
test(vertical_2, [fail]) :- vertical(2).
test(vertical_3, [fail]) :- vertical(3).
test(vertical_5, [fail]) :- vertical(5).
:- end_tests(orientation_exhaustive).

% ==========================================
% 3. cross/5 — ВАЖНО: ограничения идут отдельными опциями
% ==========================================
:- begin_tests(cross_exhaustive).

test(cross_1_6, [X == 8,  Y == 11, NL == 13, ML == 13]) :- cross(1, 6, point(X, Y), NL, ML), !.
test(cross_1_7, [X == 10, Y == 11, NL == 13, ML == 9])  :- cross(1, 7, point(X, Y), NL, ML), !.
test(cross_1_8, [X == 11, Y == 11, NL == 13, ML == 10]) :- cross(1, 8, point(X, Y), NL, ML), !.
test(cross_1_9, [X == 12, Y == 11, NL == 13, ML == 10]) :- cross(1, 9, point(X, Y), NL, ML), !.

test(cross_2_4, [X == 3,  Y == 4,  NL == 11, ML == 9])  :- cross(2, 4, point(X, Y), NL, ML), !.
test(cross_2_6, [X == 8,  Y == 4,  NL == 11, ML == 13]) :- cross(2, 6, point(X, Y), NL, ML), !.
test(cross_2_7, [X == 10, Y == 4,  NL == 11, ML == 9])  :- cross(2, 7, point(X, Y), NL, ML), !.
test(cross_2_8, [X == 11, Y == 4,  NL == 11, ML == 10]) :- cross(2, 8, point(X, Y), NL, ML), !.
test(cross_2_9, [X == 12, Y == 4,  NL == 11, ML == 10]) :- cross(2, 9, point(X, Y), NL, ML), !.

test(cross_3_4, [X == 3,  Y == 2,  NL == 7,  ML == 9])  :- cross(3, 4, point(X, Y), NL, ML), !.
test(cross_3_6, [X == 8,  Y == 2,  NL == 7,  ML == 13]) :- cross(3, 6, point(X, Y), NL, ML), !.

test(cross_5_6, [X == 8,  Y == 10, NL == 6,  ML == 13]) :- cross(5, 6, point(X, Y), NL, ML), !.
test(cross_5_7, [X == 10, Y == 10, NL == 6,  ML == 9])  :- cross(5, 7, point(X, Y), NL, ML), !.
test(cross_5_8, [X == 11, Y == 10, NL == 6,  ML == 10]) :- cross(5, 8, point(X, Y), NL, ML), !.
test(cross_5_9, [X == 12, Y == 10, NL == 6,  ML == 10]) :- cross(5, 9, point(X, Y), NL, ML), !.

% Симметрия
test(cross_sym_6_1, [X == 8,  Y == 11, NL == 13, ML == 13]) :- cross(6, 1, point(X, Y), NL, ML), !.
test(cross_sym_7_1, [X == 10, Y == 11, NL == 9,  ML == 13]) :- cross(7, 1, point(X, Y), NL, ML), !.
test(cross_sym_4_2, [X == 3,  Y == 4,  NL == 9,  ML == 11]) :- cross(4, 2, point(X, Y), NL, ML), !.

% Негативные
test(cross_1_4_fail, [fail]) :- cross(1, 4, _, _, _), !.
test(cross_3_7_fail, [fail]) :- cross(3, 7, _, _, _), !.
test(cross_5_4_fail, [fail]) :- cross(5, 4, _, _, _), !.
test(cross_1_2_fail, [fail]) :- cross(1, 2, _, _, _), !.
test(cross_6_7_fail, [fail]) :- cross(6, 7, _, _, _), !.
:- end_tests(cross_exhaustive).

% ==========================================
% 4. per_sq/6 — порядок аргументов: (V, H, V, H)
% ==========================================
:- begin_tests(per_sq_exhaustive).

test(per_sq_6_1_7_2, [P == 18, S == 14]) :- per_sq(6, 1, 7, 2, P, S), !.
test(per_sq_6_2_7_1, [P == 18, S == 14]) :- per_sq(6, 2, 7, 1, P, S), !.

test(per_sq_6_1_7_5, [P == 6,  S == 2])  :- per_sq(6, 1, 7, 5, P, S), !.
test(per_sq_6_5_7_1, [P == 6,  S == 2])  :- per_sq(6, 5, 7, 1, P, S), !.

test(per_sq_7_1_8_2, [P == 16, S == 7])  :- per_sq(7, 1, 8, 2, P, S), !.
test(per_sq_8_1_9_2, [P == 16, S == 7])  :- per_sq(8, 1, 9, 2, P, S), !.

test(per_sq_4_2_6_3, [P == 14, S == 10]) :- per_sq(4, 2, 6, 3, P, S), !.

test(per_sq_6_5_7_2, [P == 16, S == 12]) :- per_sq(6, 5, 7, 2, P, S), !.

test(per_sq_6_1_9_5, [P == 10, S == 4])  :- per_sq(6, 1, 9, 5, P, S), !.

% ---- Негативные ----

% Неправильный порядок аргументов (H, V, H, V вместо V, H, V, H):
% cross(6,2) = (8,4) ≠ point(X2,Y1) = (10,11) → fail
test(per_sq_wrong_order, [fail]) :- per_sq(1, 6, 2, 7, _, _), !.

% Нет пересечения V4 ∩ H1: V4 x=3,y∈[1,10]; H1 y=11 → y=11 ∉ [1,10]
test(per_sq_no_cross_v4_h1, [fail]) :- per_sq(4, 1, 7, 2, _, _), !.

% Нет пересечения V7 ∩ H3: V7 x=10,y∈[3,12]; H3 y=2,x∈[2,9] → x=10 ∉ [2,9]
test(per_sq_no_cross_v7_h3, [fail]) :- per_sq(6, 1, 7, 3, _, _), !.

% Повторяющийся отрезок (A=C) → A \= C не выполняется
test(per_sq_repeated, [fail]) :- per_sq(6, 1, 6, 2, _, _), !.

% Неверные P/S
test(per_sq_wrong_vals_1, [fail]) :- per_sq(6, 1, 7, 2, 0, 0), !.
test(per_sq_wrong_vals_2, [fail]) :- per_sq(6, 1, 7, 2, 18, 15), !.

:- end_tests(per_sq_exhaustive).