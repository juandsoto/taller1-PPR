include "globals.mzn";

set of int: Persona = 1..3;
set of int: Edad = 24..26;

% Variables

var Edad: Oscar;
var Edad: Dario;
var Edad: Juan;
var Edad: Lopez;
var Edad: Garcia;
var Edad: Gonzalez;
var Edad: Clasica;
var Edad: Jazz;
var Edad: Pop;

array[Persona] of var Edad: nombres = [Oscar, Dario, Juan];
array[Persona] of var Edad: apellidos = [Lopez, Garcia, Gonzalez];
array[Persona] of var Edad: musicas = [Clasica, Jazz, Pop];

% Restricciones

constraint all_different(nombres) /\ all_different(apellidos) /\ all_different(musicas);
  
% Juan es mas viejo que Gonzalez, a Gonzalez le gusta la musica clasica.
constraint Juan > Gonzalez /\ Gonzalez = Clasica;

% El fan de la música pop, que no es Garcia, no tiene 24.
constraint Pop != Garcia /\ Pop != 24;

% Oscar, quien no es Lopez, tiene 25.
constraint Oscar != Lopez /\ Oscar = 25;

% La música favorita de Darío no es el jazz.
constraint Dario != Jazz;

solve satisfy;

output [
    "[Oscar, Dario, Juan]", " - ", show(nombres), "\n",
    "[Lopez, Garcia, Gonzalez]", " - ", show(apellidos), "\n",
    "[Clasica, Jazz, Pop]", " - ", show(musicas), "\n"
];

% LA SOLUCION ES:

% Dario Gonzalez, 24, clasica
% Oscar Garcia, 25, jazz
% Juan Lopez, 26, pop



