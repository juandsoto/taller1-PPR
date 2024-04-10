include "globals.mzn";

array[1..9, 1..9] of var 1..9: board;

array[1..9, 1..9] of int: initial_board;

% Asignación de valores iniciales al tablero
constraint forall(i, j in 1..9 where initial_board[i,j] != 0) (
    board[i, j] = initial_board[i, j]
);

% filas y columnas
constraint forall(i in 1..9) (
    all_different([board[i, j] | j in 1..9]) /\ % Restricción para filas
    all_different([board[j, i] | j in 1..9])    % Restricción para columnas
);

% cuadrículas 9x9
constraint forall(row_offset, col_offset in 0..2) (
    all_different([board[i, j] | 
        i in (1 + 3*row_offset)..(3 + 3*row_offset), 
        j in (1 + 3*col_offset)..(3 + 3*col_offset)])
);

solve satisfy;

output [
    if j = 9 then show(board[i, j]) ++ "\n" else show(board[i, j]) ++ " " endif
    | i, j in 1..9
];
