%% test the agyrotropy
clear;
%% parameters
indir='E:\Asym\Bg';
outdir='E:\Asym\Bg';
prm=slj.Parameters(indir,outdir);

tt = 30;
extra = [];

%% read data
P = prm.read('Pe', tt);
B = prm.read('B', tt);
ss = prm.read('stream', tt);

%% simulation system
q_sim = slj.Physics.agyrotropy(P, B, prm);

%% fac system
[aphi, dng, q_fac, pp_fac] = slj.Physics.agyrotropy_fac(P, B, prm);


%% get data
% xz = 30;
% dir = 1;
% q_sim = slj.Scalar(q_sim);
% ll=q_sim.get_line2d(xz, dir, prm, 1);
% plot(prm.value.lz, ll, '-k','LineWidth', 1.5);
% xlabel('Z [c/\omega_{pi}]');
% xlim([-5,5]);
% print('-dpng', '-r300', ['Pe_sqrtQ_sim_t', num2str(tt, '%06.2f'), '_x=30.png']);


f1 = figure;
slj.Plot.overview(q_sim,ss,prm.value.lx,prm.value.lz, 1, extra);
% caxis([0,0.15]);
ylim([-10,10]);
title('sim');
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca, 'FontSize', 14);

f2 = figure;
slj.Plot.overview(q_fac,ss,prm.value.lx,prm.value.lz, 1, extra);
ylim([-10,10]);
% caxis([0,0.15]);
title('fac');
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca, 'FontSize', 14);

cd(outdir);
print(f1, '-dpng', '-r300', ['Pe_sqrtQ_sim_t', num2str(tt, '%06.2f'), '.png']);
print(f2, '-dpng', '-r300', ['Pe_sqrtQ_fac_t', num2str(tt, '%06.2f'), '.png']);