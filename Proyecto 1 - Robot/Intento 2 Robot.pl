% A*
% solve(state(robot(h2),en(a,h2),en(v,h2),pinza(0)), state(robot(h1),en(a,h1),en(v,h2),pinza(0)), Solution).
% go(state(robot(H),en(C1,H1),en(C2,H2),pinza(0)), state(robot(H),en(C1,H1),en(C2,H2),pinza(C2)), Solucion).
% state(robot(H),en(C1,H1),en(C2,H2),pinza(X).
solve(InitialState, FinalState, Actions) :- plan(InitialState, FinalState, Actions, [InitialState]).

plan(State, State, [], _) :- !.
plan(State1, State, [Action|R], States) :-  go(State1, State2, Action),
                                            not(member(State2, States)),
                                            plan(State2, State, R, [State2|States]).


primeroMejor(Ini,Sol) :-
 expandir([],l(Ini,0/0),9999,_,si,Sol). 
% Caso 1: nodo hoja meta, construir camino solución 2 3 expandir(Camino, l(Nodo, _), _, _, si, [Nodo|Camino]) :4 meta(Nodo).
expandir(Camino, l(Nodo, _), _, _, si, [Nodo|Camino]) :-
	meta(Nodo).

 % Caso 2: nodo hoja, f-valor < Umbral
 % Generar suscesores y expandir bajo la Umbral. 
  expandir(Camino,l(Nodo,F/G),Umbral,Arbol1,Resuelto,Sol) :-
   F =< Umbral, 
  ( 
  	bagof(Nodo2/C,(s(Nodo,Nodo2,C),\+ member(Nodo2,Camino)),Succ), !,
   	listaSucs(G,Succ,As), 
   	mejorF(As,F1),
   	expandir(Camino,t(Nodo,F1/G,As),Umbral,Arbol1,Resuelto,Sol)
   	;
   	Resuelto = nunca
  ).
% Caso 3: no hoja, f-valor < Umbral
% Expandir el subárbol más promisorio; dependiendo de
% resultados, continuar decidirá como proceder. 
expandir(Camino,t(Nodo,F/G,[A|As]),Umbral,Arbol1,Res,Sol) :-
  F =< Umbral,
  mejorF(As,MejorF),min(Umbral,MejorF,Umbral1),
  expandir([Nodo|Camino],A,Umbral1,A1,Res1,Sol),
  continuar(Camino,t(Nodo,F/G,[A1|As]),Umbral,Arbol1,Res1,
 			Res,Sol). 
  expandir(_,arbol(_,_,[]),_,_,nunca,_) :- !. 
  expandir(_,Arbol,Umbral,Arbol,no,_) :-
  	f(Arbol,F), F > Umbral.

continuar(_,_,_,_,si,si,Sol).
continuar(Camino,t(Nodo,F/G,[A1|As]),Umbral,Arbol1,no,
		Solucionado,Sol) :-
	insertarArbol(A1,As,NAs),
	mejorF(NAs,F1),
	expandir(Camino,t(Nodo,F1/G,NAs),Umbral,Arbol1,
		Solucionado,Sol).

continuar(Camino,t(Nodo,F/G,[_|As]),Umbral,Arbol1,nunca,
		Solucionado,Sol) :-
	mejorF(As,F1),
	expandir(Camino,t(Nodo,F1/G,As),Umbral,Arbol1,
			Solucionado,Sol).


% Funcion de costo
% Implementando intercambio y estados

% Coger
s(state(robot(H),en(C1,H1),en(C2,H),pinza(0)), state(robot(H),en(C1,H1),en(C2,H),pinza(C2)), 'Coger la Caja ' + C2 + ' en ' + H, 5).
s(state(robot(H),en(C1,H),en(C2,H2),pinza(0)), state(robot(H),en(C1,H),en(C2,H2),pinza(C1)), 'Coger la Caja ' + C1 + ' en ' + H, 5).

% Soltar
s(state(robot(H),en(C1,H),en(C2,H2),pinza(C1)), state(robot(H),en(C1,H),en(C2,H2),pinza(0)), 'Soltar en '+ H, 2).
s(state(robot(H),en(C1,H1),en(C2,H),pinza(C2)), state(robot(H),en(C1,H1),en(C2,H),pinza(0)), 'Soltar en '+ H, 2).

% Pasar
s(state(robot(h1),en(C1,h1),en(C2,H2),pinza(C1)), state(robot(h2),en(C1,h2),en(C2,H2),pinza(C1)), 'Pasar de h1 a h2', 10).
s(state(robot(h1),en(C1,H1),en(C2,h1),pinza(C2)), state(robot(h2),en(C1,H1),en(C2,h2),pinza(C2)), 'Pasar de h1 a h2', 10).
s(state(robot(h2),en(C1,h2),en(C2,H2),pinza(C1)), state(robot(h1),en(C1,h1),en(C2,H2),pinza(C1)), 'Pasar de h2 a h1', 10).
s(state(robot(h2),en(C1,H1),en(C2,h2),pinza(C2)), state(robot(h1),en(C1,H1),en(C2,h1),pinza(C2)), 'Pasar de h2 a h1', 10).

s(state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), 'Pasar de h1 a h2 sin Caja', 8).
s(state(robot(h2),en(C1,H1),en(C2,H2),pinza(0)), state(robot(h1),en(C1,H1),en(C2,H2),pinza(0)), 'Pasar de h2 a h1 sin Caja', 8).

% Funcion heuristica
h(state(robot(h2),en(a,h2),en(v,h2),pinza(0)), 3).
h(state(robot(h2),en(a,h2),en(v,h2),pinza(a)), 2).
h(state(robot(h1),en(a,h1),en(v,h2),pinza(a)), 1).
h(state(robot(h1),en(a,h1),en(v,h2),pinza(0)), 0).
h(state(robot(h2),en(a,h1),en(v,h2),pinza(0)), 1).
h(state(robot(h2),en(a,h1),en(v,h2),pinza(v)), 2).
h(state(robot(h1),en(a,h1),en(v,h1),pinza(v)), 3).
h(state(robot(h1),en(a,h1),en(v,h1),pinza(0)), 4).
h(state(robot(h1),en(a,h1),en(v,h1),pinza(a)), 5).
h(state(robot(h2),en(a,h2),en(v,h1),pinza(a)), 6).
h(state(robot(h2),en(a,h2),en(v,h1),pinza(0)), 7).
h(state(robot(h1),en(a,h2),en(v,h1),pinza(0)), 6).
h(state(robot(h1),en(a,h2),en(v,h1),pinza(v)), 5).
h(state(robot(h2),en(a,h2),en(v,h2),pinza(v)), 4).
h(state(robot(h1),en(a,h2),en(v,h2),pinza(0)), 4).
