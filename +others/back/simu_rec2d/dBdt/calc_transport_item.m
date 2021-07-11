function transp=calc_transport_item(vx_RF,vy_RF,vz_RF,vx_drf,vy_drf,vz_drf,B,divsor)
%% calculate the transport item
% writen by Liangjin Song on 20180710
%   v_RF is the velocity of Reconnection Fronts which defined at half grids and half time steps
%   vx_drf, vy_drf, vz_drf are the drift velocity which defined at half grids and half time steps
%   B is total magnetic field which defined at full grids and half time steps
%
% output
%   transp is the transport item
%   

%{
if v_RF == 0
    vx=-vx_drf;
    vy=-2*vy_drf;
    vz=-2*vz_drf;
else
    vx=v_RF-2*vx_drf;
    vy=(-2)*vy_drf;
    vz=(-2)*vz_drf;
end
%}

vx=vx_RF-2*vx_drf;
vy=vy_RF-2*vy_drf;
vz=vz_RF-2*vz_drf;

[gBx,gBy,gBz]=calc_gradient(B,divsor);

transp=vx.*gBx+vy.*gBy+vz.*gBz;
