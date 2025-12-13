function xdot = BicycleModelDynamics(x, u, params)
% BICYCLEMODELDYNAMICS: Linear bicycle model
%
% Inputs:
%   x = [vy; r; psi,Cf,Cr]   - states, lateral velocity, Yaw rate, heading 

vy =x(1);
r = x(2);
psi = x(3);
Cf = x(4);
Cr = x(5);

%   u = [vx; delta]    - inputs, Longtitudinal velocity, steering angle
vu = u(1);vu = (max(vu,1));
delta = u(2);


% Parameter
m = params.m;
Iz = params.Iz;
lf = params.lf;
lr = params.lr;


alpha_f = (vy + lf*r)/vu - delta;   % We ignore change in atan becuase it just so small
alpha_r = (vy - lr*r)/vu;

FyF = -Cf * alpha_f;
FyR = -Cr * alpha_r;

vy_dot = -r*vu + (FyR + FyF*cos(delta))/m; % Fxf is zero becuase we ignore longtitudal, becuase constant speed
r_dot = (-lr*FyR + lf*(FyF*cos(delta)))/Iz;
psi_dot = r;

cf_dot = 0;
cr_dot = 0;

xdot = [vy_dot;r_dot;psi_dot;cf_dot;cr_dot];
end
