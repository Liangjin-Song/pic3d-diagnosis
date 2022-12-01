clear;
indir = 'E:\Asym\test';
outdir = 'E:\Asym\test';
prm = slj.Parameters(indir, outdir);

B = prm.read('B', 0, 'yrange', prm.value.nx, 200, 1);

lx = prm.value.lx;
lz = linspace(0, 5, 200);
figure;
slj.Plot.field2d(B.x, lx, lz, []);

B=prm.read('B', 0);
figure;
slj.Plot.field2d(B.x, prm.value.lx, prm.value.lz, []);