Este repositorio contiene los siguientes programas:

- Snake game en python.

- Creador y solucionador de laberintos en C++.

- Solucionador del acertijo del granjero, la cabra, el lobo y la col en prolog.

- Solucionador de sudokus en prolog.

- El juego del caballo en python.

- Solucionador del acertijo de los misioneros y los caníbales

- Solucionador del acertijo de las fichas(8 puzzle lineal)

- Solucionador del problema del viajero con A*

## Snake game

Es el clásico juego, para ejecutarlo lanzar el siguiente comando:

```
python snake.py
```

## Creador y solucionador de laberintos en C++

Este programa tiene 2 modos de ejecución en el primero de ellos se ejecuta adjuntando como parámetro el nombre de un fichero cuyo contenido son # y espacios en blanco definiendo un laberinto válido(con 4 bordes y la penúltima casilla inferior derecha siendo vacía, de esta forma carga el laberinto leido del fichero y lo resuelve. El segundo método de ejecución es incluyendo como paramétros las dimensiones de altura y largo del tablero, así como la densidad del mismo es decir que candidad de casillas son paredes respecto del total, ejecutando de esta forma genera un laberinto aleatorio y trata de resolverlo. Para ejecutarlo lanzar los siguientes comandos:

```
make -f makeLAB
./mainLab 30 30 0.15
```
Los valores 30 son el alto y el largo, el valor 0.15 es la densidad, estos valores se pueden sustituir.


## Juego del caballo

El caballo comienza en una casilla aleatoria del tablero y debe recorrer todas las casillas del mismo sin repetir su paso por ninguna,

para modificar el tamaño del tablero modificar las constantes definidas al principio del programa.

Para ejecutar el programa:

```
python juegoDelCaballo.py
```

## Sudokus

Ejecutar el siguiente comando

```
swipl sudoku.pl
```

Una vez abierto el intérprete de prolog escribir lo siguiente

```
play(1).
```

Para cambiar el sudoku a resolver cambiar el 1 por otro número de un sudoku definido.

Para añadir un nuevo sudoku definirlo como los ejemplos.

## Acertijo-lobo-cabra-y-col
Solución al acertijo del granjero, el lobo, la cabra y la col planteada en el lenguaje PROLOG
### Como ejecutarlo
Ejecutar el siguiente comando

```
swipl Acertijo.pl
```

Una vez abierto el intérprete de prolog escribir lo siguiente

```
buscar.
```

Para mostrar soluciones alternativas escribir ';'

## Acertijo misioneros-caníbales
Solución al acertijo de los misioneros y los caníbales planteada en el lenguaje haskell mediante el uso de grafos.
### Como ejecutarlo
Ejecutar el siguiente comando para compilar

```
ghc canibals.hs
```

Para ejecutarlo

```
./canibals
```

## Juego de las fichas
En este juego contamos con una fila de fichas que comienza de esta forma

B B B H V V V

El objetivo es intercambiando el hueco por una ficha que como mucho tenga a otras 2 entre el hueco y dicha ficha es alcanzar la siguiente configuración

V V V H B B B

Para resolverlo este algoritmo emplea una búsqueda informada del tipo A*

### Como ejecutarlo

Emplear CLIPS en su versión (6.30 3/17/15)

```
clips -f fichas.clp
```

Una vez lanzado escribir en la terminal clips lo siguiente
```
(run)
```
## Problema del viajero
Se tiene un mapa de Rumania y se pretende viajar desde la ciudad de Arad hasta la ciudad de Bucarest, empleando para ello la ruta óptima.

Para resolverlo se ha empleado una implementación del algoritmo de búsqueda informada A*.

### Como ejecutarlo

Emplear OCamlc en su version 4.11.1

```
ocamlc traveler.ml -o traveler
```

Una vez compilado lanzar el ejecutable generado.