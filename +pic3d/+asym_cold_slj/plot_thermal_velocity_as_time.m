%% plot thermal velocity
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

%% time 
tt = 0:0.5:60;

%% range
xrange = 1401:1801;
yrange = 401:601;
dz = 20;

%% space
nt = length(tt);
vth = zeros(nt, 4);

%% loop
for t = 1:nt
    cd(indir);
    E=prm.read('E',tt(t));
    E = imfilter(E.x, fspecial('average', [5,5]));
    E = E(yrange, xrange);
    %% obtain the maximum value position
    [~, pos] = sort(abs(E));
    [mz, mx] = ind2sub(size(E), pos(end-1:end));
    %% the average position
    pz = round(mean(mz(:)) + yrange(1) - 1);
    zrange = pz-dz:pz+dz;
    %% electron thermal velocity
    Pe = prm.read('Pe', tt(t));
    Ne = prm.read('Ne', tt(t));
    vth(t, 1) = calc_average_thermal_velocity(Pe, Ne, zrange, xrange, prm.value.me);
    %% cold ion thermal velocity
    Pic = prm.read('Ph', tt(t));
    Nic = prm.read('Nh', tt(t));
    vth(t, 2) = calc_average_thermal_velocity(Pic, Nic, zrange, xrange, prm.value.mi);
    %% hot ion thermal velocity
    Pih = prm.read('Pl', tt(t));
    Nih = prm.read('Nl', tt(t));
    vth(t, 3) = calc_average_thermal_velocity(Pih, Nih, zrange, xrange, prm.value.mi);
    %% all ion thermal velocity
    vth(t, 4) = calc_average_thermal_velocity(Pic + Pih, Nic + Nih, zrange, xrange, prm.value.mi);
end

%% plot figure
norm = prm.value.vA;
figure;
plot(tt, vth(:, 1)/norm, '-r', 'LineWidth', 2);
hold on
plot(tt, vth(:, 2)/norm, '-g', 'LineWidth', 2);
plot(tt, vth(:, 3)/norm, '-b', 'LineWidth', 2);
plot(tt, vth(:, 4)/norm, '-k', 'LineWidth', 2);
hold off
xlabel('\Omega_{ci} t');
ylabel('V_{thermal} [V_A]');
% legend('Electron', 'Cold Ion', 'Hot Ion', 'Ion');
legend('Cold Ion', 'Hot Ion', 'Ion');
set(gca, 'FontSize', 14);
cd(outdir);
% print('-dpng','-r300','Vth_all.png');



function vth = calc_average_thermal_velocity(P, N, zrange, xrange, mass)
    P = P.scalar();
    P = sum(P.value(zrange, xrange), 'all');
    N = sum(N.value(zrange, xrange), 'all');
    T = P/N;
    vth = sqrt(T/mass);
end