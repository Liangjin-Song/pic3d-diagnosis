function [pNt, divNV] = continuity_equation(prm, name, tt, dt)
%%
% @info: written by Liangjin Song on 20220504 at Nanchang University
% @brief: calculate the continuity equation of one species
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @return: pNt -- \partial N/\partial t
% @return: divNV -- \nabla \cdot (NV)
% the continuity equation is:
%           \frac{\partial N}{\partial t} + \nabla \cdot (NV) = 0
%%
%% \partial N/\partial t
N2 = prm.read(['N', name], tt+dt);
N1 = prm.read(['N', name], tt-dt);
pNt=slj.Scalar((N2.value - N1.value).*prm.value.wci./(2.*dt));

%% \nabla \cdot (NV)
N = prm.read(['N', name], tt);
V = prm.read(['V', name], tt);
NV.x = - V.x .* N.value;
NV.y = - V.y .* N.value;
NV.z = - V.z .* N.value;
divNV = slj.Vector(NV);
divNV = divNV.divergence(prm);
end