function [qNE, divP, pVt, NVV, qVB] = momentum_equation_electric_force_density(prm, name, tt, dt, q, m)
%%
% @info: writen by Liangjin Song on 20220530
% @brief: momentum_equation - calculate the momentum equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @param: q - the charge
% @param: m - the mass
% @return: qNE - qNE
% @return: divP - nabla cdot P
% @return: pVt -  partial(mnV/t)
% @return: NVV -  nabla cdot (mnVV)
% @return: qVB - -qNV\times B
% the momentum equation is :
%  qNE = \nabla \cdot P + \parital(mnV)/\partial t + \nabla dot (nVV) -qNV\times B
%%

%% qNE term
N=prm.read(['N',name],tt);
E=prm.read('E',tt);
qNE.x = q.*N.value.*E.x;
qNE.y = q.*N.value.*E.y;
qNE.z = q.*N.value.*E.z;
qNE = slj.Vector(qNE);

%% divP term
P=prm.read(['P',name],tt);
divP=P.divergence(prm);

%% pVt term
V1=prm.read(['V',name],tt-dt);
V2=prm.read(['V',name],tt+dt);
N1=prm.read(['N',name],tt-dt);
N2=prm.read(['N',name],tt+dt);
pVt.x = (m.*N2.value.*V2.x - m.*N1.value.*V1.x).*prm.value.wci./(2.*dt);
pVt.y = (m.*N2.value.*V2.y - m.*N1.value.*V1.y).*prm.value.wci./(2.*dt);
pVt.z = (m.*N2.value.*V2.z - m.*N1.value.*V1.z).*prm.value.wci./(2.*dt);
pVt = slj.Vector(pVt);

%% NVV term
V=prm.read(['V',name],tt);
NVV.xx=m.*N.value.*V.x.*V.x;
NVV.xy=m.*N.value.*V.x.*V.y;
NVV.xz=m.*N.value.*V.x.*V.z;
NVV.yy=m.*N.value.*V.y.*V.y;
NVV.yz=m.*N.value.*V.y.*V.z;
NVV.zz=m.*N.value.*V.z.*V.z;
NVV=slj.Tensor(NVV);
NVV=NVV.divergence(prm);

%% qVB term
B=prm.read('B',tt);
qVB.x=q.*N.value.*(B.y.*V.z-B.z.*V.y);
qVB.y=q.*N.value.*(B.z.*V.x-B.x.*V.z);
qVB.z=q.*N.value.*(B.x.*V.y-B.y.*V.x);
qVB=slj.Vector(qVB);

end