% solve(state(0, 0), state(_, 2), Solution).

% solve(state(robot(h2),en(a,h2),en(v,h2),pinza(0)), state(robot(h1),en(a,h1),en(v,h2),pinza(0)), Solution).

% go(state(robot(H),en(C1,H1),en(C2,H2),pinza(0)), state(robot(H),en(C1,H1),en(C2,H2),pinza(C2)), Solucion).

solve(InitialState, FinalState, Actions) :- plan(InitialState, FinalState, Actions, [InitialState]).

plan(State, State, [], _) :- !.
plan(State1, State, [Action|R], States) :-  go(State1, State2, Action),
                                            not(member(State2, States)),
                                            plan(State2, State, R, [State2|States]).

% Implementando intercambio y estados

go(state(robot(H),en(C1,H1),en(C2,H),pinza(0)), state(robot(H),en(C1,H1),en(C2,H),pinza(C2)), 'Coger la Caja ' + C2 + ' en ' + H).
go(state(robot(H),en(C1,H),en(C2,H2),pinza(0)), state(robot(H),en(C1,H),en(C2,H2),pinza(C1)), 'Coger la Caja ' + C1 + ' en ' + H).

go(state(robot(H),en(C1,H),en(C2,H2),pinza(C1)), state(robot(H),en(C1,H),en(C2,H2),pinza(0)), 'Soltar en '+ H).
go(state(robot(H),en(C1,H1),en(C2,H),pinza(C2)), state(robot(H),en(C1,H1),en(C2,H),pinza(0)), 'Soltar en '+ H).

go(state(robot(h1),en(C1,h1),en(C2,H2),pinza(C1)), state(robot(h2),en(C1,h2),en(C2,H2),pinza(C1)), 'Pasar de h1 a h2').
go(state(robot(h1),en(C1,H1),en(C2,h1),pinza(C2)), state(robot(h2),en(C1,H1),en(C2,h2),pinza(C2)), 'Pasar de h1 a h2').
go(state(robot(h2),en(C1,h2),en(C2,H2),pinza(C1)), state(robot(h1),en(C1,h1),en(C2,H2),pinza(C1)), 'Pasar de h2 a h1').
go(state(robot(h2),en(C1,H1),en(C2,h2),pinza(C2)), state(robot(h1),en(C1,H1),en(C2,h1),pinza(C2)), 'Pasar de h2 a h1').

go(state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), 'Pasar de h1 a h2 sin Caja').
go(state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), 'Pasar de h2 a h1 sin Caja').
