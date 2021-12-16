function K = kappa(prm, q, m, V, B)
%%
% @info: writen by Liangjin Song on 20211201 at Nanchang University
% @brief: calculate the gyroradius of one species polulation
% @param: q - the charge of the species
% @param: m - the mass of the species
% @param: V - the bulk velocity of the species, which is a Vector
% @param: B - the magnetic field, which is a Vector
% @return: R - the kappa value distribution of the species, 
%            which is a Scalar
% the kappa value is defined as 
%            K = \sqrt{Rc/Rg}
%            Rc is the curvature radius
%            Rg is the gyroradius
%%
%% the curvature radius
[~, Rc] = slj.Physics.curvature(prm, B);

%% the gyroradius
Rg = slj.Physics.gyroradius(q, m, V, B);

%% the kappa value
K = sqrt(Rc.value./Rg.value);
K = slj.Scalar(K);
end