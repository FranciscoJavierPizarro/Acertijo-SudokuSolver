import random
MAX_COLS = 5
MAX_FILS = 5


def crear_tablero():
    tablero = []
    fila = []

    for altura in range(0, MAX_FILS):
        for dato_in_fila in range(0, MAX_COLS):
            fila.append(0)
        tablero.append(fila.copy())
        fila.clear()
    return tablero

def dibujar_tablero(tablero):
    for x in range(MAX_COLS):
        for y in range(MAX_FILS):
            if(tablero[x][y] == 0): # Casilla libre:
                print("|  |", end = '')
            else:                       # Casilla ocupada:
                print("|" + str(tablero[x][y]), end = '')
                if len(str(tablero[x][y])) == 1:
                    print(" ", end = '')
                print("|", end = '')
        print()
    print("\n\n")

def move(tablero, coord_x, coord_y, salto):
    if (salto == MAX_COLS * MAX_FILS + 1):
        dibujar_tablero(tablero)
        return True
    
    else:
        if coord_x >= 0 and coord_y >= 0 and coord_x < MAX_COLS and coord_y < MAX_FILS and tablero[coord_x][coord_y] == 0:
            dibujar_tablero(tablero)
            tablero[coord_x][coord_y] = salto
            
            # Avanzamos arriba-izq
            if (move(tablero, coord_x-1, coord_y-2, salto + 1)):
                return True

            # Avanzamos arriba-dcha
            if (move(tablero, coord_x+1, coord_y-2, salto + 1)):
                return True

            # Avanzamos izq-arriba
            if (move(tablero, coord_x-2, coord_y-1, salto + 1)):
                return True

            # Avanzamos izq-abajo
            if (move(tablero, coord_x-2, coord_y+1, salto + 1)):
                return True

            # Avanzamos dcha-arriba
            if (move(tablero, coord_x+2, coord_y-1, salto + 1)):
                return True

            # Avanzamos dcha-abajo
            if (move(tablero, coord_x+2, coord_y+1, salto + 1)):
                return True

            # Avanzamos abajo-izq
            if (move(tablero, coord_x-1, coord_y+2, salto + 1)):
                return True

            # Avanzamos abajo-dcha
            if (move(tablero, coord_x+1, coord_y+2, salto + 1)):
                return True

            # Backtraking
            tablero[coord_x][coord_y] = 0
            dibujar_tablero(tablero)
            return False

        else:
            return False

def main():
    tablero = crear_tablero()
    coord_x = random.randint(0, MAX_COLS - 1)
    coord_y = random.randint(0, MAX_FILS - 1)
    coord_x = 0
    coord_y = 0
    salto   = 0
    
    move(tablero, coord_x, coord_y, salto + 1)
    fin = input("Finalizar")

main()