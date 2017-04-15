clc
clear all

[A, b] = gendata_lasso(2500,500,0,0);
[m, n] = size(A);

cvx_clear

lambda = 10;

diary('Q2log.txt')
diary on
cvx_clear
cvx_begin 
  variable x(n)  
  minimize( 0.5*sum_square(A*x-b) )
cvx_end

cvx_clear
cvx_begin 
  variable x(n)  
  minimize( 0.5*sum_square(A*x-b) + lambda*sum_square(x))
cvx_end

cvx_clear
cvx_begin 
  variable x(n)  
  minimize( 0.5*sum_square(A*x-b) + lambda*norm(x,1))
cvx_end

diary off