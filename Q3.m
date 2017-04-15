clc
clear all
%[A, b] = gendata_lasso();
[A, b] = gendata_lasso(50,200,0,0);
[m, n] = size(A);
lambdas = linspace(0,100,101);

idx = randi([1,n],10,1);

f = fopen('Q3log.txt','w');
fprintf(f,'(lambda,c^Tx,x*i1,x*i2,x*i3,x*i4,x*i5,x*i6,x*i7,x*i8,x*i9,x*i10)\n');
for i=1:numel(lambdas)
    lambda = lambdas(i);
    
    cvx_begin %quiet 
      variable x(n)  
      minimize( 0.5*sum_square(A*x-b) + lambda*sum_square(x))
    cvx_end
    xidx = x(idx);
    fprintf(f,'(%e, %e',lambda, rmse(A*x,b));
    for j=1:10
        fprintf(f,', %e',x(idx(j)));
    end
    fprintf(f,')\n');
end
fprintf(f,'\n\n');
fprintf(f,'(lambda,c^Tx,hatxi1,hatxi2,hatxi3,hatxi4,hatxi5,hatxi6,hatxi7,hatxi8,hatxi9,hatxi10)\n');
for i=1:numel(lambdas)
    lambda = lambdas(i);
    
    cvx_begin %quiet 
      variable x(n)  
      minimize( 0.5*sum_square(A*x-b) + lambda*norm(x,1))
    cvx_end
    xidx = x(idx);
    fprintf(f,'(%e, %e',lambda, rmse(A*x,b));
    for j=1:10
        fprintf(f,', %e',x(idx(j)));
    end
    fprintf(f,')\n');
end
fclose(f);