%%
% @brief: plot the force on the particle
% @info: writen by Liangjin Song on 20221026 at NCU
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

%% particle's id
id = '1023750328';
name=['trajh_id',id];

%% time
tt = 0:0.1:60;
nt = length(tt);

%% the index interval in the particle
dt = 10;

%% electric force
fe.x = zeros(1, nt);
fe.y = zeros(1, nt);
fe.z = zeros(1, nt);

%% Lorentz force
fl.x = zeros(1, nt);
fl.y = zeros(1, nt);
fl.z = zeros(1, nt);

%% gradient force
fg.x = zeros(1, nt);
fg.y = zeros(1, nt);
fg.z = zeros(1, nt);

%% curvature force
fc.x = zeros(1, nt);
fc.y = zeros(1, nt);
fc.z = zeros(1, nt);

%% read particle
prt = prm.read(char(name));

%% loop
for t = 1:nt
%% read data
tc = tt(t);
B = prm.read('B', tc);

%% the index of current time in the particle information
ti = (t - 1) * dt + 1;

%% force
[fe.x(t), fe.y(t), fe.z(t)] = electric_force(prm, prt, ti);
[fl.x(t), fl.y(t), fl.z(t)] = lorentz_force(prm, prt, ti);
[fg.x(t), fg.y(t), fg.z(t)] = gradient_force(prm, prt, B, ti);
[fc.x(t), fc.y(t), fc.z(t)] = curvature_force(prm, prt, B, ti);
end

%% obtain the components
fe = fe.x;
fl = fl.x;
fg = fg.x;
fc = fc.x;
ff = fe + fl + fg + fc;

%% plot figure
figure;
plot(tt, fe, '-r', 'LineWidth', 2);
hold on
plot(tt, fl, '-g', 'LineWidth', 2);
plot(tt, fg, '-b', 'LineWidth', 2);
plot(tt, fc, '-m', 'LineWidth', 2);
plot(tt, ff, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('Fx');
legend('electric', 'Lorentz', 'gradient', 'curvature', 'sum');
cd(outdir);

function [fx, fy, fz] = electric_force(prm, prt, ti)
%%
% @brief: calculate the electric force
% @info: writen by Liangjin Song on 20221026 at NCU
%%
fx = prt.q * prt.value.ex(ti);
fy = prt.q * prt.value.ey(ti);
fz = prt.q * prt.value.ez(ti);
end

function [fx, fy, fz] = lorentz_force(prm, prt, ti)
%%
% @brief: calculate the Lorentz force
% @info: writen by Liangjin Song on 20221026 at NCU
%%
vx = prt.value.vx(ti);
vy = prt.value.vy(ti);
vz = prt.value.vz(ti);
bx = prt.value.bx(ti);
by = prt.value.by(ti);
bz = prt.value.bz(ti);
f = cross([vx, vy, vz], [bx, by, bz]);
fx = f(1) * prt.q;
fy = f(2) * prt.q;
fz = f(3) * prt.q;
end

function [fx, fy, fz] = gradient_force(prm, prt, B, ti)
%%
% @brief: calculate the gradient force
% @info: writen by Liangjin Song on 20221026 at NCU
%%
mu = prt.value.mu(ti);
divb = slj.Scalar(sqrt(B.x.^2 + B.y.^2 + B.z.^2));
divb = divb.gradient(prm);
px = slj.Physics.linear([prm.value.lx(1), 1], [prm.value.lx(end), prm.value.nx], prt.value.rx(ti));
pz = slj.Physics.linear([prm.value.lz(1), 1], [prm.value.lz(end), prm.value.nz], prt.value.rz(ti));
fx = slj.Physics.linear_interp_2d(px, pz, divb.x);
fy = slj.Physics.linear_interp_2d(px, pz, divb.y);
fz = slj.Physics.linear_interp_2d(px, pz, divb.z);
fx = - mu * fx;
fy = - mu * fy;
fz = - mu * fz;
end

function [fx, fy, fz] = curvature_force(prm, prt, B, ti)
%%
% @brief: calculate the curvature force
% @info: writen by Liangjin Song on 20221026 at NCU
%%
[cv, ~] = slj.Physics.curvature(prm, B);
kp = prt.m * prt.value.v_para(ti).^2;
px = slj.Physics.linear([prm.value.lx(1), 1], [prm.value.lx(end), prm.value.nx], prt.value.rx(ti));
pz = slj.Physics.linear([prm.value.lz(1), 1], [prm.value.lz(end), prm.value.nz], prt.value.rz(ti));
fx = slj.Physics.linear_interp_2d(px, pz, cv.x);
fy = slj.Physics.linear_interp_2d(px, pz, cv.y);
fz = slj.Physics.linear_interp_2d(px, pz, cv.z);
fx = fx * kp;
fy = fy * kp;
fz = fz * kp;
end