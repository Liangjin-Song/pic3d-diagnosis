function fermi = Fermi_acceleration(obj, wci)
%% writen by Liangjin Song on 20210412
%% calculate the Fermi acceleration for a particle
%%
Bx=obj.value.bx;
By=obj.value.by;
Bz=obj.value.bz;
B2=Bx.^2+By.^2+Bz.^2;
B=sqrt(B2);
bx=Bx./B;
by=By./B;
bz=Bz./B;
v_para=obj.value.v_para;

%% perpendicular electric field
ex=obj.value.ex;
ey=obj.value.ey;
ez=obj.value.ez;
[ex, ey, ez]=cross(ex, ey, ez, bx, by, bz);
[ex, ey, ez]=cross(bx, by, bz, ex, ey, ez);
ex=obj.m*obj.weight*v_para.*ex;
ey=obj.m*obj.weight*v_para.*ey;
ez=obj.m*obj.weight*v_para.*ez;

%% db/dt
dt = obj.value.time(10) - obj.value.time(9);
dbx=(bx(2:end)-bx(1:end-1))*wci/dt;
dby=(by(2:end)-by(1:end-1))*wci/dt;
dbz=(bz(2:end)-bz(1:end-1))*wci/dt;

%% magnetic field
Bx=(Bx(1:end-1)+Bx(2:end))/2;
By=(By(1:end-1)+By(2:end))/2;
Bz=(Bz(1:end-1)+Bz(2:end))/2;
B2=(B2(1:end-1)+B2(2:end))/2;

%% electric field
ex=(ex(1:end-1)+ex(2:end))/2;
ey=(ey(1:end-1)+ey(2:end))/2;
ez=(ez(1:end-1)+ez(2:end))/2;

%% calculation
%% B cross db/dt
[Bx, By, Bz]=cross(Bx, By, Bz, dbx, dby, dbz);
Bx=Bx./B2;
By=By./B2;
Bz=Bz./B2;

fermi=ex.*Bx+ey.*By+ez.*Bz;
end

%% ======================================================================== %%
function [cx, cy, cz]=cross(ax, ay, az, bx, by, bz)
    cx=ay.*bz-az.*by;
    cy=az.*bx-ax.*bz;
    cz=ax.*by-ay.*bx;
end
