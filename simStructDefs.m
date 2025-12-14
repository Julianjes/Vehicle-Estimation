function [] = simStructDefs()


dynamics.rI_m = zeros(3,1);
dynamics.vI_m = zeros(3,1);
dynamics.qi2b = zeros(4,1);
dynamics.wI_rads = zeros(3,1);

% Satellite Structiure 
SAT.rI_m = zeros(3,1);
SAT.vI_ms = zeros(3,1);
SAT.qi2b = zeros(4,1);
SAT.wI_rads = zeros(3,1);
SAT.time_s = 0;
SAT.rE_m = zeros(3,1);
SAT.vE_m = zeros(3,1);
SAT.lat_deg = 0;
SAT.lon_deg = 0;
SAT.alt_m = 0;

% Sensor Structs
sun_meas.sunVector_I = zeros(3,1);
sun_meas.sunVector_B = zeros(3,1);
sun_meas.sunClk = 0;
sun_meas.available = 0;

mag_meas.magField_B = zeros(3,1);
mag_meas.magField_I = zeros(3,1);
mag_meas.magClk = 0;


% Number of stars from setParams.m
%3*maxNum represents 16 3x1 vectors
maxNum = 16;
star_meas.stars_B = zeros(1,3*maxNum);
star_meas.stars_I = zeros(1,3*maxNum);
star_meas.numStars = 0;
star_meas.starClk = 0;
star_meas.available = 0;



gyro_meas.wB_rads = zeros(3,1);
gyro_meas.gyroClk = 0;
gyro_meas.aux.bias = zeros(3,1);
gyro_meas.aux.scaleFactor = zeros(3,1);
gyro_meas.aux.nonOrtho =zeros(3,1);

time.magClk = 0;
time.sunClk = 0;
time.gyroClk = 0;
time.starClk = 0;
time.time_s = 0;

meas.mag_meas = mag_meas;
meas.sun_meas = sun_meas;
meas.gyro_meas = gyro_meas;
meas.time = time;
meas.star_meas = star_meas;

% Kalman Filter Bus
KF.n = 0;
KF.x = zeros(12,1);
KF.P = zeros(12);
KF.Q = zeros(12);
KF.gBias = zeros(3,1);
KF.gSF = zeros(3,1);
KF.gMA = zeros(3,1);


struct2bus(SAT,       'SAT');
struct2bus(dynamics,  'dynamics');
struct2bus(sun_meas, 'sun_meas');
struct2bus(mag_meas, 'mag_meas');
struct2bus(gyro_meas, 'gyro_meas');
struct2bus(time,       'time')
struct2bus(star_meas, 'star_meas');
struct2bus(meas,         'meas');
struct2bus(KF,            'KF');





