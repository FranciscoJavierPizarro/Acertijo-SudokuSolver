
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;           MODULO MAIN           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmodule MAIN 
	(export deftemplate nodo casilla)
	(export deffunction heuristica)
)

(deftemplate MAIN::nodo
   (multislot estado)
   (multislot camino)
   (slot coste (default 0))
   (slot heuristica)
   (slot clase (default abierto))
   (multislot estadosRecorridos))

(defglobal MAIN
   ?*estado-inicial* = (create$ B B B H V V V)
   ?*estado-final* = (create$ V V V H B B B))


(deffunction MAIN::heuristica ($?estado)
   (bind ?res 0)
   (loop-for-count (?i 1 7)
    (if (neq (nth$ ?i $?estado)
             (nth$ ?i ?*estado-final*))
         then (bind ?res (+ ?res 1))
     )
    )
   ?res)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     MODULO MAIN::INICIAL        ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule MAIN::inicial
   =>
   (assert (nodo 
              (estado ?*estado-inicial*)
              (camino)
              (clase abierto)
              (heuristica (heuristica ?*estado-inicial*))
              (estadosRecorridos)))
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MODULO MAIN::CONTROL            ;;;
;;; A*                             ;;;
;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;


;(defrule MAIN::pasa-el-mejor-a-cerrado-CU
;	?nodo <- (nodo (coste ?c1)
;			(clase abierto)
;		 )
;	(not (nodo (clase abierto)
;		    (coste ?c2&:(< ?c2 ?c1))
;	     )
;	)
;	=>
;	(modify ?nodo (clase cerrado))
;	(focus OPERADORES)
;)

