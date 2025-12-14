function [variable_eci] = C_ecef2eciMatrix(variable_ecef,t)
% Function used to convert a generic variable (ie. position
% magn field, etc.) from ecef frame to ned frame

omega_ie = 7.292115E-5;  % Earth rotation rate [rad/s]

% Calculate ECI to ECEF coordinate transformation matrix using (2.145)
C_i_e = [cos(omega_ie * t), sin(omega_ie * t), 0;...
        -sin(omega_ie * t), cos(omega_ie * t), 0;...
                         0,                 0, 1];
variable_eci = C_i_e*variable_ecef;
end