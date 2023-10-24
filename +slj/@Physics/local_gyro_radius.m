function r = local_gyro_radius(P,N, B, m, q)
%%
% @brief: calculate the local gyroradius
% @info: written by Liangjin Song on 20230921 at Nanchang University
% @param: P -- the pressure
% @param: N -- the number density
% @param: B -- the magnetic field
% @param: q -- the charge
% @param: m -- the mass
% @return: r -- the gyroradius
%%

%% the thermal velocity
T = slj.Physics.temperature(P, N);
vth = sqrt(T.value./m);

%% the strength of magnetic field
Bm = sqrt(B.x.^2 + B.y.^2 + B.z.^2);

%% the gyroradius
r = slj.Scalar((m .* vth) ./ (abs(q) .* Bm));
end