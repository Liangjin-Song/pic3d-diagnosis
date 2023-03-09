function [eff, nmt, dnt] = effective_diffusivity(prm, B, E, V, J)
%% 
% @info: writen by Liangjin Song on 20230301
% @brief: calculate effective diffusivity, from https://doi.org/10.1063/1.4869717, Zenitani & Umeda, 2014
% @param: prm -- parameters
% @param: B -- the mganetic field
% @param: E -- the electric field
% @param: V -- the electron bulk velocity
% @param: J -- the current density
% @return: eff -- the effective diffusivity
%%

%% the unit magnetic vector
tmp = B.sqre();
b.x = B.x./tmp.value;
b.y = B.y./tmp.value;
b.z = B.z./tmp.value;
b = slj.Vector(b);

%% the curl of E + V x B
tmp = V.cross(B);
tmp = E + tmp;
tmp = tmp.curl(prm);

%% numerator
nmt = b.dot(tmp);

%% the curl of current
tmp = J.curl(prm);

%% denominator
dnt = b.dot(tmp);

%% effective diffusivity
eff = (-nmt.value.*prm.value.c*prm.value.c)./(dnt.value);

end