function fd = fac(obj, prm, E, B)
%%
% @info: writen by Liangjin Song on 20211229 at Nanchang University
% @brief: fac -- turn the distribution to the field-aligned coordinate
% @param: prm --- the Parameters Object
% @param: E -- the electric field, which is a Vector
% @param: B -- the magnetic field, which is a Vector
% @return: fd -- the particles in field-aligned coordinate
%               vx -- E \times B direction
%               vy -- B \times (E \times B) direction
%               vz -- parallel to the magnetic field
%%
%% the perpendicular direction
EB = E.cross(B);
BEB = B.cross(EB);

%% the unit vector
tmp = B.sqrt();
b.x=B.x./tmp.value;
b.y=B.y./tmp.value;
b.z=B.z./tmp.value;

tmp = EB.sqrt();
eb.x = EB.x./tmp.value;
eb.y = EB.y./tmp.value;
eb.z = EB.z./tmp.value;

tmp = BEB.sqrt();
beb.x = BEB.x./tmp.value;
beb.y = BEB.y./tmp.value;
beb.z = BEB.z./tmp.value;

%% the particles' position index
px = obj.value.rx;
px = (prm.value.nx - 1).*px./prm.value.Lx + 1;
px = round(px);
pz = obj.value.rz;
pz = (prm.value.nz - 1).*pz./prm.value.Lz + 1;
pz = round(pz);

%% velocity
mx = obj.value.vx;
my = obj.value.vy;
mz = obj.value.vz;

%% turn to the fac system
np = length(obj.value.id);
vx = zeros(1, np);
vy = zeros(1, np);
vz = zeros(1, np);
for i = 1:np
    %% velocity parallel to the magnetic field
    kx=b.x(pz(i), px(i));
    ky=b.y(pz(i), px(i));
    kz=b.z(pz(i), px(i));
    vz(i) = mx(i).*kx + my(i).*ky + mz(i).*kz;

    %% velocity parallel to E cross B
    kx=eb.x(pz(i), px(i));
    ky=eb.y(pz(i), px(i));
    kz=eb.z(pz(i), px(i));
    vx(i) = mx(i).*kx + my(i).*ky + mz(i).*kz;

    %% velocity parallel to B cross ( E cross B )
    kx=beb.x(pz(i), px(i));
    ky=beb.y(pz(i), px(i));
    kz=beb.z(pz(i), px(i));
    vy(i) = mx(i).*kx + my(i).*ky + mz(i).*kz;
end

value=[];
value.id=obj.value.id;
value.rx=obj.value.rx;
value.ry=obj.value.ry;
value.rz=obj.value.rz;
value.vx=vx;
value.vy=vy;
value.vz=vz;
value.weight=obj.value.weight;
fd=slj.Species(obj.name, obj.time, obj.range, value);
end