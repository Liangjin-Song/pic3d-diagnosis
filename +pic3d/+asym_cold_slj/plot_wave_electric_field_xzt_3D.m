clear;
%% parameters
indir='E:\Asym\cold2_ds1\wave';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

dt = 0.005;
tt=30:dt:30;
name='e';
cmptE = 'x';
cmptB = 'z';

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
nz = length(yrange);
tE = zeros(nz, nx, nt);
tB = zeros(nz, nx, nt);

for t=1:nt
    %% read data
    fd = prm.read('E', tt(t), 'yrange', prm.value.nx, 200, 1);
    if cmptE == 'x'
        fd = imfilter(fd.x, fspecial('average', [5,5]));
    elseif cmptE == 'y'
        fd = imfilter(fd.y, fspecial('average', [5,5]));
    else
        fd = imfilter(fd.z, fspecial('average', [5,5]));
    end
    tE(:, :, t) = fd(yrange, xrange);
    fd = prm.read('B', tt(t), 'yrange', prm.value.nx, 200, 1);
    if cmptB == 'x'
        B = fd.x(yrange, xrange);
    elseif cmptB == 'y'
        B = fd.y(yrange, xrange);
    else
        B = fd.z(yrange, xrange);
    end
    tB(:, :, t) = B(:, :);
end

cd(outdir);
wE = fftn(tE);
wE = sum(wE, 3);
wE = fftshift(wE);


k = 2*pi/prm.value.debye;
kx = linspace(-k*0.5, k*0.5, nx);
kz = linspace(-k*0.5, k*0.5, nz);
[X, Y] = meshgrid(kx, kz);


f1 = figure;
p = pcolor(X, Y, abs(wE));
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('kx [2\pi/\lambda_D]');
ylabel('kz [2\pi/\lambda_D]');
title('PSD, Ex');
xlim([0, kx(end)]);
ylim([0, kz(end)]);
set(gca,'FontSize',14);
% print(f1, '-dpng','-r300','PSD_E_kx_kz.png');