%% test the parameters for exact Maxwell Vlasov equilibrium
clear;

%% system size
ny = 2000;
y0 = ny/2 + 0.5;

%% half-width of the current sheet
L = 1;

%% the mass ratio and ion inertial length
mie = 100;
di = 40;

%% the system size
y = ((1:ny) - y0) / (L * 40);

% the number particles per cell
ppc = 500;

%% the magnetic field asymmetry
Br = 2;

%% the guide field, Br = Bsp/Bsh
Bg = 0;

%% the temperatuer ratio between magnetosphere and magnetosheath, Tr = Tsp/Tsh
Tr = 2;
%% the temperature ratio between ions and electrons, Tie = Ti/Te
tie = 2;

%% the plasma beta at the magnetosheath
betas = 5;

%% the ratio between electron plasma frequency and gryofrequency
% at the magnetosheath
fr = 2;

%% the light speed
c = 0.5;
mu0 = 1/(c*c);

%% the magnetic field profile
C1 = (Br - 1)/2;
C2 = (Br + 1)/2;
Bx = C1 + C2 * tanh(y);
C3 = Bg;

%% the current density
Jy =  - C2 * sech(y).^2 / mu0;

%% the plasma temperature
t1 = (Tr + 1) / 2;
t2 = (Tr - 1) / 2;
Te = t1 + t2 * tanh(y);
Ti = tie * Te;

%% the total pressure, here, Bsh = -1
P = (1 + betas) / (2 * mu0);

%% the magnetic pressure
Pb = Bx.^2 / (2 * mu0);

%% the plasma density
Pth = P - Pb;
N = Pth ./ (Te + Ti);

%% the coefficient
coeff = ny*ppc/sum(N, 'all');

N = N * coeff;
Te = Te / coeff;
Ti = Ti / coeff;

%% pressuer
Pi = N .* Ti;
Pe = N .* Te;
PP = Pi + Pe + Pb;

%% the frequency
de = di / sqrt(mie);
wpe = c / de;
wce = wpe / fr;
wpi = c / di;
wci = wce / mie;


%% the magnetosheath plasma density
n0 = coeff * betas / (2 * mu0) / (1 + tie);

%% mass and charge, Bsh = -1
me = fr*abs(-1);
me = me*me;
me = me / n0;
mi = me * mie;
qi = wci * mi / abs(-1);
qe = -qi;

%% the thermal velocity
vti = sqrt(Ti ./ mi);
vte = sqrt(Te ./ me);
betai = 1./ Ti;
betae = 1./ Te;

%% the constant value of a0, a1, a2, and b
B0 = 1;
pb0 = B0 .* B0 ./ (2 .* mu0);
rbeta = (betai .* betae) ./ (betai + betae);
b = (C1 + C2).^2 + C3.^2;
b = b .* pb0;
b = P - b;
b = b .* rbeta;

a0 = 4 .* C1 .* C2 .* pb0;
a0 = a0 .* rbeta;

a1 = -1 .* C1 .* C2 .* pb0;
a1 = a1 .* rbeta;

a2 = C2 .* (C2 - C1) .* pb0;
a2 = a2 .* rbeta;

%% the constant value of u and v
L = 1;
e = qi;
tmp = (C1 - C2) ./ (C2 .* C3 .* B0 .* L);
uxi = tmp ./ (e .* betai);
uxe = tmp ./ (-e .* betae);

tmp = 1 ./ (C2 .* B0 .* L);
uyi = tmp ./ (e .* betai);
uye = tmp ./ (-e .* betae);

tmp = (2 .* C1) ./ (C2 .* C3 .* B0 .* L);
vxi = tmp ./ (e .* betai);
vxe = tmp ./ (-e .* betae);

tmp = 2./ (C2 .* B0 .* L);
vyi = tmp ./ (e .* betai);
vye = tmp ./ (-e .* betae);

%% the density profile of each population
N0 = a0 .* exp(-y) .* sech(y);
N1 = a1 .* exp(-2 * y) .* sech(y).^2;
N2 = a2 .* sech(y).^2;
Ns = N0 + N1 + N2 + b;

%% plot figure, magnetic field profile
xrange = [y(1), y(end)];
figure;
plot(y, Bx, '-k', 'linewidth', 2);
xlabel('Y');
ylabel('Bx');
xlim(xrange);
set(gca, 'fontsize', 14);

%% plot figure, current density
figure;
plot(y, Jy, '-k', 'linewidth', 2);
xlabel('Y');
ylabel('Jy');
xlim(xrange);
set(gca, 'fontsize', 14);

%% plot figure, plasma temperature
figure;
plot(y, Te, '-r', 'linewidth', 2);
hold on;
plot(y, Ti, '-b', 'linewidth', 2);
legend('Te', 'Ti');
xlabel('Y');
ylabel('Te, Ti');
xlim(xrange);
set(gca, 'fontsize', 14);

%% plot figure, plasma density
figure;
plot(y, N, '-k', 'linewidth', 2);
hold on;
plot(y, Ns, '--r', 'linewidth', 2);
legend('N', 'Ns');
xlabel('Y');
ylabel('N');
xlim(xrange);
set(gca, 'fontsize', 14);

figure;
plot(y, N0, '-m', 'linewidth', 2);
hold on;
plot(y, N1, '-r', 'linewidth', 2);
plot(y, N2, '-b', 'linewidth', 2);
plot(y, b, '-g', 'linewidth', 2);
plot(y, Ns, '--k', 'linewidth', 2);
legend('N0', 'N1', 'N2', 'b', 'Ns');
xlabel('Y');
ylabel('N');
xlim(xrange);
set(gca, 'fontsize', 14);

%% plot figure, pressure
figure;
plot(y, PP, '-k', 'linewidth', 2);
hold on;
plot(y, Pb, '-r', 'linewidth', 2);
plot(y, Pi, '-b', 'linewidth', 2);
plot(y, Pe, '-g', 'linewidth', 2);
hold off;
legend('P', 'Pb', 'Pi', 'Pe');
xlabel('Y');
ylabel('P');
xlim(xrange);
set(gca, 'fontsize', 14);