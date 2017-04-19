/*
Put
This definition uses recursion to implement Put in an array.
*/
put(K,V,[],[[K,V]]).
put(K,V,[[K,_]|T],[[K,V]|T]).
put(K,V,[[SomeV,SomeV2]|T],[[SomeV,SomeV2]|D]):- put(K,V,T,D).

/*
Get
This definition uses recursion to implement Get from an array.
*/
get(K,[[K,V]|T],V).
get(K,[[X,Z]|T],V):- get(K,T,V).

/*
Subsequence
This definition uses recursion to implement Subsequence from an array.
*/
subseq([],[]).
subseq([X|T],[X|R]):- subseq(T,R).
subseq(X,[Y|R]):- subseq(X,R).

/*
VerbalArithmetic
This definition uses recursion to implement Verbal Arithmetic (https://en.wikipedia.org/wiki/Verbal_arithmetic).
*/
add(Carry, X, Y, 1, Res2):- (Carry+X+Y) > 9, Res2 is ((Carry+X+Y) mod 10).
add(Carry, X, Y, 0, Res):- (Carry+X+Y) =< 9, Res is (Carry+X+Y).

sum([],[],[H], Carry):-
	Carry =:= H.
sum([], [H2|T2], [H3|T3], Carry):-
	add(Carry, 0, H2, Tens, Ones),
	Ones =:= H3,
	sum([], T2, T3, Tens).
sum([H1|T1], [], [H3|T3], Carry):-
	add(Carry, H1, 0, Tens, Ones),
	Ones =:= H3,
	sum(T1, [], T3, Tens).
sum([H1|T1], [H2|T2], [H3|T3], Carry):-
	add(Carry, H1, H2, Tens, Ones),
	Ones =:= H3,
	sum(T1, T2, T3, Tens).

verbalArithmetic(Vocab, [H1|T1], [H2|T2], [H3|T3]):-
	fd_domain(H1, 1, 9),
	fd_domain(H2, 1, 9),
	fd_domain(H3, 1, 9),
	fd_domain(T1, 0, 9),
	fd_domain(T2, 0, 9),
	fd_domain(T3, 0, 9),
	fd_all_different(Vocab),
	fd_labeling(Vocab),

	reverse([H1|T1], Rev1),
	reverse([H2|T2], Rev2),
	reverse([H3|T3], Rev3),

	sum(Rev1, Rev2, Rev3, 0).
