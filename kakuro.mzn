% The solution:
%   9 7 0 0 8 7 9
%   8 9 0 8 9 5 7
%   6 8 5 9 7 0 0
%   0 6 1 0 2 6 0
%   0 0 4 6 1 3 2
%   8 9 3 1 0 1 4
%   3 1 2 0 0 2 1
% http://en.wikipedia.org/wiki/File:Kakuro_black_box.svg

include "globals.mzn"; 
int: n = 7;
array[1..n, 1..n] of var 0..9: x;

%int: num_p = 24;
%int: num_hints = 5;

set of int: num_p = index_set_1of2(kakuro);

set of int: num_hints = index_set_2of2(kakuro);

array[int, int] of int: kakuro;

array[int] of 1..n: blanks;

solve :: int_search([x[i,j] | i,j in 1..n], first_fail, indomain_max, complete) satisfy;

constraint
 
  forall(i in 1..length(blanks) div 2) (
        x[ blanks[2*(i-1)+1], blanks[2*(i-1)+2]] = 0
  )
  /\
  %FIX: change 1..5 for dynamic expression as well as 11 number
  forall(p in num_p) (
    (sum(i in 1..5 where kakuro[p,2*(i-1)+1] > 0) (x[  kakuro[p, 2*(i-1)+1], kakuro[p,2*(i-1)+2]  ]) = kakuro[p, 11])
    /\
      %FIX: change 1..5 for dynamic expression
    all_different(i in 1..5 where kakuro[p,2*(i-1)+1] > 0) (
        x[kakuro[p, 2*(i-1)+1], kakuro[p, 2*(i-1)+2]]
    )
   /\
     %FIX: change 1..5 for dynamic expression
   forall(i in 1..5 where kakuro[p,2*(i-1)+1] > 0) (
        x[kakuro[p, 2*(i-1)+1], kakuro[p, 2*(i-1)+2]] > 0
   )
  )
;

output [
  if j = 1 then "\n" else " " endif ++
    show(x[i,j])
  | i,j in 1..n
];