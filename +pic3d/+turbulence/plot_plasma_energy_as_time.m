%% plot the bulk kinetic energy and thermail energy as a function of time
clear;
%% parameters
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\global';
prm = slj.Parameters(indir, outdir);

tt = 0:149;
spc = 'e';

if spc == 'i'
    m = prm.value.mi;
    q = prm.value.qi;
    vt = prm.value.vith;
    name = 'ion';
    n = 4;
else
    m = prm.value.me;
    q = prm.value.qe;
    vt = prm.value.veth;
    name = 'electron';
    n = 3;
end

en=load([indir,'\energy.dat']);
norm = en(1, n);
% norm = m * prm.value.n0 * prm.value.v.^2;

%% memory
nt = length(tt);
en = zeros(3, nt);

%% loop
for t = 1:nt
    %% read data
    cd(indir);
    N = prm.read(['N', spc], tt(t));
    V = prm.read(['V', spc], tt(t));
    P = prm.read(['P', spc], tt(t));
    %% bulk kinetic energy
    K = 0.5 .* N.value .* m .* (V.x.^2 + V.y.^2 + V.z.^2);
    %% thermal energy
    U = 0.5 .* (P.xx + P.yy + P.zz);
    %% save
    en(1, t) = sum(K, 'all');
    en(2, t) = sum(U, 'all');
    en(3, t) = en(1, t) + en(2, t);
end
en0 = en;
en = en0 ./ norm;

%% figure;
figure;
hold on
plot(tt, en(1, :), '-r', 'LineWidth', 2);
plot(tt, en(2, :), '-b', 'LineWidth', 2);
plot(tt, en(3, :), '-k', 'LineWidth', 2);
legend('K', 'U', 'Sum', 'Box', 'off', 'Location', 'Best');
xlabel('t');
ylabel('E');
title([name, ' energy']);
set(gca, 'FontSize', 14);

cd(outdir);
print('-dpng', '-r300', [name, '_energy_as_time.png']);