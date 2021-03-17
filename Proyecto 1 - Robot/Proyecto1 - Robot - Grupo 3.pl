% solve(state(0, 0), state(_, 2), Solution).
% solve(estado(robot(h2),en(a,h2),en(v,h2),pinza(0)), estado(robot(h1),en(a,h1),en(v,h2)),pinza(0), Solucion).
% intercambio(estado(robot(h2),en(a,h2),en(v,h2),pinza(0)), estado(robot(h2),en(a,h2),en(v,h2)),pinza(a), Solucion).

solve(InitialState, FinalState, Actions) :- plan(InitialState, FinalState, Actions, [InitialState]).

plan(State, State, [], _) :- !.
plan(State1, State, [Action|R], States) :-  go(State1, State2, Action),
                                            not(member(State2, States)),
                                            plan(State2, State, R, [State2|States]).

%%Implementando intercambio y estados


intercambio(estado(robot(H),en(C1,H1),en(C2,H2),pinza(0)), estado(robot(H),en(C1,H1),en(C2,H2)),pinza(C2),'Coger').
intercambio(estado(robot(H),en(C1,H1),en(C2,H2),pinza(0)), estado(robot(H),en(C1,H1),en(C2,H2)),pinza(C1),'Coger').

intercambio(estado(robot(H),en(C1,H1),en(C2,H2),pinza(C1)), estado(robot(H),en(C1,H1),en(C2,H2)),pinza(0),'Soltar').
intercambio(estado(robot(H),en(C1,H1),en(C2,H2),pinza(C2)), estado(robot(H),en(C1,H1),en(C2,H2)),pinza(0),'Soltar').

intercambio(estado(robot(h1),en(C1,H1),en(C2,H2),pinza(C1)), estado(robot(h2),en(C1,H1),en(C2,H2)),pinza(C1),'Pasar').
intercambio(estado(robot(h1),en(C1,H1),en(C2,H2),pinza(C2)), estado(robot(h2),en(C1,H1),en(C2,H2)),pinza(C2),'Pasar').
intercambio(estado(robot(h2),en(C1,H1),en(C2,H2),pinza(C1)), estado(robot(h1),en(C1,H1),en(C2,H2)),pinza(C1),'Pasar').
intercambio(estado(robot(h2),en(C1,H1),en(C2,H2),pinza(C2)), estado(robot(h1),en(C1,H1),en(C2,H2)),pinza(C2),'Pasar').



%% 
%go( state(0, L2) , state(3, L2) , 'fill pitcher1' ).
%go( state(L1, 0) , state(L1, 4) , 'fill pitcher2' ).
%go( state(L1, L2), state(0, L2) , 'empty pitcher1') :- L1 > 0.
%go( state(L1, L2), state(L1, 0) , 'empty pitcher2') :- L2 > 0.

%go( state(L1, L2), state(L3, 4), 'pitcher1 to pitcher2') :-  L1 > 0 , L2 < 4 , L2+L1 >= 4 , L3 is L1-(4-L2).
%go( state(L1, L2), state(0, L4), 'pitcher1 to pitcher2') :-  L1 > 0 , L2 < 4 , L2+L1 < 4  , L4 is L2+L1.
                                                                                    
%go( state(L1, L2), state(3, L4), 'pitcher2 to pitcher1') :-  L2 > 0 , L1 < 3 , L1+L2 >= 3 , L4 is L2-(3-L1).
%go( state(L1, L2), state(L3, 0), 'pitcher2 to pitcher1') :-  L2 > 0 , L1 < 3 , L1+L2 < 3  , L3 is L1+L2.