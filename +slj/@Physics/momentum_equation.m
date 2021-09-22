function [vxB, divP, nvv] = momentum_equation(prm, name, tt)
%%
% @info: writen by Liangjin Song on 20210921
% @brief: momentum_equation - calculate the momentum equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @return: vxB - v cross B
% @return: divP - nabla cdot P / N
% @return: vv - nabla cdot (nVV)
%%

%% vxB term
V=prm.read(['V',name],tt);
B=prm.read('B',tt);
vb.x=B.y.*V.z-B.z.*V.y;
vb.y=B.z.*V.x-B.x.*V.z;
vb.z=B.x.*V.y-B.y.*V.x;
vxB=slj.Vector(vb);

%% nabla dot P term
P=prm.read(['P',name],tt);
N=prm.read(['N',name],tt);
divP=P.divergence(prm);
dp.x=divP.x./(N);
dp.y=divP.y./(N);
dp.z=divP.z./(N);
divP=slj.Vector(dp);

%% nabla cdot (nVV) term
vv.xx=N.value.*V.x.*V.x;
vv.xy=N.value.*V.x.*V.y;
vv.xz=N.value.*V.x.*V.z;
vv.yy=N.value.*V.y.*V.y;
vv.yz=N.value.*V.y.*V.z;
vv.zz=N.value.*V.z.*V.z;
vv=slj.Tensor(vv);
div=vv.divergence(prm);
nvv.x=div.x./N;
nvv.y=div.y./N;
nvv.z=div.z./N;
nvv=slj.Vector(nvv);
end
