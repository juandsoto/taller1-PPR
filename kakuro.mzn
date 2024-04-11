include "globals.mzn"; 

% NOTA: El resultado en consola saldrá en un tablero cuadrado, si el tablero de entrada no es cuadrado, el programa llenará la fila/columna adicional con ceros.

% Cantidad de resultados objetivo
set of int: Results = index_set_1of2(kakuro);
% Cantidad de resultados objetivo
set of int: Hints = index_set_2of2(kakuro);
% Máximo de números a sumar para llegar a un resultado
int: MAX_HINTS = (max(Hints) - 1) div 2;

% Parámetros
int: n; % lado mas largo del tablero (ancho o largo) del tablero, no se incluye la primer fila/columna
array[int, int] of int: kakuro;
array[int] of 1..n: blanks;


% Variables
array[1..n, 1..n] of var 0..9: x;


% Restricciones
constraint forall(i in 1..length(blanks) div 2) (
  x[ blanks[2*(i-1)+1], blanks[2*(i-1)+2]] = 0
);

constraint forall(p in Results) (
  (sum(i in 1..MAX_HINTS where kakuro[p,2*(i-1)+1] > 0)(
    x[  kakuro[p, 2*(i-1)+1], kakuro[p,2*(i-1)+2]  ]) = kakuro[p, max(Hints)]
  )
  /\
  all_different(i in 1..MAX_HINTS where kakuro[p,2*(i-1)+1] > 0) (
  x[kakuro[p, 2*(i-1)+1], kakuro[p, 2*(i-1)+2]]
  )
  /\
  forall(i in 1..MAX_HINTS where kakuro[p,2*(i-1)+1] > 0) (
  x[kakuro[p, 2*(i-1)+1], kakuro[p, 2*(i-1)+2]] > 0
  )
);

solve :: int_search([x[i,j] | i,j in 1..n], first_fail, indomain_min, complete) satisfy;

output [
  if j = 1 then "\n" else " " endif ++
    show(x[i,j])
  | i,j in 1..n
];
