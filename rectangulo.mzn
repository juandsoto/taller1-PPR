include "globals.mzn";

int: n = length(cuadrados);

% Parámetros
array[int] of int: cuadrados;
int: ancho;
int: alto;

% Variables
array[1..n] of var int: x;
array[1..n] of var int: y;

predicate solapar(int: i, int: j) =
  (((x[i] <= x[j]) /\ (x[j] < x[i] + cuadrados[i])) \/
   ((x[j] <= x[i]) /\ (x[i] < x[j] + cuadrados[j])))
  /\
  (((y[i] <= y[j]) /\ (y[j] < y[i] + cuadrados[i])) \/ 
  ((y[j] <= y[i]) /\ (y[i] < y[j] + cuadrados[j])));
  
predicate orden(int: i, int: j) =
  if cuadrados[i] = cuadrados[j] then 
    ((x[i] < x[j]) \/ ((x[i] = x[j]) /\ (y[i] < y[j]))) else true endif;
    
% Restricciones

constraint forall(i in 1..n)(x[i] >= 0 /\ x[i] <= ancho - cuadrados[i]);
constraint forall(i in 1..n)(y[i] >= 0 /\ y[i] <= alto - cuadrados[i]);

constraint sum(i in 1..n)(cuadrados[i]*cuadrados[i]) = ancho * alto;
  
constraint forall(i, j in 1..n where i < j)(not solapar(i, j));
  
constraint forall(i, j in 1..n where (i < j))(orden(i, j));

solve satisfy;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  