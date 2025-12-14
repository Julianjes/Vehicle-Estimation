function [params] = setParams()

% Simulation params
params.simulation.dt = 1/50; % 50 Hz


% 
params.magNav.dt = 1/50;                % 50 Hz
params.magNav.sig_b = 1/300;            % magnetometer noise [Tesla]
params.magNav.biasTau = 3600;


% Gyro (med-quality gyro from Analysis of Ares 1 Ascent Navigation Options)
params..biasSigma = [0.006;0.006;0.006].* pi/180/3600 ;   % deg/hr to rad/s
params.gyro.dt = 1/50;
params.gyro.biasTau = 3600;

params.gyro.randomWalk = [0.00005;0.00005;0.00005].* pi/180; % deg/sqrt(sec) to rad/sqrt(sec)

% Start Tracker
% Values obtained from ARC star tracker
params.starTracker.dt = 1;                     %The amount of time between star tracker readings (in seconds)
params.starTracker.biasSigma = 0.0001745;              %The star trackers standard deviation (in radians)
params.starTracker.biasTau = 3600;
params.starTracker.FOV = 6.05;                           %The star tracker's field of view (in degrees)
params.starTracker.MaxStars = 16;                      %Maximum number of stars capable of being tracked at a single time
params.starTracker.MTH = 6.4;                            %The star tracker's magnitude threshold (how strong signal must be for
                                                     %star to be tracked) 
% KF
params.KF = kfParams;
                                                     
% IMU
% params.gyro = setIMU_med();

%% Actuator Parameters

% Reaction Wheel 
params.RW.wheelaxis = eye(3);         % Alignment of each wheel, could support pyramid/NASA standard etc.
params.RW.wheelspeeds = [0;0;0];      % wheel speeds
params.RW.maxw_wheel = 850*[1;1;1];   % max wheel speed [rad/s]
params.RW.wheeltorques = [0;0;0];     % placeholder for dynamics
params.RW.maxT_wheel = 0.005*[1;1;1]; % max wheel torque [N m]
params.RW.wheel_J = 9.1e-6*[1;1;1];    % wheel inertia

% Magnetorquer 
params.magRods.mag_ECI = [0;0;0];
params.magRods.mag_moment = 0.2*[1;1;1]; % magnetic torquer max moment [A m^2]
params.magRods.mag_axis = eye(3); 
params.magRods.mag_duty = [0;0;0]; % duty cycle, between -1 and 1

end