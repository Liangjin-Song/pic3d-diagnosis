%{
%% analysis the electric field Ex in w-kx plane
clear;
%% parameters
% directory
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

% the position of the profile
xx = 40;
[~, px] = min(abs(prm.value.lx - xx));

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
nz = 200;
tE.x = zeros(nt, nz);
tE.y = zeros(nt, nz);
tE.z = zeros(nt, nz);

%% loop
cd(indir);
for t = 1:nt
%% read data
E=prm.read(name, tt(t), 'yrange', prm.value.nx, 200, 1);

%% obtain the field
tE.x(t, :) = E.x(:, px)';
tE.y(t, :) = E.y(:, px)';
tE.z(t, :) = E.z(:, px)';
end
%}
cd(outdir);
%% backup
E = tE;

fd=E.x/norm;
lz=prm.value.lz(401:600);
%% select the range
t1 = 20;
t2 = 40;
[~, t1] = min(abs(tt - t1));
[~, t2] = min(abs(tt - t2));
fd = fd(t1:t2, :);
lt = tt(t1:t2);

%% plot the field
f1 = figure;
slj.Plot.field2d(fd, lz, lt, []);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
% caxis([-1, 1]);
title('Ez');
set(gca,'FontSize', 14);

%% the fourier transform
% the sampling frequency
fx = prm.value.di;
ft = 1/dt;
% the fourier transform
[sas, hsas, ~] = slj.Physics.fft2d(fx, ft, fd);
% plot the figure
f2 = figure;
slj.Plot.field2d_suitable(sas.ft, sas.lk, sas.lw, []);
xlabel('k_z [d_{i0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');

f3 = figure;
slj.Plot.field2d_suitable(hsas.ft, hsas.lk, hsas.lw, []);
xlabel('k_z [d_{i0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');