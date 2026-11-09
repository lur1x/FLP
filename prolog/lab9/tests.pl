:- consult('code.pl').

:- begin_tests(family_tree_exhaustive).

% ==========================================
% 1. son/1 (Сын)
% Проверяем всех мужчин, у которых есть родители
% ==========================================
test(son_joe, [true]) :- son(joe), !.
test(son_jim, [true]) :- son(jim), !.
test(son_bob, [true]) :- son(bob), !.
% Негативные (у них нет родителей в базе или они женщины)
test(son_bill, [fail]) :- son(bill), !.
test(son_paul, [fail]) :- son(paul), !.
test(son_ann, [fail]) :- son(ann), !.
test(son_tammy, [fail]) :- son(tammy), !.
test(son_sue, [fail]) :- son(sue), !.
test(son_mary, [fail]) :- son(mary), !.

% ==========================================
% 2. grandma/2 (Бабушка)
% ==========================================
test(grandma_sue_bob, [true]) :- grandma(sue, bob), !.
test(grandma_mary_bob, [true]) :- grandma(mary, bob), !.
test(grandma_sue_tammy, [true]) :- grandma(sue, tammy), !.
% Негативные (мамы, дедушки, чужие)
test(grandma_ann_bob, [fail]) :- grandma(ann, bob), !.
test(grandma_bill_joe, [fail]) :- grandma(bill, joe), !.
test(grandma_paul_bob, [fail]) :- grandma(paul, bob), !.
test(grandma_tammy_mary, [fail]) :- grandma(tammy, mary), !.
test(grandma_mary_jim, [fail]) :- grandma(mary, jim), !.

% ==========================================
% 3. grandson/2 (Внук)
% ==========================================
test(grandson_bob_bill, [true]) :- grandson(bob, bill), !.
test(grandson_bob_sue, [true]) :- grandson(bob, sue), !.
test(grandson_bob_paul, [true]) :- grandson(bob, paul), !.
test(grandson_bob_mary, [true]) :- grandson(bob, mary), !.
% Негативные (сыновья, внучки, левые связи)
test(grandson_joe_bill, [fail]) :- grandson(joe, bill), !.
test(grandson_jim_paul, [fail]) :- grandson(jim, paul), !.
test(grandson_tammy_bill, [fail]) :- grandson(tammy, bill), !.
test(grandson_bob_joe, [fail]) :- grandson(bob, joe), !.

% ==========================================
% 4. sister/2 (Сестра)
% ==========================================
test(sister_ann_joe, [true]) :- sister(ann, joe), !.
% Проверка, что найденная сестра - именно Энн
test(sister_joe_find, [true(X == ann)]) :- sister(X, joe), !.
% Негативные (мужчины, отсутствие сестер, сам себе)
test(sister_ann_ann, [fail]) :- sister(ann, ann), !.
test(sister_tammy_bob, [fail]) :- sister(tammy, bob), !.
test(sister_joe_ann, [fail]) :- sister(joe, ann), !.
test(sister_sue_bill, [fail]) :- sister(sue, bill), !.

% ==========================================
% 5. aunt/2 (Тетя)
% ==========================================
test(aunt_ann_tammy, [true]) :- aunt(ann, tammy), !.
% Негативные (мама, бабушка, кузина)
test(aunt_ann_bob, [fail]) :- aunt(ann, bob), !.
test(aunt_sue_tammy, [fail]) :- aunt(sue, tammy), !.
test(aunt_tammy_bob, [fail]) :- aunt(tammy, bob), !.
test(aunt_mary_tammy, [fail]) :- aunt(mary, tammy), !.

% ==========================================
% 6. cousin/2 (Кузин)
% ==========================================
test(cousin_bob_tammy, [true]) :- cousin(bob, tammy), !.
test(cousin_tammy_bob, [true]) :- cousin(tammy, bob), !. % Симметрия
% Негативные (дядя, тетя, мама, сам себе)
test(cousin_bob_joe, [fail]) :- cousin(bob, joe), !.
test(cousin_tammy_ann, [fail]) :- cousin(tammy, ann), !.
test(cousin_tammy_tammy, [fail]) :- cousin(tammy, tammy), !.
test(cousin_bob_jim, [fail]) :- cousin(bob, jim), !.

:- end_tests(family_tree_exhaustive).


:- begin_tests(hobbies_exhaustive).

% ==========================================
% 8. four_hobbies/1 (Ровно 4 хобби)
% ==========================================
test(four_hobbies_john, [true]) :- four_hobbies(john), !.
test(four_hobbies_eric, [true]) :- four_hobbies(eric), !.
% Негативные (у них меньше 4-х хобби)
test(four_hobbies_ellen, [fail]) :- four_hobbies(ellen), !.
test(four_hobbies_paul, [fail]) :- four_hobbies(paul), !.
test(four_hobbies_leonard, [fail]) :- four_hobbies(leonard), !.

% ==========================================
% 9. same_hobbies/2 (Одинаковые хобби)
% ==========================================
% Положительные (есть хотя бы одно общее)
test(same_hobbies_john_eric, [true]) :- same_hobbies(john, eric), !.
test(same_hobbies_eric_leonard, [true]) :- same_hobbies(eric, leonard), !.
test(same_hobbies_ellen_john, [true]) :- same_hobbies(ellen, john), !.
test(same_hobbies_john_leonard, [true]) :- same_hobbies(john, leonard), !.
test(same_hobbies_eric_paul, [true]) :- same_hobbies(eric, paul), !.
% Проверка симметрии
test(same_hobbies_symmetry, [true]) :- same_hobbies(paul, eric), !.
% Негативные (нет общих хобби, или это один и тот же человек)
test(same_hobbies_ellen_paul, [fail]) :- same_hobbies(ellen, paul), !.
test(same_hobbies_john_paul, [fail]) :- same_hobbies(john, paul), !.
test(same_hobbies_ellen_ellen, [fail]) :- same_hobbies(ellen, ellen), !.
test(same_hobbies_john_john, [fail]) :- same_hobbies(john, john), !.

:- end_tests(hobbies_exhaustive).