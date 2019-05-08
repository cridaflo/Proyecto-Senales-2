function [Y] = gauss(X, miu, cov)

    %Esta funcion genera las Gaussianas.

    [n,m] = size(X);
    e = (-1/2)*(X-miu)'*cov^(-1)*(X-miu);
    d1 = sqrt(det(cov));
    d2 = (2*pi)^(n/2);
    d = d1*d2;
    Y = exp(e)/d;
end

