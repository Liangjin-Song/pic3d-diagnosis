function obj=calculation(obj)
%% writen by Liangjin Song on 20210408
% calculate other parameters
%%
obj=calc_kinetic_xyz(obj);
obj=calc_velocity_fac(obj);
obj=calc_electric_field_fac(obj);
obj=calc_magnetic_moment(obj);
end

%% ======================================================================== %%
%% calculate the kinetic energy in three direction
function obj=calc_kinetic_xyz(obj)
    obj.value.kx=0.5*obj.m*obj.value.vx.^2;
    obj.value.ky=0.5*obj.m*obj.value.vy.^2;
    obj.value.kz=0.5*obj.m*obj.value.vz.^2;
end

%% ======================================================================== %%
%% calculate the field aligned component
function [para, perp]=calc_fac(bx,by,bz,mx,my,mz)
    b=sqrt(bx.^2+by.^2+bz.^2);
    para=(mx.*bx+my.*by+mz.*bz)./b;
    perp=sqrt(mx.^2+my.^2+mz.^2-para.^2);
end

%% ======================================================================== %%
%% calculate the parallel and perpendicular velocity
function obj=calc_velocity_fac(obj)
    vx=obj.value.vx;
    vy=obj.value.vy;
    vz=obj.value.vz;
    bx=obj.value.bx;
    by=obj.value.by;
    bz=obj.value.bz;
    [para, perp]=calc_fac(bx,by,bz,vx,vy,vz);
    obj.value.v_para=para;
    obj.value.v_perp=perp;
    %% the kinetic energy at fac
    obj.value.k_para=0.5*obj.m*para.^2;
    obj.value.k_perp=0.5*obj.m*perp.^2;
end

%% ======================================================================== %%
%% calculate the parallel and perpendicular electric field
function obj=calc_electric_field_fac(obj)
    ex=obj.value.ex;
    ey=obj.value.ey;
    ez=obj.value.ez;
    bx=obj.value.bx;
    by=obj.value.by;
    bz=obj.value.bz;
    [para, perp]=calc_fac(bx,by,bz,ex,ey,ez);
    obj.value.e_para=para;
    obj.value.e_perp=perp;
end

%% ======================================================================== %%
%% calculate the magnetic moment
function obj=calc_magnetic_moment(obj)
    bx=obj.value.bx;
    by=obj.value.by;
    bz=obj.value.bz;
    b=sqrt(bx.^2+by.^2+bz.^2);
    obj.value.mu=obj.value.k_perp./b;
end
