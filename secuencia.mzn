% Parámetros
int: n;

% Variables
array[0..n-1] of var 0..n-1: x;

% Restricciones

constraint forall(i in 0..n-1) (
   x[i] = sum(j in 0..n-1)(x[j] = i));

% Restricciones redundantes
constraint sum(i in 0..n-1)(x[i]) = n;

constraint sum(i in 0..n-1)(x[i] * (i - 1)) = 0;

%solve :: int_search(x, input_order, indomain_min) satisfy;

solve :: int_search(x, input_order, indomain_max) satisfy;

output [ "\(n) = \(x)\n" ] ;
