int: n = 7;
array[0..n-1] of var 0..n: x;

constraint forall(i in 0..n-1) (
   x[i] = (sum(j in 0..n-1)(bool2int(x[j] = i))));

constraint sum(i in 0..n-1)(x[i]) = n;

%constraint (-1 * x[0]) + sum(i in 1..n-2)(x[i]) + ((n-2) * x[n-1]) = 0;
%constraint sum([ (i-1) * x[i] | i in 1..n-1 ]) = 0;

solve satisfy;   

output [ "x = \(x);\n" ] ;
