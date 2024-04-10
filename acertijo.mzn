set of string: Nombre = {"Juan", "Oscar", "Dario"};
set of string: Apellido = {"Gonzalez", "Garcia", "Lopez"};
set of string: Musica = {"Clasica", "Pop", "Jazz"};

% Variables
array[1..3] of string: nombres;
array[1..3] of string: apellidos;
array[1..3] of string: musicas;
array[1..3] of var 24..26: edades;
  
% Restricciones
constraint forall(i in 1..3) (nombres[i] in Nombre);
constraint forall(i in 1..3) (apellidos[i] in Apellido);
constraint forall(i in 1..3) (musicas[i] in Musica);

constraint all_different(nombres); % Cada amigo tiene un nombre diferente
constraint all_different(apellidos); % Cada amigo tiene un apellido diferente
constraint all_different(musicas); % Cada amigo tiene un tipo de música diferente

constraint forall(i in 1..3) (nombres[i] = "Juan" /\ apellidos[i] != "Gonzalez");

solve satisfy;

output [show(nombres[i]) ++ show(apellidos[i]) ++ " tiene" ++ show(edades[i]) ++ " años y le gusta la música " ++ show(musicas[i]) ++ "\n" | i in 1..3];

