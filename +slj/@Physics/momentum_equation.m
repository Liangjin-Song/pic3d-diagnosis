function [vxB, divP, nvv, nvt] = momentum_equation(prm, name, tt, dt, q, m)
%%
% @info: writen by Liangjin Song on 20210921
% @brief: momentum_equation - calculate the momentum equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @param: q - the charge
% @param: m - the mass
% @return: vxB - -v cross B
% @return: divP - nabla cdot P / qN
% @return: nvv - m/qn nabla cdot (nVV)
% @return: nvt - m/qn partial(nV/t)
% the momentum equation is :
%  E = -vxB + 1/qn nabla dot P + q/qn partial(nV/t) + m/qn nabla dot (nVV)
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
dP=P.divergence(prm);
divP.x=dP.x./(q*N.value);
divP.y=dP.y./(q*N.value);
divP.z=dP.z./(q*N.value);
divP=slj.Vector(divP);

%% nabla cdot (nVV) term
vv.xx=N.value.*V.x.*V.x;
vv.xy=N.value.*V.x.*V.y;
vv.xz=N.value.*V.x.*V.z;
vv.yy=N.value.*V.y.*V.y;
vv.yz=N.value.*V.y.*V.z;
vv.zz=N.value.*V.z.*V.z;
vv=slj.Tensor(vv);
div=vv.divergence(prm);
nvv.x=(m/q)*div.x./N.value;
nvv.y=(m/q)*div.y./N.value;
nvv.z=(m/q)*div.z./N.value;
nvv=slj.Vector(nvv);

V1=prm.read(['V',name],tt-dt);
V2=prm.read(['V',name],tt+dt);
N1=prm.read(['N',name],tt-dt);
N2=prm.read(['N',name],tt+dt);
nvt.x=(V2.x.*N2.value-V1.x.*N1.value)*prm.value.wci/(2*dt);
nvt.y=(V2.y.*N2.value-V1.y.*N1.value)*prm.value.wci/(2*dt);
nvt.z=(V2.z.*N2.value-V1.z.*N1.value)*prm.value.wci/(2*dt);
nvt.x=(m/q)*nvt.x./N.value;
nvt.y=(m/q)*nvt.y./N.value;
nvt.z=(m/q)*nvt.z./N.value;
nvt=slj.Vector(nvt);
end
