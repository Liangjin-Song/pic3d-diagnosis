function lf=get_line2d(obj, x0, direction, prm, norm)
%%
% @info: writen by Liangjin Song on 20210521
% @brief: get_line2d - get a line from 2d field
% @param: obj - the Scalar object
% @param: x0 - the location of the line
% @param: direction - the direction of the line: 0 - cross, 1 - vertical
% @param: prm - the Parameters object
% @param: norm - normalized unit
% @return: lf - the field at the line
%%
if nargin == 4
    norm=1;
end
if prm.value.reset
    Ly=prm.value.Lz;
else
    Ly=prm.value.Ly;
end
fd=obj.value;
ndx=size(fd,2);
ndy=size(fd,1);
if direction==0 
    x0=x0+Ly/2;
    ny=floor(x0/Ly*ndy)+1;
    ny1=ny+1;
    ddx=x0/Ly*ndy-ny+1.;
    lf=fd(ny,:)*(1-ddx)+fd(ny1,:)*ddx;
else
    Lx=prm.value.Lx;
    nx=floor(x0/Lx*ndx)+1;
    nx1=nx+1;
    ddx=x0/Lx*ndx-nx+1.;
    lf=fd(:,nx)*(1-ddx)+fd(:,nx1)*ddx;
end
lf=lf/norm;
end
