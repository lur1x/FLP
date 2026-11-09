parent(bill, joe).
parent(sue, joe).
parent(bill, ann).
parent(sue, ann).
parent(joe, tammy).
parent(paul, jim).
parent(mary, jim).
parent(ann, bob).
parent(jim, bob).

male(bill).
male(joe).
male(paul).
male(jim).
male(bob).

female(sue).
female(ann).
female(mary).
female(tammy).

different(X, Y) :- X \= Y.

son(X) :- male(X), parent(_, X).

grandma(X, Y) :- female(X), parent(X, Z), parent(Z, Y).

grandson(X, Y) :- male(X), parent(Z, X), parent(Y, Z).

sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X), different(X, Y).
brother(X, Y) :- parent(Z, X), parent(Z, Y), male(X), different(X, Y).

aunt(X, Y) :- sister(X, Z), parent(Z, Y).

cousin(X, Y) :- parent(Z, X), parent(W, Y), sister(Z, W).
cousin(X, Y) :- parent(Z, X), parent(W, Y), brother(Z, W).

likes(ellen, reading).
likes(john, computers).
likes(john, badminton).
likes(john, photo).
likes(john, reading).
likes(leonard, badminton).
likes(eric, swimming).
likes(eric, badminton).
likes(eric, chess).
likes(eric, game).
likes(paul, swimming).

four_hobbies(X) :- 
    setof(Hobby, likes(X, Hobby), Hobbies),
    length(Hobbies, 4).

same_hobbies(X, Y) :-
    likes(X, Hobby),
    likes(Y, Hobby),
    X \= Y.