include "globals.mzn";

int: n;

set of int: Persona = 1..n;

%array[Persona] of var string: fila;

array[Persona] of string: personas;
array[int, 1..2] of int: next;
array[int, 1..2] of int: separate;
array[int, 1..3] of int: distance;

array[Persona] of var Persona: fila;

constraint forall(i in 1..length(next) div 2)(
  forall(x in 1..n)(
    if fila[x] = next[i,1] then (x < n /\ fila[x+1] = next[i,2]) \/ (x > 1 /\ fila[x-1] = next[i,2]) endif
  )
);

constraint all_different(fila);

solve satisfy;

output [show(fila)];














