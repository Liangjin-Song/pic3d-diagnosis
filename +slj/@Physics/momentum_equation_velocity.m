function [vdv, divP, evb] = momentum_equation(prm, name, tt, q, m)
%%
% @info: writen by Liangjin Song on 20211124
% @brief: momentum_equation - calculate the momentum equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: q - the charge
% @param: m - the mass
% @return: vdv - -(v dot nabla)v
% @return: divP - nabla cdot P / mN
% @return: evb - q/m (E + v cross B)
% the momentum equation is :
% \partial V/\partial t = - (V \cdot \nabla)V - \nabla \cdot P /mn + q/m (E + V \times B)
%%

%% E+vxB term
qm=q/m;
V=prm.read(['V',name],tt);
B=prm.read('B',tt);
E=prm.read('E',tt);
vb.x=(-B.y.*V.z+B.z.*V.y+E.x)*qm;
vb.y=(-B.z.*V.x+B.x.*V.z+E.y)*qm;
vb.z=(-B.x.*V.y+B.y.*V.x+E.z)*qm;
evb=slj.Vector(vb);

%% nabla dot P term
P=prm.read(['P',name],tt);
N=prm.read(['N',name],tt);
dP=P.divergence(prm);
divP.x=-dP.x./(m*N.value);
divP.y=-dP.y./(m*N.value);
divP.z=-dP.z./(m*N.value);
divP=slj.Vector(divP);

%% -(V dot nabla) V term
vx=slj.Scalar(V.x);
g=vx.gradient(prm);
vdv.x=-(V.x.*g.x + V.y.*g.y + V.z.*g.z);
vy=slj.Scalar(V.y);
g=vy.gradient(prm);
vdv.y=-(V.x.*g.x + V.y.*g.y + V.z.*g.z);
vz=slj.Scalar(V.z);
g=vz.gradient(prm);
vdv.z=-(V.x.*g.x + V.y.*g.y + V.z.*g.z);
vdv=slj.Vector(vdv);
end
