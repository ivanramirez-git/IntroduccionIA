es_un(hombre_adulto, persona).
es_un(jugador_de_futbol, hombre_adulto).
es_un(defensa, jugador_de_futbol).
es_un(delantero, jugador_de_futbol).

es_un(club, futbol).
es_un(equipo, club).

inst(adith, defensa).
inst(miguel, delantero).
inst(millonarios,equipo).

prop(persona, pie_habil, derecho).
prop(hombre_adulto, altura, 1.80).
prop(jugador_de_futbol, patea, balon).
prop(jugador_de_futbol, altura, 1.85).
prop(jugador_de_futbol, numero_de_goles, 3).
prop(delantero, numero_de_goles, 5).
prop(defensa, numero_de_goles, 1).
prop(adith, equipo, millonarios).
prop(miguel, equipo, millonarios).

prop(I, A, V):-inst(I, C), prop(C, A, V).
prop(S, A, V):-es_un(S, C), prop(C, A, V).
prop(I, A, V):-inst(I, S), es_un(S, C), prop(C, A, V).

