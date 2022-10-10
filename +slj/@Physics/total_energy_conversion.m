function [pTt, divF, qVE] = total_energy_conversion(prm, name, tt, dt, q, m)
%%
% @info: written by Liangjin Song on 20220412 at Nanchang University
% @brief: total_energy_conversion - the time evolution of total energy (bulk kinetic energy and thermal energy)
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @param: q - the charge
% @param: m - the mass
% @return: pTt - partial (U + K) over partial t
% @return: divF - \nabla \cdot (KV + Q + H)
% @return: qVE - qnV dot E
% the total energy conversion equation is
%   \frac{\partial (K+U)}{\partial t} = qN\vec{V} \cdot \vec{E} - \nabla \cdot (K\vec{V} + \vec{Q} + \vec{H})
%%

%% \frac{\partial (K+U)}{\partial t}
% kinetic energy
K2 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt+dt), prm.read(['V',name],tt+dt));
K1 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt-dt), prm.read(['V',name],tt-dt));
% thermal energy
U2 = slj.Physics.thermal_energy(prm.read(['P',name], tt+dt));
U1 = slj.Physics.thermal_energy(prm.read(['P',name], tt-dt));
% total energy
T2 = K2.value + U2.value;
T1 = K1.value + U1.value;
pTt=slj.Scalar((T2 - T1).*prm.value.wci./(2.*dt));

%% qN\vec{V} \cdot \vec{E}
N=prm.read(['N',name],tt);
V=prm.read(['V',name],tt);
E=prm.read('E', tt);
qVE = slj.Scalar(q.*N.value.*(V.x.*E.x + V.y.*E.y + V.z.*E.z));

%% - \nabla \cdot (K\vec{V} + \vec{Q} + \vec{H})
K = slj.Physics.kinetic_energy(m, N, V);
KV.x = K.value.*V.x;
KV.y = K.value.*V.y;
KV.z = K.value.*V.z;

Q = prm.read(['qflux',name],tt);


P=prm.read(['P',name],tt);
U = slj.Physics.thermal_energy(P);
enp11=U.value.*V.x;
enp12=U.value.*V.y;
enp13=U.value.*V.z;

enp21=P.xx.*V.x+P.xy.*V.y+P.xz.*V.z;
enp22=P.xy.*V.x+P.yy.*V.y+P.yz.*V.z;
enp23=P.xz.*V.x+P.yz.*V.y+P.zz.*V.z;

H.x=enp11+enp21;
H.y=enp12+enp22;
H.z=enp13+enp23;

F.x = KV.x + Q.x + H.x;
F.y = KV.y + Q.y + H.y;
F.z = KV.z + Q.z + H.z;
F = slj.Vector(F);
divF = F.divergence(prm);
divF = slj.Scalar(-divF.value);
end