function [pKt, divKV, qVE, divPV] = kinetic_energy_conversion(prm, name, tt, dt, q, m)
%%
% @info: writen by Liangjin Song on 20211018
% @brief: kinetic_energy_conversion - the kinetic energy conversion equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @param: q - the charge
% @param: m - the mass
% @return: pKt - partial K over partial t
% @return: divKV - - nabla dot (KV)
% @return: qVE - qnV dot E
% @return: divPV - -(nabla dot P) dot V
% the bulk kinetic energy conversion equation is
%       \frac{\partial K}{\partial t} = - \nabla \cdot (K \vec{v}) + qn\vec{v} \cdot \vec{E} - (\nabla \cdot \vec{\vec{P}}) \cdot \vec{v}
%%

%% \frac{\partial K}{\partial t}
K2 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt+dt), prm.read(['V',name],tt+dt));
K1 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt-dt), prm.read(['V',name],tt-dt));
pKt=slj.Scalar((K2.value-K1.value).*prm.value.wci./(2.*dt));

%% - \nabla \cdot (K \vec{v})
N=prm.read(['N',name],tt);
V=prm.read(['V',name],tt);
K = slj.Physics.kinetic_energy(m, N, V);
divKV.x=K.value.*V.x;
divKV.y=K.value.*V.y;
divKV.z=K.value.*V.z;
divKV = slj.Vector(divKV);
divKV = divKV.divergence(prm);
divKV = slj.Scalar(-divKV.value);

%% qn\vec{v} \cdot \vec{E}
E=prm.read('E', tt);
qVE = slj.Scalar(q.*N.value.*(V.x.*E.x + V.y.*E.y + V.z.*E.z));

%% - (\nabla \cdot \vec{\vec{P}}) \cdot \vec{v}
P=prm.read(['P',name],tt);
divPV=P.divergence(prm);
divPV = slj.Scalar(-(divPV.x.*V.x + divPV.y.*V.y + divPV.z.*V.z));

end