%% plot the intermittence
clear;
%% parameters
indir='Y:\turbulence5.55';
outdir='C:\Users\Liangjin\Pictures\Turbulence\Energy';
prm=slj.Parameters(indir,outdir);

%%
tt = 90;
xz = 10;
name = 'J';
norm = 1;

%% read data
fd = prm.read(name, tt);
lfd = fd.get_line2d(xz, 1, prm, norm);
lf = lfd.ly;
lf = fd.y(:);

%% spectrum
[ll, pdf] = slj.Physics.intermittence(lf, 200);

%%
figure;
plot(ll, log10(pdf), '-k', 'LineWidth', 2);