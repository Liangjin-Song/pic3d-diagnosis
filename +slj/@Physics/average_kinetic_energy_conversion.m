function [pv2t, qve, vdv, divPV] = average_kinetic_energy_conversion(prm, name, tt, dt, q, m)
%%
% @info: written by Liangjin Song on 20220512 at Nanchang University
% @brief: the time evolution of v^2
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @param: q - the charge
% @param: m - the mass
% @return: pv2t - partial v^2 over partial t
% @return: qve - 2qV dot E/m
% @return: vdv - -V dot nabla v^2
% @return: divPV - -2(nabla \cdot P) \cdot V
% the average total energy conversion equation is:
%       \partial v^2/\partial t = 2q\vec{v}\cdot \vec{E}/m - \vec{v}\cdot \nabla v^2 - 2(\nabla \cdot \vec{\vec{P}}) \cdot \vec{v}/mN
%%
%% \partial v^2/\partial t
V2 = prm.read(['V',name],tt+dt);
V1 = prm.read(['V',name],tt-dt);
pv2t = slj.Scalar((V2.x.^2 + V2.y.^2 + V2.z.^2 - V1.x.^2 - V1.y.^2 - V1.z.^2).*prm.value.wci./(2.*dt));

%% 2q\vec{v}\cdot \vec{E}/m
V = prm.read(['V',name], tt);
E = prm.read('E', tt);
qve = slj.Scalar((V.x.*E.x + V.y.*E.y + V.z.*E.z).*2.*q./m);

%% -\vec{V}\cdot \nabla V^2
V2 = slj.Scalar(V.x.^2 + V.y.^2 + V.z.^2);
vdv = V2.gradient(prm);
vdv = slj.Scalar(-vdv.x.*V.x - vdv.y.*V.y - vdv.z.*V.z);

%% 2(\nabla \cdot \vec{\vec{P}}) \cdot \vec{v}/mN
P=prm.read(['P',name],tt);
N=prm.read(['N',name],tt);
divPV=P.divergence(prm);
divPV = slj.Scalar(-2.*(divPV.x.*V.x + divPV.y.*V.y + divPV.z.*V.z)./(m.*N.value));
end