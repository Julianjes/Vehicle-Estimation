function [r_meas,r_bias,r_noise] = Gyro_model(r_true, r_bias, r_noise, dt)
% Inputs:
% r_true: true yaw rate
% r_bias: previous bias
% r_noise: previous Gauss-Markov noise
% dt: timestep

% Parameters
sigma_noise = 0.002;    % steady-state std of GM noise
tau = 0.1;              % correlation time
sigma_bias = 0.0001;    % random walk bias std

% Gauss-Markov update
phi = exp(-dt / tau);
r_noise = phi*r_noise + sigma_noise*sqrt(1-phi^2)*randn;

% Random walk bias update
r_bias = r_bias + sigma_bias*sqrt(dt)*randn;

% Measured yaw rate
r_meas = r_true + r_noise + r_bias;

end

