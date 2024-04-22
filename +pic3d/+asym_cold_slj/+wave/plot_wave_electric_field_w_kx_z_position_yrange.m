%
%% analysis the electric field Ex in w-kx plane
clear;
%% parameters
% directory
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

% load the position index of the separatrix in z direction
cd(outdir);
load('z_position_along_separatrix.mat');
pz = pz - 400;
pt = 20:0.1:40;

% time intervals
dt = 0.05;
tt=20:dt:40;

% physics quantity
name = 'E';

% normalize
norm = prm.value.vA;
% norm = 1;

%% the variable
nt = length(tt);
nx = prm.value.nx;
tE.x = zeros(nt, nx);
tE.y = zeros(nt, nx);
tE.z = zeros(nt, nx);

%% loop
cd(indir);
for t = 1:nt
%% read data
E=prm.read(name, tt(t), 'yrange', prm.value.nx, 200, 1);
%% obtain the profile position
[~, it] = min(abs(pt - tt(t)));

%% obtain the field
tE.x(t, :) = E.x(pz(it), :);
tE.y(t, :) = E.y(pz(it), :);
tE.z(t, :) = E.z(pz(it), :);
end
%}
cd(outdir);
%% backup
E = tE;

fd=E.x/norm;
lx=prm.value.lx;
%% select the range
x1 = 33;
x2 = 42;
t1 = 20;
t2 = 40;
[~, x1] = min(abs(prm.value.lx - x1));
[~, x2] = min(abs(prm.value.lx - x2));
[~, t1] = min(abs(tt - t1));
[~, t2] = min(abs(tt - t2));
fd = fd(t1:t2, x1:x2);
lx = lx(x1:x2);
lt = tt(t1:t2);

%% plot the field
f1 = figure;
slj.Plot.field2d_suitable(fd, lx, lt, []);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
% caxis([-1, 1]);
title('Ex');
set(gca,'FontSize', 14);

%% the fourier transform
% the sampling frequency
fx = prm.value.di;
ft = 1/dt;
% the fourier transform
[sas, hsas, ~] = slj.Physics.fft2d(fx, ft, fd);
% plot the figure
% f2 = figure;
% slj.Plot.field2d_suitable(sas.ft, sas.lk, sas.lw, []);
% xlabel('k_x [d_{i0}^{-1}]');
% ylabel('\omega [\omega_{ci0}]');

f3 = figure;
slj.Plot.field2d_suitable(hsas.ft, hsas.lk, hsas.lw, []);
xlabel('k_x [d_{i0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');
caxis([0, 0.02]);
xlim([0, 5]);
colormap(slj.Plot.mycolormap(1));