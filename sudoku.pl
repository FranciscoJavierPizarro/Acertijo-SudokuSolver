/*
Este programa resuelve el juego del sudoku, un cuadrado conformado por 9 cuadradados de 3x3,
cada cuadrado debe ser llenado sin repetir ningún número dentro de si mismo y conteniendo todos
los números del 1 al 9, así mismo ocurre con las filas y las columnas del cuadrado de 9x9.

Para añadir un nuevo sudoku a resolver simplemente añadir el nuevo problema de la forma que ya estan definidos

Para ejecutarlo escribir la siguiente consulta:(cambiar el 1 por el número del sudoku a resolver)
play(1).
*/

%Regla para jugar
play(A) :- time((problema(A, Sol), sudoku(Sol))),fin.

:- use_module(library(clpfd)).

sudoku(Filas) :-
    length(Filas,9),%Garantiza que sea un 9x9
    maplist(same_length(Filas), Filas),
    append(Filas, ListasUnidas),%Crea una lista con todos los elementos y verifica que estan en el dominio 1-9
    ListasUnidas ins 1..9,
    maplist(all_distinct, Filas),%Comprueba que todas las filas son distintas entre si
    transpose(Filas, Columnas),%Comprueba que todas las columnas son distintas entre si
    maplist(all_distinct, Columnas),
    Filas = [A,B,C,D,E,F,G,H,I],%Comprueba que los cuadrados generados son válidos
    cuadrados(A,B,C), cuadrados(D,E,F), cuadrados(G,H,I),
    mostrarSudoku(Filas).
    
%Reglas que comprueban que todos los cuadrados de 3x3 de 3 filas dadas sean válidos
cuadrados([],[],[]).
cuadrados([N1,N2,N3|Ns1],
          [N4,N5,N6|Ns2],
          [N7,N8,N9|Ns3]) :- all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]), cuadrados(Ns1,Ns2,Ns3).

%SUDOKUS PARA RESOLVER
problema(1, P) :-
        P = [[1,_,_,8,_,4,_,_,_],
             [_,2,_,_,_,_,4,5,6],
             [_,_,3,2,_,5,_,_,_],
             [_,_,_,4,_,_,8,_,5],
             [7,8,9,_,5,_,_,_,_],
             [_,_,_,_,_,6,2,_,3],
             [8,_,1,_,_,_,7,_,_],
             [_,_,_,1,2,3,_,8,_],
             [2,_,5,_,_,_,_,_,9]].


problema(2, P) :- 
        P = [[_,_,2,_,3,_,1,_,_],
             [_,4,_,_,_,_,_,3,_],
             [1,_,5,_,_,_,_,8,2],
             [_,_,_,2,_,_,6,5,_],
             [9,_,_,_,8,7,_,_,3],
             [_,_,_,_,4,_,_,_,_],
             [8,_,_,_,7,_,_,_,4],
             [_,9,3,1,_,_,_,6,_],
             [_,_,7,_,6,_,5,_,_]].

problema(3, P) :-
        P = [[1,_,_,_,_,_,_,_,_],
             [_,_,2,7,4,_,_,_,_],
             [_,_,_,5,_,_,_,_,4],
             [_,3,_,_,_,_,_,_,_],
             [7,5,_,_,_,_,_,_,_],
             [_,_,_,_,_,9,6,_,_],
             [_,4,_,_,_,6,_,_,_],
             [_,_,_,_,_,_,_,7,1],
             [_,_,_,_,_,1,_,3,_]].


%Reglas que muestran el resultado en pantalla
mostrarSudoku(Filas) :- Filas = [A,B,C,D,E,F,G,H,I],
nl, mostrar(A), mostrar(B), mostrar(C), linea, mostrar(D), mostrar(E), mostrar(F), linea, mostrar(G), mostrar(H), mostrar(I),nl.


mostrar(A) :- write('|') , mostrar1(A).

mostrar1([]) :- nl.
mostrar1([A,AA,AAA|AAAA]) :- write(A) , write(','), write(AA) , write(','), write(AAA) , write('|'), mostrar1(AAAA).

linea :- write('-------------------'),nl.

fin :- halt.