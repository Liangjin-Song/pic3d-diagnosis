function [pUt, divPV, divQ, divH]= thermal_energy_conversion(prm, name, tt, dt)
%%
% Syntax: [pUt, divPV, divQ, divH]= thermal_energy_conversion(prm, name, tt, dt)
% @info: writen by Liangjin Song on 20211019
% @brief: thermal_energy_conversion - the thermal energy conversion equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @return: pUt - \frac{\partial U}{\partial t}
% @return: divPV - \vec{v}\cdoot(\nabla \cdot \vec{\vec{P}})
% @return: divQ - -\nabla\cdot\vec{Q}
% @return: divH - -\nabla\cdot(U\vec{v} + \vec{\vec{P}}\cdot\vec{v})
% the thermal energy conversion equation is
%       \frac{\partial U}{\partial t} = \vec{v} \cdot (\nabla \cdot \vec{\vec{P}}) - \nabal \cdot Q - \nabla \cdot (U\vec{v} + \vec{\vec{P}} \cdot \vec{v})
%%

%% \frac{\partial U}{\partial t}
U2 = slj.Physics.thermal_energy(prm.read(['P',name], tt+dt));
U1 = slj.Physics.thermal_energy(prm.read(['P',name], tt-dt));
pUt=slj.Scalar((U2.value-U1.value).*prm.value.wci./(2.*dt));

%% \vec{v}\cdoot(\nabla \cdot \vec{\vec{P}})
V=prm.read(['V',name],tt);
P=prm.read(['P',name],tt);
divPV=P.divergence(prm);
divPV = slj.Scalar(divPV.x.*V.x + divPV.y.*V.y + divPV.z.*V.z);

%% -\nabla\cdot\vec{Q}
divQ = prm.read(['qflux',name],tt);
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-divQ.value);

%% -\nabla\cdot(U\vec{v} + \vec{\vec{P}}\cdot\vec{v})
U = slj.Physics.thermal_energy(P);
enp11=U.value.*V.x;
enp12=U.value.*V.y;
enp13=U.value.*V.z;
% P dot V
enp21=P.xx.*V.x+P.xy.*V.y+P.xz.*V.z;
enp22=P.xy.*V.x+P.yy.*V.y+P.yz.*V.z;
enp23=P.xz.*V.x+P.yz.*V.y+P.zz.*V.z;
% enthalpy
enp.x=enp11+enp21;
enp.y=enp12+enp22;
enp.z=enp13+enp23;
divH = slj.Vector(enp);
divH = divH.divergence(prm);
divH = slj.Scalar(-divH.value);
end