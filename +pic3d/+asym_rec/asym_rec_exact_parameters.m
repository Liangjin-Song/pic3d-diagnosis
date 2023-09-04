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


%% the constant value of a0s, a1s, a2s, and b
a0s = 0.5;
a1s = 0.5;
a2s = 0.5;
b = 0.5;

%% the light speed
c = 0.5;
mu0 = 1/(c*c);

%% the magnetic field profile
C1 = (Br - 1)/2;
C2 = (Br + 1)/2;
Bx = C1 + C2 * tanh(y);

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

%% the magnetosheath plasma density
n0 = betas / (2 * mu0) / (1 + tie);


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
xlabel('Y');
ylabel('N');
xlim(xrange);
set(gca, 'fontsize', 14);

%% plot figure, pressure
figure;
plot(y, Pb + Pth, '-k', 'linewidth', 2);
hold on;
plot(y, Pb, '-r', 'linewidth', 2);
plot(y, Pth, '-b', 'linewidth', 2);
hold off;
legend('P', 'Pb', 'Pth');
xlabel('Y');
ylabel('P');
xlim(xrange);
set(gca, 'fontsize', 14);