clc
clear all;
[A, b,~] = gendata_lasso(50,200,0,0);
[m, n] = size(A);
lambda = 20;

%sigmas = linspace(0.01,0.08,15);
sigmas = linspace(0.01,0.16,30);
%sigmas = linspace(0.1,0.8,15);
f = fopen('Q4log.txt','w');

for i=1:numel(sigmas)
   sigma = sigmas(i);
   b_noise = b + sigma * randn( length(b),1);
   
   cvx_clear
   cvx_begin quiet 
      variable x(n)  
      minimize( 0.5*sum_square(A*x-b_noise))
   cvx_end
   xols = x;
   
   cvx_clear
   cvx_begin quiet 
      variable x(n)  
      minimize( 0.5*sum_square(A*x-b_noise) + lambda*sum_square(x))
   cvx_end
   xl2 = x;
   
   cvx_clear
   cvx_begin quiet 
      variable x(n)  
      minimize( 0.5*sum_square(A*x-b_noise) + lambda*norm(x,1))
   cvx_end
   xl1 = x;
   
   fprintf(f,'%e %e %e %e\n',sigma,rmse(A*xols,b_noise),rmse(A*xl2,b_noise),rmse(A*xl1,b_noise));

end
fclose(f);