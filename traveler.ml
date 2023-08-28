(******************************************************************************)
(*                                                                            *)
(*     Problema del Viajero resuelto con algoritmo A*                         *)
(*                                                                            *)
(*     El siguiente problema resuelve el problema del viajero en el que se    *)
(*     busca la ruta óptima hacia Bucarest, para ello se emplea un algoritmo  *)
(*     de búsqueda informada A estrella                                       *)
(*     Para compilar ejecutar: ocamlc traveler.ml -o traveler                 *)
(*                                                                            *)
(******************************************************************************)

let ciudades = [
  ("Arad",366);
  ("Bucarest",0);
  ("Craiova",160);
  ("Drobeta",242);
  ("Eforie",161);
  ("Fagaras",176);
  ("Giurgiu",77);
  ("Hirsova",151);
  ("Iasi",226);
  ("Lugoj",244);
  ("Mehadia",241);
  ("Neamt",234);
  ("Oradea",380);
  ("Pitesti",100);
  ("Rimnieu",193);
  ("Sibiu",253);
  ("Timisoara",329);
  ("Urziceni",80);
  ("Vaslui",199);
  ("Zerind",374)
];;

let relacionesCiudades = [
("Oradea","Zerind",71);
("Oradea","Sibiu",151);
("Zerind","Arad",75);
("Arad","Sibiu",140);
("Arad","Timisoara",118);
("Timisoara","Lugoj",111);
("Lugoj","Mehadia",70);
("Mehadia","Drobeta",75);
("Drobeta","Craiova",120);
("Sibiu","Fagaras",99);
("Sibiu","Rimnieu",80);
("Fagaras","Bucarest",211);
("Rimnieu","Craiova",146);
("Rimnieu","Pitesti",97);
("Craiova","Pitesti",138);
("Pitesti","Bucarest",101)
];;

let custom_min nodo1 nodo2 =
  let (_, _, _, v1,_) = nodo1 in
  let (_, _, _, v2,_) = nodo2 in
  if v1 < v2 then nodo1 else nodo2;;

let chooseBest nodos = 
  match nodos with
  | [] -> failwith "No quedan nodos por expandir."
  | _ -> List.fold_left custom_min (List.hd nodos) nodos;;

let addNewPaths relacionesNodos nuevoNodo = 
  let (nodo, _, coste_previo, _, old_path) = nuevoNodo in
  let nuevos_caminos = List.filter (fun (str1, str2, _) -> str1 = nodo || str2 = nodo) relacionesNodos in 
  List.map
    (fun (nodo1, nodo2, d) ->
      
      let nombreNodoTemporal =
        if nodo1 = nodo then nodo2
        else nodo1
      in
      
      let v_h = List.assoc nombreNodoTemporal ciudades in
      let v_g = coste_previo + d in
      let new_path = old_path ^"=>"^nombreNodoTemporal in
      Printf.printf "Nuevo nodo %s h:%i g:%i f:%i\n" nombreNodoTemporal v_h v_g (v_h + v_g);
      (nombreNodoTemporal, v_h, v_g, v_h + v_g, new_path))
    nuevos_caminos
;;
  
let rec completeProc nodos =
  match nodos with
  | [] -> failwith "No se encontró una solución."
  | _ ->
    let mejorNodo = chooseBest nodos in
    let (_, v_h, coste, _, path) = mejorNodo in 
    if v_h = 0 then Printf.printf "Búsqueda completada. Camino final: %s. Coste final: %d\n" path coste
    
    else
      let (nombreNodo, _, _, v_f, _) = mejorNodo in
      Printf.printf "Siguiente ciudad %s %i\n" nombreNodo v_f;
      let nodosNoUsados = List.filter (fun nodo -> nodo <> mejorNodo) nodos in
      let nuevosNodos = addNewPaths relacionesCiudades mejorNodo in
      completeProc (nuevosNodos @ nodosNoUsados);;

let () =
  let startNode = ("Arad", 366, 0, 366, "Arad") in
  completeProc [startNode];
;;