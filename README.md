Este repositorio contiene los siguientes programas:
- Snake game en python.

- Solucionador del acertijo del granjero, la cabra, el lobo y la col en prolog.

- Solucionador de sudokus en prolog.

- El juego del caballo en python.

- Solucionador del acertijo de los misioneros y los caníbales

- Solucionador del acertijo de las fichas(8 puzzle lineal)

## Snake game

Es el clásico juego, para ejecutarlo lanzar el siguiente comando:

```
python snake.py
```

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
