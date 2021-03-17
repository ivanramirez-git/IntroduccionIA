% solve(state(0, 0), state(_, 2), Solution).

% solve(state(robot(h2),en(a,h2),en(v,h2),pinza(0)), state(robot(h1),en(a,h1),en(v,h2),pinza(0)), Solution).

% go(state(robot(H),en(C1,H1),en(C2,H2),pinza(0)), state(robot(H),en(C1,H1),en(C2,H2),pinza(C2)), Solucion).

solve(InitialState, FinalState, Actions) :- plan(InitialState, FinalState, Actions, [InitialState]).

plan(State, State, [], _) :- !.
plan(State1, State, [Action|R], States) :-  go(State1, State2, Action),
                                            not(member(State2, States)),
                                            plan(State2, State, R, [State2|States]).

%%Implementando intercambio y estados


go(state(robot(H),en(C1,H1),en(C2,H2),pinza(0)), state(robot(H),en(C1,H1),en(C2,H2),pinza(C2)), 'Coger').
go(state(robot(H),en(C1,H1),en(C2,H2),pinza(0)), state(robot(H),en(C1,H1),en(C2,H2),pinza(C1)), 'Coger').

go(state(robot(H),en(C1,H1),en(C2,H2),pinza(C1)), state(robot(H),en(C1,H1),en(C2,H2),pinza(0)), 'Soltar').
go(state(robot(H),en(C1,H1),en(C2,H2),pinza(C2)), state(robot(H),en(C1,H1),en(C2,H2),pinza(0)), 'Soltar').

go(state(robot(h1),en(C1,H1),en(C2,H2),pinza(C1)), state(robot(h2),en(C1,H1),en(C2,H2),pinza(C1)), 'Pasar').
go(state(robot(h1),en(C1,H1),en(C2,H2),pinza(C2)), state(robot(h2),en(C1,H1),en(C2,H2),pinza(C2)), 'Pasar').
go(state(robot(h2),en(C1,H1),en(C2,H2),pinza(C1)), state(robot(h1),en(C1,H1),en(C2,H2),pinza(C1)), 'Pasar').
go(state(robot(h2),en(C1,H1),en(C2,H2),pinza(C2)), state(robot(h1),en(C1,H1),en(C2,H2),pinza(C2)), 'Pasar').

go(state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), 'Volver').
go(state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), 'Volver').
go(state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), 'Volver').
go(state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), 'Volver').


 
%go( state(0, L2) , state(3, L2) , 'fill pitcher1' ).
%go( state(L1, 0) , state(L1, 4) , 'fill pitcher2' ).
%go( state(L1, L2), state(0, L2) , 'empty pitcher1') :- L1 > 0.
%go( state(L1, L2), state(L1, 0) , 'empty pitcher2') :- L2 > 0.

%go( state(L1, L2), state(L3, 4), 'pitcher1 to pitcher2') :-  L1 > 0 , L2 < 4 , L2+L1 >= 4 , L3 is L1-(4-L2).
%go( state(L1, L2), state(0, L4), 'pitcher1 to pitcher2') :-  L1 > 0 , L2 < 4 , L2+L1 < 4  , L4 is L2+L1.
                                                                                    
%go( state(L1, L2), state(3, L4), 'pitcher2 to pitcher1') :-  L2 > 0 , L1 < 3 , L1+L2 >= 3 , L4 is L2-(3-L1).
%go( state(L1, L2), state(L3, 0), 'pitcher2 to pitcher1') :-  L2 > 0 , L1 < 3 , L1+L2 < 3  , L3 is L1+L2.