(defrule MAIN::pasa-el-mejor-a-cerrado-A*
	?nodo <- (nodo (heuristica ?h1)
			(coste ?c1)
			(clase abierto)
		 )
	(not (nodo (clase abierto)
			(heuristica ?h2)
			(coste ?c2&:(< (+ ?c2 ?h2) (+ ?c1 ?h1)))
	     )
	)
	=>
	(modify ?nodo (clase cerrado))
	(focus OPERADORES)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MODULO MAIN::OPERACIONES        ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (defmodule OPERADORES
   (import MAIN deftemplate nodo)
   (import MAIN deffunction heuristica))

(defrule OPERADORES::moverHueco1Izqd
   (nodo (estado $?a ?b H $?c)
          (camino $?movimientos)
          (coste ?cos)
          (estadosRecorridos $?nods)
          (clase cerrado))
=>
   (bind $?nuevo-estado (create$  $?a H ?b $?c))
   (assert (nodo 
		      (estado $?nuevo-estado)
              (camino $?movimientos "<")
              (estadosRecorridos $?nods S (create$ $?a ?b H $?c))
              (coste (+ ?cos 1))
              (heuristica (heuristica $?nuevo-estado))
              )))

(defrule OPERADORES::moverHueco2Izqd
   (nodo (estado $?a ?b ?c H $?d)
          (camino $?movimientos)
          (coste ?cos)
          (estadosRecorridos $?nods)
          (clase cerrado))
=>
   (bind $?nuevo-estado (create$  $?a H ?c ?b $?d))
   (assert (nodo 
		      (estado $?nuevo-estado)
              (camino $?movimientos "<<")
              (estadosRecorridos $?nods S (create$ $?a ?b ?c H $?d))
              (coste (+ ?cos 2))
              (heuristica (heuristica $?nuevo-estado))
              )))
            
(defrule OPERADORES::moverHueco3Izqd
   (nodo (estado $?a ?b ?c ?d H $?e)
          (camino $?movimientos)
          (coste ?cos)
          (estadosRecorridos $?nods)
          (clase cerrado))
=>
   (bind $?nuevo-estado (create$  $?a H ?c ?d ?b $?e))
   (assert (nodo 
		      (estado $?nuevo-estado)
              (camino $?movimientos "<<<")
              (estadosRecorridos $?nods S (create$ $?a ?b ?c ?d H $?e))
              (coste (+ ?cos 3))
              (heuristica (heuristica $?nuevo-estado))
              )))


(defrule OPERADORES::moverHueco1Dech
   (nodo (estado $?a H ?b $?c)
          (camino $?movimientos)
          (coste ?cos)
          (estadosRecorridos $?nods)
          (clase cerrado))
=>
   (bind $?nuevo-estado (create$  $?a ?b H $?c))
   (assert (nodo 
		      (estado $?nuevo-estado)
              (camino $?movimientos ">")
              (estadosRecorridos $?nods S (create$ $?a H ?b $?c))
              (coste (+ ?cos 1))
              (heuristica (heuristica $?nuevo-estado))
              )))


(defrule OPERADORES::moverHueco2Dech
   (nodo (estado $?a H ?b ?c $?d)
          (camino $?movimientos)
          (coste ?cos)
          (estadosRecorridos $?nods)
          (clase cerrado))
=>
   (bind $?nuevo-estado (create$  $?a ?c ?b H $?d))
   (assert (nodo 
		      (estado $?nuevo-estado)
              (camino $?movimientos ">>")
              (estadosRecorridos $?nods S (create$ $?a H ?b ?c $?d))
              (coste (+ ?cos 2))
              (heuristica (heuristica $?nuevo-estado))
              )))

(defrule OPERADORES::moverHueco3Dech
   (nodo (estado $?a H ?b ?c ?d $?e)
          (camino $?movimientos)
          (coste ?cos)
          (estadosRecorridos $?nods)
          (clase cerrado))
=>
   (bind $?nuevo-estado (create$  $?a ?d ?b ?c H $?e))
   (assert (nodo 
		      (estado $?nuevo-estado)
              (camino $?movimientos ">>>")
              (estadosRecorridos $?nods S (create$ $?a H ?b ?c ?d $?e))
              (coste (+ ?cos 3))
              (heuristica (heuristica $?nuevo-estado))
              )))


;-------------------------------------------------------------
; MODULO RESTRICCIONES
;-------------------------------------------------------------
; Nos quedamos con el nodo de menor coste
; Soluci�n v�lida si el coste de cada operador es 1.

(defmodule RESTRICCIONES
   (import MAIN deftemplate nodo))
 
; eliminamos nodos repetidos (Falta eliminar los de igual coste -INTENTALO)
(defrule RESTRICCIONES::repeticiones-de-nodo
	(declare (auto-focus TRUE))
      ?nodo1 <- (nodo (estado $?estado) (camino $?camino1))
      ?nodo2 <- (nodo (estado $?estado) 
        (camino $?camino2&:(>= (length$ ?camino1) (length$ ?camino2))))
      (test (neq ?nodo1 ?nodo2))
 =>
   (retract ?nodo1))

(defrule RESTRICCIONES::repeticiones-de-nodoCoste
	(declare (auto-focus TRUE))
      ?nodo1 <- (nodo (estado $?estado) (coste ?coste1) (camino $?camino1))
      ?nodo2 <- (nodo (estado $?estado) 
      (coste ?coste2&:(>= ?coste1 ?coste2))
      (camino $?camino2&:(neq ?camino1 ?camino2))
      )
      (test (neq ?nodo1 ?nodo2))
 =>
   (retract ?nodo1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;    MODULO MAIN::SOLUCION        ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmodule SOLUCION
   (import MAIN deftemplate nodo))

(defrule SOLUCION::reconoce-solucion
   (declare (auto-focus TRUE))
   ?nodo <- (nodo (estado V V V H B B B)
               (camino $?movimientos)
               (estadosRecorridos $?estados))
 => 
   (retract ?nodo)
   (assert (solucion $?movimientos Z $?estados S)))

(defrule SOLUCION::escribe-solucion
   (solucion $?movimientos Z $?estados)
  =>
   (printout t "La solucion tiene " (length$ $?movimientos) " pasos"crlf)
   (printout t "Solucion:" $?movimientos crlf)
   (loop-for-count (?i 1 (length$ $?estados))
    

    (if (neq (nth$ ?i $?estados) S)
         then (printout t (nth$ ?i ?estados) " ")
         else (printout t crlf)
     ) 
    )
    (printout t "V V V H B B B" crlf)
   (halt))

;(watch facts)
;(watch rules)
;(watch activations)
;(run)
(watch statistics)
