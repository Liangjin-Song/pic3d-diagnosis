function [vxB, divP, vv] = momentum_equation(prm, name, tt, charge, mass)
%%
% @info: writen by Liangjin Song on 20210921
% @brief: momentum_equation - calculate the momentum equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: charge - the species charge
% @param: mass - the species mass
% @return: vxB - v cross B
% @return: divP - nabla cdot P
% @return: vv - (v cdot nabla)V
% the momentum equation is :
%   partial(v/t) = e/m E + e/m vxB -1/(mn) nabla cdot P - (v cdot nabla)V
%%

%% vxB term
v=prm.read(['V',name],tt);
B=prm.read('B',tt);
vB=v.cross(B);
vxB.x=vB.x*charge/mass;
vxB.y=vB.y*charge/mass;
vxB.z=vB.z*charge/mass;
vxB=slj.Vector(vxB);

%% nabla dot P term
P=prm.read(['P',name],tt);
N=prm.read(['N',name],tt);
dP=P.divergence(prm);
divP.x=dP.x./(N.value*m);
divP.y=dP.y./(N.value*m);
divP.z=dP.z./(N.value*m);
divP=slj.Vector(dipP);

%% (v dot nabla) v term
vx=slj.Scalar(v.x);
vy=slj.Scalar(v.y);
vz=slj.Scalar(v.z);
vx=vx.divergence(prm);
vv.x=vx.dot(v);
vy=vy.divergence(prm);
vv.y=vy.dot(v);
vz=vz.divergence(prm);
vv.z=vz.dot(v);
vv=slj.Vector(vv);

end
