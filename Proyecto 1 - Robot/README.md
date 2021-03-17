# IntroduccionIA
## Proyecto 1 - Robot

Un robot que debe trasladar cajas de colores, entre dos habitaciones (H1 y H2), las cuales están conectadas por una puerta.
El robot posee una pinza que puede coger solo una caja a la vez.
Se debe establecer un plan de acción (coger, pasar, soltar), que permita alcanzar una situación final deseada. 

###Comprender elementos representativos del problema → Variables significativas y sus posibles valores.

Variables significativas   .        Posibles Valores
1. caja(C)    C es una caja

2. hab(H)    H es una habitación

3. en(C,H)    la caja C se encuentra apoyada en el piso de la habitación H

4. robot(H)    el robot se encuentra en la habitación H

5. pinza(C)    la pinza tiene agarrada la caja C

6. puerta(Ha,Hb)    existe una puerta entre las habitaciones Ha y Hb

7. plib()    la pinza está libre

###Identificar componentes del estado → Representarlo mediante una “TUPLA”.

estado(robot(H),en(C,H),en(C,H))

Identificar el estado inicial y final

1. Inicial: estado(robot(H2),en(A,H2),en(V,H2)).
2. Final:   estado(robot(H1),en(A,H1),en(V,H2)).





