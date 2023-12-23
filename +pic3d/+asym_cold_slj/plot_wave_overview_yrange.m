%% plot the overveiw of yrange data
clear;
%% parameters
% directory
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

tt = 20;

% load data
E=prm.read('E', tt, 'yrange', prm.value.nx, 200, 1);

lx=prm.value.lx;
lz=prm.value.lz(401:600);

% plot
figure;
[X, Z]=meshgrid(lx,lz);
pcolor(X,Z,E.x);
shading interp;
colorbar;
axis equal;
ylim(lz([1 end]));
