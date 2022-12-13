clear;
indir = 'E:\Asym\cold2_ds1\wave';
outdir = 'E:\Asym\cold2_ds1\out\Wave\range_overview';
prm = slj.Parameters(indir, outdir);

tt = 30;
name = 'E';
norm = prm.value.vA;
% norm = 1;

fd = prm.read(name, tt, 'yrange', prm.value.nx, 200, 1);


lx = prm.value.lx;
lz = prm.value.lz(401:600);
fd = fd.x/norm;

%% filter
h = fspecial('average', [5,5]);
fd = imfilter(fd, h);


%% figure
figure;
slj.Plot.field2d(fd, lx, lz, []);
xlabel('X [c/\omega_{pi}]');
zlabel('Z [c/\omega_{pi}]');
title([name, 'x, \Omega_{ci}t = ', num2str(tt)]);
cd(outdir);
% print('-dpng', '-r300',[name, '_range_t', num2str(tt, '%07.3f'), '.png']);

% fd = prm.read(name, tt);
% figure;
% slj.Plot.field2d(fd.x, prm.value.lx, prm.value.lz, []);