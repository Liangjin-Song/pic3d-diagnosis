function wc = local_gyro_frequency(B, q, m, prm)
%% 
% @brief: calculate the local gyrofrequency
% @info: written by Liangjin Song on 20230215 at Nanchang University
% @param: B -- the magnetic field
% @param: q -- the charge
% @param: m -- the mass
% @param: prm -- the parameters
% @return: wc -- the gyrofrequency
%% 
B = sqrt(B.x.^2 + B.y.^2 + B.z.^2);
wc = slj.Scalar(q.*B./m);
end