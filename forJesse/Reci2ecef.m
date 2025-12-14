function Ci2e = Reci2ecef(params,t)

omega_ie = params.Environment.wEarth;
Ci2e = [cos(omega_ie * t), sin(omega_ie * t), 0;...
        -sin(omega_ie * t), cos(omega_ie * t), 0;...
                         0,                 0, 1];
end