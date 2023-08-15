%% plot the total energy of a species
clear;
%% input/outdir
indir='Z:\ion_deceleration\case2';
outdir='C:\Users\Liangjin\Pictures\Asym\case2\out\Test';
prm = slj.Parameters(indir, outdir);

%% the time
dt = 0.5;
tt = 0:dt:100;
xrange = [tt(1) tt(end)];

%% the energy
en=load([indir,'\energy.dat']);
ent = 0.1*(0:size(en,1)-1);
norm = en(1, 2);

%% the species
spcs = 'e';

if spcs == 'i'
    sfx = 'i';
    m = prm.value.mi;
    q = prm.value.qi;
    et = en(:, 4);
elseif spcs == 'e'
    sfx = 'e';
    m = prm.value.me;
    q = prm.value.qe;
    et = en(:, 3);
else
    error('wrong species')
end

%% the space
nt = length(tt);
eng = zeros(nt, 9);

%% the loop
for t = 1:nt
    %% read data
    N = prm.read(['N', spcs], tt(t));
    V = prm.read(['V', spcs], tt(t));
    P = prm.read(['P', spcs], tt(t));
    %% the bulk kinetic energy
    eng(t, 1) = 0.5 * m * sum(N.value .* V.x.^2, 'all');
    eng(t, 2) = 0.5 * m * sum(N.value .* V.y.^2, 'all');
    eng(t, 3) = 0.5 * m * sum(N.value .* V.z.^2, 'all');
    eng(t, 4) = 0.5 * m * sum(N.value .* (V.x.^2 + V.y.^2 + V.z.^2), 'all');
    %% the thermal energy
    eng(t, 5) = 0.5 * sum(P.xx, 'all');
    eng(t, 6) = 0.5 * sum(P.yy, 'all');
    eng(t, 7) = 0.5 * sum(P.zz, 'all');
    eng(t, 8) = 0.5 * sum(P.xy + P.yy + P.zz, 'all');
    %% the total energy
    eng(t, 9) = eng(t, 4) + eng(t, 8);
end

%% plot figure
figure;
% plot(ent, (et - et(1)) / norm, '--k', 'LineWidth', 2);
hold on;
plot(tt, (eng(:, 9) - eng(1, 9)) / norm, '-k', 'LineWidth', 2);
plot(tt, (eng(:, 4) - eng(1, 4)) / norm, '-r', 'LineWidth', 2);
plot(tt, (eng(:, 8) - eng(1, 8)) / norm, '-b', 'LineWidth', 2);
hold off;
xlabel('\Omega_{ci}t');
ylabel(['\Delta E_{', sfx, '}']);
legend('Sum', '\Delta E_{bulk}', '\Delta E_{thermal}', 'Location', 'best', 'Box', 'off');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', '-r300', ['delta_E',sfx, '_energy.png']);


figure;
plot(tt, (eng(:, 1) - eng(1, 1)) / norm, '-r', 'LineWidth', 2);
hold on;
plot(tt, (eng(:, 2) - eng(1, 2)) / norm, '-g', 'LineWidth', 2);
plot(tt, (eng(:, 3) - eng(1, 3)) / norm, '-b', 'LineWidth', 2);
plot(tt, (eng(:, 4) - eng(1, 4)) / norm, '-k', 'LineWidth', 2);
hold off;
xlabel('\Omega_{ci}t');
ylabel(['\Delta E_{bulk, ', sfx, '}']);
legend('\Delta Eb_x', '\Delta Eb_y', '\Delta Eb_z', '\Delta E_{bulk}', 'Location', 'best', 'Box', 'off');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', '-r300', ['delta_E',sfx, '_bulk_energy.png']);


figure;
plot(tt, (eng(:, 5) - eng(1, 5)) / norm, '-r', 'LineWidth', 2);
hold on;
plot(tt, (eng(:, 6) - eng(1, 6)) / norm, '-g', 'LineWidth', 2);
plot(tt, (eng(:, 7) - eng(1, 7)) / norm, '-b', 'LineWidth', 2);
plot(tt, (eng(:, 8) - eng(1, 8)) / norm, '-k', 'LineWidth', 2);
hold off;
xlabel('\Omega_{ci}t');
ylabel(['\Delta E_{thermal, ', sfx, '}']);
legend('\Delta E_{thx}', '\Delta E_{thy}', '\Delta E_{thz}', '\Delta E_{thermal}', 'Location', 'best', 'Box', 'off');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', '-r300', ['delta_E',sfx, '_thermal_energy.png']);



%% plot figure
figure;
plot(ent, et, '--k', 'LineWidth', 2);
hold on;
plot(tt, eng(:, 9), '-k', 'LineWidth', 2);
plot(tt, eng(:, 4), '-r', 'LineWidth', 2);
plot(tt, eng(:, 8), '-b', 'LineWidth', 2);
hold off;
xlabel('\Omega_{ci}t');
ylabel(['\Delta E_{', sfx, '}']);
legend('E', 'Sum', 'E_{bulk}', 'E_{thermal}', 'Location', 'best', 'Box', 'off');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', '-r300', ['E',sfx, '_energy.png']);


figure;
plot(tt, eng(:, 1), '-r', 'LineWidth', 2);
hold on;
plot(tt, eng(:, 2), '-g', 'LineWidth', 2);
plot(tt, eng(:, 3), '-b', 'LineWidth', 2);
plot(tt, eng(:, 4), '-k', 'LineWidth', 2);
hold off;
xlabel('\Omega_{ci}t');
ylabel(['E_{bulk, ', sfx, '}']);
legend('Eb_x', 'Eb_y', 'Eb_z', 'E_{bulk}', 'Location', 'best', 'Box', 'off');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', '-r300', ['E',sfx, '_bulk_energy.png']);


figure;
plot(tt, eng(:, 5), '-r', 'LineWidth', 2);
hold on;
plot(tt, eng(:, 6), '-g', 'LineWidth', 2);
plot(tt, eng(:, 7), '-b', 'LineWidth', 2);
plot(tt, eng(:, 8), '-k', 'LineWidth', 2);
hold off;
xlabel('\Omega_{ci}t');
ylabel(['E_{thermal, ', sfx, '}']);
legend('E_{thx}', 'E_{thy}', 'E_{thz}', 'E_{thermal}', 'Location', 'best', 'Box', 'off');
set(gca, 'FontSize', 14);
cd(outdir);
print(gcf, '-dpng', '-r300', ['E',sfx, '_thermal_energy.png']);