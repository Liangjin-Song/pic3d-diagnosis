function di = local_inertial_length(N, m, q, prm)
%% 
% @brief: calculate the local inertial length
% @info: written by Liangjin Song on 20230215 at Nanchang University
% @param: N -- the plasma density
% @param: m -- the mass
% @param: q -- the charge
% @param: prm -- the parameters
% @return: di -- the inertial length
%% 
wp = slj.Physics.local_plasma_frequency(N, m, q, prm);
di = slj.Scalar(prm.value.c./wp.value);
end