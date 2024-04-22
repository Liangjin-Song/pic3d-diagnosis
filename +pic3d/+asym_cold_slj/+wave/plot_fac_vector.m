%% plot the vector in field-aligned coordinates
clear;

%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave\0';
prm=slj.Parameters(indir, outdir);

tt = 28;
name = 'E';
norm = prm.value.vA;

%% load data
cd(indir);
B = prm.read('B', tt);
V = prm.read(name, tt);
ss = prm.read('stream', tt);

%% f-a coordinates
[para, perp] = V.fac_vector(B);
para = para.sqrt();

%% plot
figure;
slj.Plot.overview(para, ss, prm.value.lx, prm.value.lz, norm, []);
xlabel('X [d_i]');
ylabel('Z [d_i]');