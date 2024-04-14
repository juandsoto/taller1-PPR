include "globals.mzn";

% Parámetros
array[1..9, 1..9] of int: sudoku_inicial;

% Variables
array[1..9, 1..9] of var 1..9: sudoku;

% Restricciones

% Asignación de valores iniciales al tablero
constraint forall(i, j in 1..9 where sudoku_inicial[i,j] != 0) (
    sudoku[i, j] = sudoku_inicial[i, j]
);

% filas y columnas
constraint forall(i in 1..9) (
    all_different([sudoku[i, j] | j in 1..9]) /\
    all_different([sudoku[j, i] | j in 1..9])
);

% cuadrículas 9x9
constraint forall(row_offset, col_offset in 0..2) (
    all_different([sudoku[i, j] | 
        i in (1 + 3*row_offset)..(3 + 3*row_offset), 
        j in (1 + 3*col_offset)..(3 + 3*col_offset)])
);

%solve :: int_search(sudoku, smallest, indomain_random) satisfy;

solve :: int_search(sudoku, first_fail, indomain_random) satisfy;

output [
    if j = 9 then show(sudoku[i, j]) ++ "\n" else show(sudoku[i, j]) ++ " " endif
    | i, j in 1..9
];
