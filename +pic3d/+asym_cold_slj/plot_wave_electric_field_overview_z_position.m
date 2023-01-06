clear;
%% parameters
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

dt = 0.005;
tt=20:dt:40;
name='e';
cmpt = 't';


%% the subrange
xrange = 1401:prm.value.nx;
yrange = 1:200;

nt=length(tt);

extra=[];

normE = prm.value.vA;

if name == 'l'
    sfx='ih';
elseif name == 'h'
    sfx='ic';
elseif name == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end

pz = zeros(nt, 1);
% nx = prm.value.nx;
nx = length(xrange);
tE = zeros(nt, nx);
tB = zeros(nt, nx);

for t=1:nt
    %% read data
    fd = prm.read('E', tt(t), 'yrange', prm.value.nx, 200, 1);
    fd = imfilter(fd.x, fspecial('average', [5,5]));
    E = fd(yrange, xrange);
    fd = prm.read('B', tt(t), 'yrange', prm.value.nx, 200, 1);
    B = fd.z(yrange, xrange);
   %% obtain the range
    re = abs(E);
    %% obtain the maximum value position
    [~, pos] = sort(re(:));
    [mz, mx] = ind2sub(size(re), pos(end-1:end));
    %% the average position
    pz(t) = round(mean(mz(:)) + yrange(1) - 1);
    %% obtain the field
    tE(t, :) = E(pz(t), :);
    tB(t, :) = B(pz(t), :);
end

cd(outdir);
%% plot the field
f1 = figure;
slj.Plot.field2d(tE/normE, prm.value.lx(xrange), tt, extra);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
caxis([-1, 1]);
title('Ex');
set(gca,'FontSize', 14);
print(f1, '-dpng','-r300','E_x_t.png');

%% Fourier transform
fE = fftshift(fft2(tE));
fB = fftshift(fft2(tB));
% dx = 1/40;
% k = 2*pi/dx;
k = 2*pi/prm.value.debye;
k = linspace(-k*0.5, k*0.5, nx);
pdt = dt * prm.value.fpi/prm.value.wci;
f = 1/pdt;
f = linspace(-f*0.5, f*0.5, nt);
[X, Y] = meshgrid(k, f);

%% E
f2 = figure;
p = pcolor(X, Y, abs(fE));
shading flat;
p.FaceColor = 'interp';
colorbar;
% xlabel('k [2\pi/di]');
% ylabel('\omega [\omega_{ci}]');
xlabel('k [2\pi/\lambda_D]');
ylabel('\omega [\omega_{pi}]');
title('PSD, Ex');
set(gca,'FontSize',14);
print(f2, '-dpng','-r300','PSD_E_k_w.png');

%% magnetic field
f3 = figure;
slj.Plot.field2d(tB, prm.value.lx(xrange), tt, extra);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
title('Bz');
set(gca,'FontSize', 14);
print(f3, '-dpng','-r300','Bz_x_t.png');

%%
f4 = figure;
p = pcolor(X, Y, abs(fB));
shading flat;
p.FaceColor = 'interp';
colorbar;
% xlabel('k [2\pi/di]');
% ylabel('\omega [\omega_{ci}]');
xlabel('k [2\pi/\lambda_D]');
ylabel('\omega [\omega_{pi}]');
title('PSD, Bz');
set(gca,'FontSize',14);
print(f4, '-dpng','-r300','PSD_B_k_w.png');