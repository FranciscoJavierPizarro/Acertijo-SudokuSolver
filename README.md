Este repositorio contiene los siguientes programas:

- Solucionador del acertijo del granjero, la cabra, el lobo y la col en prolog.

- Solucionador de sudokus en prolog.

- El juego del caballo en python.

- Solucionador del acertijo de los misioneros y los caníbales

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
