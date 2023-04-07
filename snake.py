import time
import random
import turtle
retardo = 0.1
#pantalla

screen = turtle.Screen()
screen.title("Juego de la serpiente")
screen.bgcolor("Black")
screen.setup(width = 600, height = 600)
#para que se vea mejor
screen.tracer(0)

#CABEZA

cabeza = turtle.Turtle()
#para forzar que aparezca al principio
cabeza.speed(0)

cabeza.shape("square")
cabeza.color("Green")
#para que no deje traza detrás suya
cabeza.penup()

cabeza.goto(0, 0)
#para que aparezca parada
cabeza.direction = "stop"

#MANZANA

manzana = turtle.Turtle()
#para forzar que aparezca al principio
manzana.speed(0)

manzana.shape("circle")
manzana.color("Red")
#para que no deje traza detrás suya
manzana.penup()

manzana.goto(random.randint(-280,280), random.randint(-280,280))
#para que aparezca parada
manzana.direction = "stop"

#CUERPO

snake = []

#MARCADOR

Score = 0
High_Score = 0
texto = turtle.Turtle()
#para forzar que aparezca al principio
texto.speed(0)

texto.color("White")
#para que no deje rastro
texto.penup()

#para esconder el "cursor"
texto.hideturtle()
texto.goto(0,260)
#para escribir
texto.write("Score: " + str(Score) + " High Score: " + str(High_Score), align = "center", font = ("Courier", 24,))

#para cambiar las direcciones
def arriba():
    if cabeza.direction != "down":
        cabeza.direction = "up"
def abajo():
    if cabeza.direction != "up":
        cabeza.direction = "down"
def derecha():
    if cabeza.direction != "left":
        cabeza.direction = "right"
def izquierda():
    if cabeza.direction != "right":
        cabeza.direction = "left"


def mov():
    """Función que se encarga del movimiento de la cabeza"""
    if cabeza.direction == "up":
        y = cabeza.ycor()
        cabeza.sety(y + 20)
    if cabeza.direction == "down":
        y = cabeza.ycor()
        cabeza.sety(y - 20)
    if cabeza.direction == "right":
        x = cabeza.xcor()
        cabeza.setx(x + 20)
    if cabeza.direction == "left":
        x = cabeza.xcor()
        cabeza.setx(x - 20)    

#para la lectura de datos por teclado
screen.listen()
screen.onkeypress(arriba,"Up")
screen.onkeypress(abajo,"Down")
screen.onkeypress(izquierda,"Left")
screen.onkeypress(derecha,"Right")
while True:
    screen.update()
    #movimiento cuerpo
    longitud = len(snake)
    for a in range(longitud -1, 0, -1):
        x = snake[a - 1].xcor()
        y = snake[a - 1].ycor()
        snake[a].goto(x, y)
    if longitud > 0:
        x = cabeza.xcor()
        y = cabeza.ycor()
        snake[0].goto(x, y)

    mov()
    time.sleep(retardo)
    #comer manzana
    if cabeza.distance(manzana) < 20:
        manzana.goto(random.randint(-280,280), random.randint(-280,280))

        cuerpo = turtle.Turtle()
        #para forzar que aparezca al principio
        cuerpo.speed(0)

        cuerpo.shape("square")
        cuerpo.color("White")
        #para que no deje traza detrás suya
        cuerpo.penup()

        cuerpo.goto(0, 0)
        #para que aparezca parada
        cuerpo.direction = "stop"
        snake.append(cuerpo)
        Score += 10
        if Score > High_Score:
            High_Score = Score
        texto.clear()
        texto.write("Score: " + str(Score) + " High Score: " + str(High_Score), align = "center", font = ("Courier", 24,))
    #colisión pared
    if cabeza.xcor() > 290 or cabeza.ycor() > 290 or cabeza.xcor() < -290 or cabeza.ycor() < -290:
        time.sleep(1)
        cabeza.goto(0, 0)
        cabeza.direction = "stop"
        for a in snake:
            a.goto(1000, 1000)
        snake.clear()
        Score = 0
        texto.clear()
        texto.write("Score: " + str(Score) + " High Score: " + str(High_Score), align = "center", font = ("Courier", 24,))
    #colisión cuerpo
    for a in snake:
        if a.distance(cabeza) == 0:
            time.sleep(1)
            cabeza.goto(0, 0)
            cabeza.direction = "stop"
            for a in snake:
                a.goto(1000, 1000)
            snake.clear()
            Score = 0
            texto.clear()
            texto.write("Score: " + str(Score) + " High Score: " + str(High_Score), align = "center", font = ("Courier", 24,))