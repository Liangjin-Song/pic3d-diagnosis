function vA = local_Alfven_speed(B, rho, prm)
%% 
% @brief: calculate the local Alfven speed
% @info: written by Liangjin Song on 20230214 at Nanchang University
% @param: B -- the magnetic field, the Vector class
% @parma: rho -- the mass density, this includes the mass, e.g., rho = mi * Ni
% @param: prm -- the parameters
% @return: vA -- the Alfven speed
%%
if isa(rho, 'slj.Scalar')
    rho = rho.value;
end
B = sqrt(B.x.^2 + B.y.^2 + B.z.^2);
vA = slj.Scalar((B .* prm.value.c)./(sqrt(rho)));
end