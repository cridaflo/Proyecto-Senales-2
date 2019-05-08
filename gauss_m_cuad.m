function [Y] = gauss_m_cuad(X, mius, covs, alphas, cuad, fact)
 %la funcion cuadratica es de la forma x'*A*x+x'*B+C
 %Esta funcion retorna la suma de Gaussianas y la cuadratica. Esto es
 %equivalente al escenario.
 
 A = cuad{1};
 B = cuad{2};
 C = cuad{3};
 Q2 = X'*A*X+X'*B+C;
 Y = gauss_m(X,mius, covs, alphas)+fact*Q2;
end


