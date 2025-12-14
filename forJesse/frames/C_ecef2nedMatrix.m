function [variable_ecef] = C_ecef2nedMatrix(variable_ned,lng,lat)
% Function used to convert a generic variable (ie. position, velocity,
% magn field, etc.) from ned frame to ecef frame

% We use the C_ecef2ned rotation matrix and transpose to reverse the frames
% it transforms 
% Turns altitudes from Km to radians to fill our matrix

Re = 6379; % Radius of Earth [km]

% Converting from km to rads

lng_deg = lng/Re; % latitude [rads]
lat_deg = lat/Re; % lonitude [rads]

cos_lat = cos(lng_deg);
sin_lat = sin(lng_deg);
cos_long = cos(lat_deg);
sin_long = sin(lat_deg);

C_ecef2ned = [-sin_lat * cos_long, -sin_lat * sin_long, cos_lat;...
    -sin_long, cos_long, 0;...
    -cos_lat * cos_long, -cos_lat * sin_long, -sin_lat]; % Rotation Matrix NED to ECEF

variable_ecef = C_ecef2ned'*variable_ned;
end