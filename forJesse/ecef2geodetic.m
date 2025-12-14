function [lla] = ecef2geodetic(xyz)
    % Inputs: x, y, z in meters (ECEF)
    % Outputs: lat, lon in degrees; alt in meters
    x = xyz(1,:);
    y = xyz(2,:);
    z = xyz(3,:);
    
    % WGS-84 ellipsoid constants
    a = 6378137.0;                    % semi-major axis
    f = 1 / 298.257223563;           % flattening
    e2 = f * (2 - f);                % eccentricity squared
    b = a * (1 - f);                 % semi-minor axis

    % Longitude (simple atan2)
    lon = atan2(y, x);

    % Compute intermediate values
    r = sqrt(x.^2 + y.^2);
    E2 = a^2 - b^2;
    F = 54 * b^2 * z.^2;
    G = r.^2 + (1 - e2) * z.^2 - e2 * E2;
    c = (e2^2 * F .* r.^2) ./ (G.^3);
    s = (1 + c + sqrt(c.^2 + 2 * c)).^(1/3);
    P = F ./ (3 * (s + 1/s + 1).^2 .* G.^2);
    Q = sqrt(1 + 2 * e2^2 * P);
    r0 = -(P * e2 * r) ./ (1 + Q) + sqrt(0.5 * a^2 * (1 + 1/Q) - ...
         P * (1 - e2) * z.^2 ./ (Q * (1 + Q)) - 0.5 * P * r.^2);
    U = sqrt((r - e2 * r0).^2 + z.^2);
    V = sqrt((r - e2 * r0).^2 + (1 - e2) * z.^2);
    Z0 = (b^2 * z) ./ (a * V);

    % Latitude and altitude
    lat = atan2(z + (e2 * Z0), r);
    alt = U * (1 - b^2 ./ (a * V));

    % Convert rad to deg
    lat = rad2deg(lat);
    lon = rad2deg(lon);
    lla = xyz;
    lla(1:3,:) = [lat;lon;alt];
end
