--Este programa resuelve el problema de los misioneros y los canibales.
--En dicho problema los 3 misioneros y los 3 caníbales parten de la misma orilla de un rio y deben cruzarlo,
--la barca solo permite que se monten en ella 2 personas,
--si en alguna orilla del rio hay mas caníbales que misioneros(tiene que haber misioneros para que pase),
--los caníbales se comen a los misioneros.
--El dato estado contiene un contador de los misioneros y los caníbales en la orilla izquierda y la posición
--de la barca(true = orilla izquierda)

module Main where

import Graph
import Data.List
import System.CPUTime

data State = State { misioneros::Int, canibales::Int, barca::Bool}-- true cuando lado  barca = izqd(origen)
    deriving Eq

instance Show State where
    show (State a b c) = show (a,b,c)

g :: Graph State

ini = State 3 3 True
fin = State 0 0 False

pth = sortOn length (paths g ini fin)
corto = head $ shortest pth
interpretacion = interpretar corto
interpretar :: [State] -> String
interpretar ([]) = ""
interpretar (t:[]) = ""
interpretar (a:b:t) = (significado a b) ++ "  " ++ show(b) ++ "\n" ++ interpretar ([b] ++ t)

significado :: State -> State -> String
significado a@(State aa ab alado) b@(State ba bb blado)
    | aa == (ba + 1) && ab == bb && alado == True = "Un misionero ha cruzado el rio de izquierda a derecha"
    | aa == (ba + 2) && ab == bb && alado == True = "Dos misionero han cruzado el rio de izquierda a derecha"
    | aa == (ba + 1) && ab == (bb + 1) && alado == True = "Un misionero y un caníbal han cruzado el rio de izquierda a derecha"
    | aa == ba && ab == (bb + 1) && alado == True = "Un caníbal ha cruzado el rio de izquierda a derecha"
    | aa == ba && ab == (bb + 2) && alado == True = "Dos caníbales han cruzado el rio de izquierda a derecha"
    | (aa + 1) == ba && ab == bb && alado == False = "Un misionero ha cruzado el rio de derecha a izquierda"
    | (aa + 2) == ba && ab == bb && alado == False = "Dos misionero han cruzado el rio de derecha a izquierda"
    | (aa + 1) == ba && (ab + 1) == bb && alado == False = "Un misionero y un caníbal han cruzado el rio de derecha a izquierda"
    | aa == ba && (ab + 1) == bb && alado == False = "Un caníbal ha cruzado el rio de derecha a izquierda"
    | aa == ba && (ab + 2) == bb && alado == False = "Dos caníbales han cruzado el rio de derecha a izquierda"



main = do
        putStrLn ("inicio: " ++ show ini)
        putStrLn ("fin: " ++ show fin)
        t0 <- getCPUTime
        putStrLn ("soluciones: " ++ show (length pth))
        t1 <- getCPUTime
        putStrLn "longitudes: "
        print (map length pth)
        putStrLn "solución más corta: "
        print $ corto
        putStrLn "Interpretación: "
        putStr(interpretacion)
        putStrLn "Tiempo: "
        print $ div (t1-t0) 1000000000

g = Graph estoNoHaceFalta succ
  where
    estoNoHaceFalta = ini
    succ :: Graph State -> State -> [State]
    succ _ here@(State a b lado) 
        = delete here $ valid $ nub $ (mov1MisI ++ mov2MisI ++ mov1Mis1CanI ++ mov1CanI ++ mov2CanI ++ mov1MisD ++ mov2MisD ++ mov1Mis1CanD ++ mov1CanD ++ mov2CanD)
        where
            legalMove :: State -> Bool
            legalMove here@(State a b lado)
                | (a >= b || a == 0) && ((3 - a) >= (3 - b) || (3 - a) == 0) = True
                | otherwise = False
            valid :: [State] -> [State]
            valid ([]) = []
            valid (t:[])
                | (legalMove t) = [t]
                | otherwise = []
            valid l@(h:t)
                | (legalMove h) = [h] ++ (valid t)
                | otherwise = (valid t)
            mov1MisI
                | lado == True && a > 0 = [State (a-1) b False]
                | otherwise = []
            mov2MisI
                | lado == True && a > 1 = [State (a-2) b False]
                | otherwise = []
            mov1Mis1CanI
                | lado == True && a > 0 && b > 0 = [State (a-1) (b-1) False]
                | otherwise = []
            mov1CanI
                | lado == True && b > 0 = [State a (b-1) False]
                | otherwise = []
            mov2CanI
                | lado == True && b > 1 = [State a (b-2) False]
                | otherwise = []
            mov1MisD
                | lado == False && a < 3 = [State (a+1) b True]
                | otherwise = []
            mov2MisD
                | lado == False && a < 2 = [State (a+2) b True]
                | otherwise = []
            mov1Mis1CanD
                | lado == False && a < 3 && b < 3 = [State (a+1) (b+1) True]
                | otherwise = []
            mov1CanD
                | lado == False && b < 3 = [State a (b+1) True]
                | otherwise = []
            mov2CanD
                | lado == False && b < 2 = [State a (b+2) True]
                | otherwise = []          