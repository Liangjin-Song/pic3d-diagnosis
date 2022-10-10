function [pAt, qVE, VdA, divF] = average_total_energy_conversion(prm, name, tt, dt, q, m)
%%
% @info: written by Liangjin Song on 20220412 at Nanchang University
% @brief: total_energy_conversion - the time evolution of average total energy (bulk kinetic energy and thermal energy)
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @param: q - the charge
% @param: m - the mass
% @return: pAt - partial (U + K)/N over partial t
% @return: qVE - qV dot E
% @return: VdA - -V dot nabla A
% @return: divF - -\nabla (Q + P dot V)/N
% the average total energy conversion equation is:
%   \frac{\partial A}{\partial t} = q\vec{V}\cdot\vec{E} - \vec{V} \cdot \nabla A - \nabla \cdot (Q + P \cdot \vec{V})/N
%   where A = (K + U)/N
%%

%% \frac{\partial A}{\partial t}
% kinetic energy
K2 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt+dt), prm.read(['V',name],tt+dt));
K1 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt-dt), prm.read(['V',name],tt-dt));
% thermal energy
U2 = slj.Physics.thermal_energy(prm.read(['P',name], tt+dt));
U1 = slj.Physics.thermal_energy(prm.read(['P',name], tt-dt));
% average total energy
N2 = prm.read(['N', name], tt+dt);
N1 = prm.read(['N', name], tt-dt);
A2 = (K2.value + U2.value)./N2.value;
A1 = (K1.value + U1.value)./N1.value;

pAt=slj.Scalar((A2 - A1).*prm.value.wci./(2.*dt));

%% q\vec{V}\cdot\vec{E}
V=prm.read(['V',name],tt);
E=prm.read('E', tt);
qVE = slj.Scalar(q.*(V.x.*E.x + V.y.*E.y + V.z.*E.z));

%% - \vec{V} \cdot \nabla A
N = prm.read(['N',name],tt);
P = prm.read(['P',name], tt);
K = slj.Physics.kinetic_energy(m, N, V);
U = slj.Physics.thermal_energy(P);
A = (K.value + U.value)./N.value;
A = slj.Scalar(A);
ga= A.gradient(prm);
VdA = -ga.x.*V.x - ga.y.*V.y - ga.z.*V.z;
VdA = slj.Scalar(VdA);

%% - \nabla \cdot (Q + P \cdot \vec{V})/N
Q = prm.read(['qflux',name],tt);

ENP.x = P.xx.*V.x+P.xy.*V.y+P.xz.*V.z;
ENP.y = P.xy.*V.x+P.yy.*V.y+P.yz.*V.z;
ENP.z = P.xz.*V.x+P.yz.*V.y+P.zz.*V.z;

divF.x = ENP.x + Q.x;
divF.y = ENP.y + Q.y;
divF.z = ENP.z + Q.z;

divF = slj.Vector(divF);
divF = divF.divergence(prm);
divF = slj.Scalar(-divF.value./N.value);

end