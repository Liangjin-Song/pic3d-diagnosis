function obj=calculation(obj)
%%
% @info: writen by Liangjin Song on 20210408
% @brief: calculation - calculate some parameters about the particle
% @param: obj - the Particle object
% @return: obj - the Particle object
%%
obj=calc_kinetic_xyz(obj);
obj=calc_velocity_fac(obj);
obj=calc_electric_field_fac(obj);
obj=calc_magnetic_moment(obj);
obj=calc_pitch_angle(obj);
end

%% ======================================================================== %%
function obj=calc_kinetic_xyz(obj)
%%
% @brief: calculate the kinetic energy in three direction
% @param: obj - the Particle object
% @return: obj - the Particle object
%%
    obj.value.kx=0.5*obj.m*obj.weight*obj.value.vx.^2;
    obj.value.ky=0.5*obj.m*obj.weight*obj.value.vy.^2;
    obj.value.kz=0.5*obj.m*obj.weight*obj.value.vz.^2;
end

%% ======================================================================== %%
function [para, perp]=calc_fac(bx,by,bz,mx,my,mz)
%%
% @brief: calculate the field aligned component
% @param: bx, by, bz - the magnetic field
% @param: mx, ny, mz - the vector
% @return: para - the parallel component
% @return: perp - the perpendicular component
%%
    b=sqrt(bx.^2+by.^2+bz.^2);
    para=(mx.*bx+my.*by+mz.*bz)./b;
    perp=sqrt(mx.^2+my.^2+mz.^2-para.^2);
end

%% ======================================================================== %%
function obj=calc_velocity_fac(obj)
%%
% @brief: calculate the parallel and perpendicular velocity
% @param: obj - the Particle object
% @return: obj - the Particle object
%%
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
    obj.value.k_para=0.5*obj.weight*obj.m*para.^2;
    obj.value.k_perp=0.5*obj.weight*obj.m*perp.^2;
    %% velocity in fac
    ex=obj.value.ex;
    ey=obj.value.ey;
    ez=obj.value.ez;
    %% perp 1, E cross B
    [x, y, z] = calc_cross(0, 0, 1, bx, by, bz);
    m = sqrt(x.^2 + y.^2 + z.^2);
    x = x./m;
    y = y./m;
    z = z./m;
    obj.value.v_perp1=vx.*x + vy.*y + vz.*z;

    %% perp 2, B cross (E cross B)
    [x, y, z] = calc_cross(bx, by, bz, x, y, z);
    m = sqrt(x.^2 + y.^2 + z.^2);
    x = x./m;
    y = y./m;
    z = z./m;
    obj.value.v_perp2=vx.*x + vy.*y + vz.*z;
end

function [x, y, z] = calc_cross(ax, ay, az, bx, by, bz)
%%
% @brief: calculate a cross b
% @param: ax, ay, az - the velor a
% @param: bx, by, bz - the velor b
% @return: x, y, z - the result
%%
x = ay.*bz - az.*by;
y = az.*bx - ax.*bz;
z = ax.*by - ay.*bx;
end

%% ======================================================================== %%
function obj=calc_electric_field_fac(obj)
%%
% @brief: calculate the parallel and perpendicular electric field
% @param: obj - the Particle object
% @return: obj - the Particle object
%%
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
function obj=calc_magnetic_moment(obj)
%%
% calculate the magnetic moment
% @param: obj - the Particle object
% @return: obj - the Particle object
%%
    bx=obj.value.bx;
    by=obj.value.by;
    bz=obj.value.bz;
    b=sqrt(bx.^2+by.^2+bz.^2);
    obj.value.mu=obj.value.k_perp./b;
end

%% ======================================================================== %%
function obj=calc_pitch_angle(obj)
%% 
% calculate the pitch angle
% @param: obj - the Particle object
% @return: obj - the Particle object
%%
    %% the unit vector of magnetic field
    bx=obj.value.bx;
    by=obj.value.by;
    bz=obj.value.bz;
    b=sqrt(bx.^2 + by.^2 + bz.^2);
    bx=bx./b;
    by=by./b;
    bz=bz./b;
    %% the unit vector of velocity
    vx=obj.value.vx;
    vy=obj.value.vy;
    vz=obj.value.vz;
    v=sqrt(vx.^2 + vy.^2 + vz.^2);
    vx=vx./v;
    vy=vy./v;
    vz=vz./v;
    %% the pitch angle
    agl = vx.*bx + vy.*by + vz.*bz;
    agl = acos(agl) * 180/pi;
    obj.value.pitch = agl;
end