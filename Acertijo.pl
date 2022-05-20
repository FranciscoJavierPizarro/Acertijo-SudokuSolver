/*
Este programa resuelve el problema del granjero, el lobo, la cabra y la col.
En dicho problema los 44 parten de la misma orilla de un rio y deben cruzarlo,
la barca solo permite que se monte el granjero y como mucho una de sus mercancias,
si el lobo se queda solo con la cabra se la come, si la cabra se queda sola con la
col se la come.

Este problema se asemeja al de los canibales y los misioneros.

En la tupla la posición 0 representa el lado izqd y el 1 el lado derecho.
Los indices de la tupla son: granjero,lobo,cabra,col.
*/

%Regla que lanza la busqueda de un camino desde la situación original(todos en el lado 0)
%hasta la situación deseada(todos en el lado 1)
buscar :- camino([0,0,0,0],[1,1,1,1],[[0,0,0,0]],_).

%Caso base en el que hemos llegado a la situación deseada
camino([A,B,C,D],[A,B,C,D],_,Movimientos):-  nl,nl,mostrar(Movimientos).

%Caso recursivo en el que vamos de una situación A a una situación B
%Hacemos un movimiento, comprobamos que es legal, comprobamos que no nos ha llevado a una
%situación previa, hacemos la llamada recursiva actualizando el origen, las situaciones
%por las que hemos pasado y añadimos la información a mostrar del movimiento
camino([A,B,C,D],[E,F,G,H],RecorridosHechos,ListaMovs) :-  
   move([A,B,C,D],[I,J,K,L],MovimientoNuevo),  
   legal([I,J,K,L]),  
   not(member([I,J,K,L],RecorridosHechos)),  
   camino([I,J,K,L],[E,F,G,H],[[I,J,K,L]|RecorridosHechos],[ [[I,J,K,L],[A,B,C,D],MovimientoNuevo] | ListaMovs ]).

%Posibles combinaciones de movimientos
move([A,B,C,D],[E,B,C,D],'El granjero cruza el rio') :-  (A == 0, E is 1) ; (A == 1, E is 0).  
move([A,B,C,D],[E,F,C,D],'El granjero y el lobo cruzan el rio') :- A == B, ((A == 0, E is 1, F is 1) ; (A == 1, E is 0, F is 0)).  
move([A,B,C,D],[E,B,F,D],'El granjero y la cabra cruzan el rio') :- A == C, ((A == 0, E is 1, F is 1) ; (A == 1, E is 0, F is 0)).  
move([A,B,C,D],[E,B,C,F],'El granjero y la col cruzan el rio') :- A == D, ((A == 0, E is 1, F is 1) ; (A == 1, E is 0, F is 0)).   

%Comprueba que la situación nueva sea legal siguiendo las reglas del problema
legal([I,J,K,L]) :-  
    ((I == J , J == K) ; J \= K), % el lobo no se queda solo con la cabra
    ((I == K , K == L) ; K \= L). % la cabra no se queda sola con la col

%Regla que muestra el resultado en pantalla
mostrar([]) :- write('============================================================'),nl.  
mostrar([[A,B,Movmiento]|Cola]) :-  
mostrar(Cola),  
    write(B), write(' ~~ '), write(A), write(': '), write(Movmiento), nl.  