function [imu_meas] = imu_sensor(f_ib_b,w_ib_b,params)

% Does your quaternion have scalar in the first or last, is it negative
% vector or positive?

persistent gBias
persistent aBias
persistent gRandomWalk
persistent aRandomWalk


if isempty(gBias)
    gBias = zeros(3,1);
    aBias = zeros(3,1);
    gRandomWalk = params.imu.gRandomWalk;
    aRandomWalk = params.imu.aRandomWalk;
end

% Extract from inputs
dt = params.imu.dt;
gBiasSigma = params.imu.gBiasSigma;
gBiasTau = params.imu.gBiasTau;
aBiasSigma = params.imu.gBiasSigma;
aBiasTau = params.imu.gBiasTau;

%% Specific Force

% Bias
aBias = fogmProcess(dt,aBiasSigma,aBiasTau,aBias); % accelerometer Bias

% Random Walk
anoise = aRandomWalk.*randn(3,1);
anoise = anoise / sqrt(dt);

fB_meas = f_ib_b + aBias + anoise;


%% Angular Rate 

% Bias FOGM
gBias = fogmProcess(dt,gBiasSigma,gBiasTau,gBias);

% Random Walk
gnoise = gRandomWalk.*randn(3,1);
gnoise = gnoise / sqrt(dt);

wB_meas = w_ib_b + gBias + gnoise;

%% Output
imu_meas.wB_rads = wB_meas;
imu_meas.fB_mps2 = fB_meas;
imu_meas.gClk = SAT.time_s;

%% Update persistents
last_wB = wB;
last_accelB = accelB;





end