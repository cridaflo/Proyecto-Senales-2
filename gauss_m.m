function [rta] = gauss_m(X, mius, covs, alphas)
    %Esta funcion realiza la suma de todas las Gaussianas indicadas por la
    %escena.

    [m,n] = size(mius);
    rta = 0;
    for i = 1:n
        rta = rta+(alphas(i)*gauss(X,mius{i}, covs{i}));
    end
end

