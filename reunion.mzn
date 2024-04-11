include "globals.mzn";

int: n = length(personas);
set of int: next_half = 1..length(next) div 2;
set of int: separate_half = 1..length(separate) div 2;
set of int: distance_third = 1..length(distance) div 3;
set of int: Persona = 1..n;

array[int] of string: personas;
array[int, 1..2] of int: next;
array[int, 1..2] of int: separate;
array[int, 1..3] of int: distance;

array[Persona] of var Persona: fila;

constraint forall(i in next_half)(
  forall(x in 1..n)(
    if fila[x] = next[i,1] then (x < n /\ fila[x+1] = next[i,2]) \/ (x > 1 /\ fila[x-1] = next[i,2]) endif
  )
);

constraint forall(i in separate_half)(
  forall(x in 1..n)(
    if fila[x] = separate[i,1] then (x < n /\ fila[x+1] != separate[i,2]) /\ (x > 1 /\ fila[x-1] != separate[i,2]) endif
  )
);

constraint forall(i in distance_third)(
  forall(x in 1..n)(
    if fila[x] = distance[i,1] then (x < n /\ fila[x+1] != distance[i,2]) /\ (x > 1 /\ fila[x-1] != distance[i,2]) endif
  )
);

constraint forall(i in distance_third)(
  forall(x in 1..n)(
    if fila[x] = distance[i,1] then
      (forall(y in x+distance[i,3]+2..n)(fila[x+1] != distance[i,2] /\ fila[y] != distance[i,2])) /\
      (forall(y in 1..x-distance[i,3]-2)(fila[x-1] != distance[i,2] /\ fila[y] != distance[i,2]))
    endif
  )
);

constraint all_different(fila);

solve satisfy;

% Otra salida
output [ "-----------\n" ];
output ["personas = [" ];
output [personas[fix(fila[i])] ++ ", " | i in 1..n-1];
output [personas[fix(fila[n])] ++ ""];
output [ "] \n\n" ];
output ["next = [" ];
output [" " ++ personas[next[i,1]] ++ " y " ++ personas[next[i,2]] ++ "," | i in next_half];
output [ "] \n" ];
output ["separate = [" ];
output [" " ++ personas[separate[i,1]] ++ " y " ++ personas[separate[i,2]] ++ "," | i in separate_half];
output [ "] \n" ];
output ["distance = [" ];
output [" " ++ personas[distance[i,1]] ++ " y " ++ personas[distance[i,2]] ++ ", M=\(distance[i,3])" ++ "," | i in distance_third];
output [ "] \n" ];











