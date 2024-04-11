include "globals.mzn";

array[int] of int: l;
int: n = length(l);
int: anchoRec;
int: altoRec;

array[1..n] of var int: x;
array[1..n] of var int: y;

constraint forall(i in 1..n)(x[i] >= 0 /\ x[i] <= anchoRec - l[i]);
constraint forall(i in 1..n)(y[i] >= 0 /\ y[i] <= altoRec - l[i]);

predicate sobreponen(int: i, int: j) =
  (((x[i] <= x[j]) /\ (x[j] < x[i] + l[i])) \/ ((x[j] <= x[i]) /\ (x[i] < x[j] + l[j])))
  /\
  (((y[i] <= y[j]) /\ (y[j] < y[i] + l[i])) \/ ((y[j] <= y[i]) /\ (y[i] < y[j] + l[j])));
  
%no sobreposicion de ningun cuadrado
constraint forall(i, j in 1..n where i < j)(not sobreponen(i, j));

%Los cuadrados rellenan el rectangulo
constraint sum(i in 1..n)(l[i]*l[i]) = anchoRec * altoRec;

%Eliminacion de simetrias
predicate orden(int: i, int: j) =
  if l[i] = l[j] then ((x[i] < x[j]) \/ ((x[i] = x[j]) /\ (y[i] < y[j]))) else true endif;
  
constraint forall(i, j in 1..n where (i < j))(orden(i, j));

solve satisfy;
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  