%% plot the temperature ratio between electron and all ions
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
prm=slj.Parameters(indir, outdir);

%% time
tt = 30;

%% range
extra = [];
yrange = [-10, 10];
norm = 1;

%% read data
Pe = prm.read('Pe', tt);
Ne = prm.read('Ne', tt);
Pic = prm.read('Ph', tt);
Nic = prm.read('Nh', tt);
Pih = prm.read('Pl', tt);
Nih = prm.read('Nl', tt);
ss = prm.read('stream', tt);

%% scalar pressure
Pe = Pe.scalar();
Pic = Pic.scalar();
Pih = Pih.scalar();
Pi = Pic + Pih;
Ni = Nic + Nih;

%% temperature
Te = Pe.value ./ Ne.value;
Ti = Pi.value ./ Ni.value;

%%
figure;
slj.Plot.overview(Ti./Te, ss, prm.value.lx, prm.value.lz, norm, extra);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca, 'FontSize', 14);
title(['Ti/Te, \Omega_{ci}t = ', num2str(tt)]);
cd(outdir);
print('-dpng','-r300', ['rTie_t',num2str(tt, '%06.2f'), '.png']);