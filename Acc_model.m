
function [ay_meas,ay_bias] = Acc_model(x,u ,ay_bias, ay_noise, dt,params)
% Parameters
sigma_a = 0.1;        % Gauss-Markov noise std
tau_a = 0.05;         % correlation time
sigma_ba = 0.001;     % random walk bias

% Update GM noise
phi_a = exp(-dt/tau_a);
ay_noise = phi_a*ay_noise + sigma_a*sqrt(1-phi_a^2)*randn;

% Update bias (random walk)
ay_bias = ay_bias + sigma_ba*sqrt(dt)*randn;

% input x = [xy r psi cf cr]
vy =x(1);
r = x(2);
Cf = x(4);
Cr = x(5);

%   u = [vx; delta]    - inputs, Longtitudinal velocity, steering angle
vu = u(1); vu = (max(vu,1));
delta = u(2);

% params
m = params.m;
lf = params.lf;
lr = params.lr;

% True accelerations
alpha_F = (vy + lf*r)/vu - delta;
alpha_R = (vy - lr*r)/vu;

FyF = -Cf * alpha_F;
FyR = -Cr * alpha_R;

ay_true = (FyR + FyF*cos(delta))/m;

% Measured accelerations

ay_meas = ay_true + ay_noise + ay_bias;

end

