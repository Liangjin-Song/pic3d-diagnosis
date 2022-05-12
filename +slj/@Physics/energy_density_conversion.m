function [pTt, divQ, PddivV, pdivV, VdivT] = energy_density_conversion(prm, name, tt, dt)
%%
% Syntax: [pTt, divQ, PddivV, pdivV, VdivT] = energy_density_conversion(prm, name, tt, dt)
% @info: writen by Liangjin Song on 20211019
% @info: energy_density_conversion - energy density conversion equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @return: pTt - \frac{\partial T}{\partial t}
% @return: divQ - -\frac{2}{3}\frac{1}{n}\nabla\cdot\vec{Q}
% @return: PddivV - -\frac{2}{3}\frac{1}{n}(\vec{\vec{P}}' \cdot \nabla) \cdot \vec{v}
% @return: pdivV - -\frac{2}{3}\frac{1}{n}p\nabla \cdot \vec{v}
% @return: VdivT - -\vec{v}\cdot\nabla T
% the energy density conversion equation is
%   \frac{\partial T}{\partial t} = -\frac{2}{3} \frac{\nabla \cdot \vec{Q} + (\vec{\vec{P}}' \cdot \nabla)\cdot \vec{v} - p\nabla\cdot\vec{v}}{n} - \vec{v} \cdot \nabla T
%%

%% \frac{\partial T}{\partial t}
T2 = slj.Physics.temperature(prm.read(['P',name], tt+dt), prm.read(['N',name], tt+dt));
T1 = slj.Physics.temperature(prm.read(['P',name], tt-dt), prm.read(['N',name], tt-dt));
pTt=slj.Scalar((T2.value-T1.value).*prm.value.wci./(2.*dt));

%% -\frac{2}{3}\frac{1}{n}\nabla\cdot\vec{Q}
N = prm.read(['N',name], tt);
divQ = prm.read(['qflux',name],tt);
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-2.*divQ.value./(N.value.*3));

%% -\frac{2}{3}\frac{1}{n}(\vec{\vec{P}}' \cdot \nabla) \cdot \vec{v}
P=prm.read(['P', name], tt);
p=(P.xx+P.yy+P.zz)/3;
pdxx=P.xx-p;
pdxy=P.xy;
pdxz=P.xz;
pdyy=P.yy-p;
pdyz=P.yz;
pdzz=P.zz-p;

% calculate (P' dot gradient) dot v
V=prm.read(['V', name], tt);
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*pdxx+g.y.*pdxy+g.z.*pdxz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*pdxy+g.y.*pdyy+g.z.*pdyz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*pdxz+g.y.*pdyz+g.z.*pdzz;

px=px./N.value;
px=-2*px/3;

py=py./N.value;
py=-2*py/3;

pz=pz./N.value;
pz=-2*pz/3;

PddivV=slj.Scalar(px+py+pz);

%% -\frac{2}{3}\frac{1}{n}p\nabla \cdot \vec{v}
VV=V.divergence(prm);
p=(P.xx+P.yy+P.zz)/3;
pdivV=VV.value.*p./N.value;
pdivV=slj.Scalar(-2*pdivV/3);

%% -\vec{v}\cdot\nabla T
T = slj.Physics.temperature(P, N);
g=T.gradient(prm);
VdivT=V.x.*g.x+V.y.*g.y+V.z.*g.z;
VdivT=slj.Scalar(-VdivT);
end