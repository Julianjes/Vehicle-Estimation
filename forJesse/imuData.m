function [f_ib_b, w_ib_b] = imuData(truth,params)


persistent vI_old
persistent oldCb2i


if isempty(vI_old)
    vI_old = truth.vI_ms;
    oldCb2i = q2m(truth.qb2i);
end

vI = truth.vI_ms;
Cb2i = q2m(truth.qb2i);
dt = params.imu.dt;

% Obtain coordinate transformation matrix from the old attitude to the new
C_old_new = Cb2i' * oldCb2i;

% Calculate the approximate angular rate
dtheta_ib_b = zeros(3,1);
dtheta_ib_b(1,1) = 0.5 * (C_old_new(2,3) - C_old_new(3,2));
dtheta_ib_b(2,1) = 0.5 * (C_old_new(3,1) - C_old_new(1,3));
dtheta_ib_b(3,1) = 0.5 * (C_old_new(1,2) - C_old_new(2,1));

% Calculate and apply the scaling facdt
temp = acos(0.5 * (C_old_new(1,1) + C_old_new(2,2) + C_old_new(3,3)...
    - 1.0));
if temp>2e-5 %scaling is 1 if temp is less than this
    dtheta_ib_b = dtheta_ib_b * temp/sin(temp);
end 

% Calculate the angular rate
w_ib_b = dtheta_ib_b / dt;

% Calculate the specific force resolved about ECI-frame axes
% From (5.18) and (5.20),
f_ib_i = ((truth- vI_old) / dt) - Gravitation_ECI(r_ib_i);

% Calculate the average body-to-ECI-frame coordinate transformation
% matrix over the update interval using (5.84)

mag_dtheta = sqrt(dtheta_ib_b' * dtheta_ib_b);
dtheta_ib_b = Skew_symmetric(dtheta_ib_b);    
if mag_dtheta>1.E-8
    ave_C_b_i = old_C_b_i * (eye(3) + (1 - cos(mag_dtheta)) /mag_dtheta^2 ...
       * dtheta_ib_b + (1 - sin(mag_dtheta) / mag_dtheta) / mag_dtheta^2 ...
       * dtheta_ib_b * dtheta_ib_b);
else
    ave_C_b_i = old_C_b_i;
end 
    
% Transform specific force to body-frame resolving axes using (5.81)
f_ib_b = inv(ave_C_b_i) * f_ib_i;






end
    
























end