function Error = fogmProcess(dt,sigma, tau, prevErr)
% This function generates a First-Order Gaussian Markov Process

a = exp(-dt/tau);
b = sigma.*sqrt(1 - a^2);
Error = a.*prevErr + b.*randn(3,1);


end