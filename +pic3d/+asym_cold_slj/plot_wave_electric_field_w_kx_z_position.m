%{
%% analysis the electric field Ex in w-kx plane
clear;
%% parameters
% directory
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

% time intervals
dt = 0.1;
tt=20:dt:40;

% normalize
norm = prm.value.vA;

%% the variable
nt = length(tt);
nx = prm.value.nx;
pz = zeros(nt, 1);
tE.x = zeros(nt, nx);
tE.y = zeros(nt, nx);
tE.z = zeros(nt, nx);

%% loop
for t = 1:nt
%% read data
E=prm.read('E', tt(t));
V=prm.read('Ve', tt(t));
N=prm.read('Ne', tt(t));
%% obtain the profile position
JE = V.dot(E);
JE = -JE.value .* N.value;
% the subrange
xrange = 1201:prm.value.nx;
yrange = 415:521;
JE = abs(JE(yrange, xrange));
[sje, pos] = sort(JE(:));
[mz, mx] = ind2sub(size(JE), pos(end-5:end));
% the average position
pz(t) = round(mean(mz(:)) + yrange(1) - 1);

%% obtain the field
tE.x(t, :) = E.x(pz(t), :);
tE.y(t, :) = E.y(pz(t), :);
tE.z(t, :) = E.z(pz(t), :);
end
%}
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
lx = prm.value.lx(x1:x2);
lt = tt(t1:t2);

%% filter

%% plot the field
f1 = figure;
slj.Plot.field2d(fd, lx, lt, []);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
caxis([-1, 1]);
title('Ex');
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
xlabel('k_x [d_{i0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');

f3 = figure;
slj.Plot.field2d_suitable(hsas.ft, hsas.lk, hsas.lw, []);
xlabel('k_x [d_{i0}^{-1}]');
ylabel('\omega [\omega_{ci0}]');