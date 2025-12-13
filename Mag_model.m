function psi_meas = Mag_model(psi_true,psi_bias, psi_noise, dt,Bn)
% MAGNETOMETER: Outputs measured heading angle
%
% Inputs:
%   psi_true - true yaw angle from bicycle model (rad)
%
% Output:
%   psi_meas - measured heading angle (rad)

% Parameters

sigma_noise = 0.01;
tau = 1;           % slower correlation
sigma_bias = 0.0005;

% Update Gauss-Markov noise
phi = exp(-dt/tau);
psi_noise = phi*psi_noise + sigma_noise*sqrt(1-phi^2)*randn;

% Update bias (random walk)
psi_bias = psi_bias + sigma_bias*sqrt(dt)*randn;


Bx = Bn(1);  By = Bn(2);

c = cos(psi_true); s = sin(psi_true);
Bbx =  c*Bx + s*By;
Bby = -s*Bx + c*By;

psi_from_mag = atan2(-Bby, Bbx);


% Measured heading
psi_meas = wroptoPI(psi_from_mag + psi_noise + psi_bias);

end


