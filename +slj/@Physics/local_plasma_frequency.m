function wp = local_plasma_frequency(N, m, q, prm)
%% 
% @brief: calculate the local plasma frequency
% @info: written by Liangjin Song on 20230215 at Nanchang University
% @param: N -- the plasma density
% @param: m -- the mass
% @param: q -- the charge
% @param: prm -- the parameters
% @return: wp -- the plasma frequency
%% 
if isa(N, 'slj.Scalar')
    N = N.value;
end
wp = slj.Scalar(sqrt(N.*q.*q/m));
end