%%
% writen by Liangjin Song on 20220326 at Nanchang University
% test the paremeters for the asym-rec model
%%
clear;
%% parameters
% size in y direction
ny = 1000;

% the inertial length of ion
di = 40;

% the number particles per cell
ppc = 500;

% the mass ratio between ion and electron
mie = 100;

% the half width of the current sheet
L=0.5;

% the magnetic ratio between Bsh and Bsh
Br = 1/2;

% the beta value at the magnetosheath side
betas = 6;

% the temperature between Tsh and Tsp
Tr = 1/4;

% the temperature between ions and electrons, Ti/Te
Tie = 4;

% the ratio between electron plasma frequency and gryofrequency
% at the magnetosheath
fr = 2;

% the current ratio between ion and electron, rate = Ji/Je
jrate = Tie;

%% the light speed
c = 0.5;
mu0 = 1/(c*c);


%% calculate
% the array in y-direction
y = 1:ny;
% the current sheet position
y0 = ny/2 + 0.5;
% the current sheet width
L = L*di;
% the electron inertial length
de = di/sqrt(mie);

%% calculation
%% the magnetic field Bx distribution
Bx = atanh((Br - 1)/(Br + 1));
Bx = (y - y0)/L + Bx;
Bx = -tanh(Bx);
Bx = Bx * (Br + 1)/2;
Bx = Bx - (Br - 1)/2;
Bx = Bx/Br;

%% the ion temperature distribution
% electron temperature
Te = tanh((y - y0)/L) + 1;
Te = Te*(Tr - 1)/2 + 1;
Te = Te/Tr;

%% the total pressure
Bsh = -1;
P = (1 + betas) * Bsh * Bsh/(2*mu0);

%% the density distribution
Pb = Bx.^2/(2*mu0);
N = (P-Pb)./((1 + Tie)*Te);

%% coefficient
coeff = ny*ppc/sum(N, 'all');

N = N * coeff;
Te = Te / coeff;
% electron temperature
Ti = Te*Tie;

%% pressure
Pi = Ti.*N;
Pe = Te.*N;
PP = Pb + Pi + Pe;

%% parameters at the lobe region
Bsp = abs(Bsh)/Br;
Nsh = N(end);
Nsp = N(1);
Tish = Ti(end);
Tisp = Ti(1);
Tesh = Te(end);
Tesp = Te(1);

%% frequency
wpe = c / de;
wce = wpe / fr;
wpi = c / di;
wci = wce / mie;

%% mass and charge
me = fr*abs(Bsh);
me = me*me;
me = me / Nsh;
mi = me * mie;
qi = wci * mi / abs(Bsh);
qe = -qi;

%% the current density
n = length(Bx);
J = zeros(1, n);
J(2:end) = Bx(2:end) - Bx(1:end - 1);
J = J / mu0;

%% the plasma bulk velocity
% the plasma current
ki = jrate/(1 + jrate);
ke = 1/(1 + jrate);
Ji = J*ki;
Je = J*ke;
% the velocity
Vi = Ji ./ (qi*N);
Ve = -Je./ (qi*N);

%% the thermal energy
Ui = Pi *3/2;
Ue = Pe *3/2;

%% the bulk kinetic energy
Ki = 0.5 .* mi .* N .* Vi .* Vi;
Ke = 0.5 .* me .* N .* Ve .* Ve;

%% the total energy
Ei = Ki + Ui;
Ee = Ke + Ue;

%% debye length
lambda = sqrt(Te./(N*qi*qi));

%% the ration between light speed and Alfven speed
vA = abs(Bx) ./ (sqrt(mu0*N*mi));
rcvA = c./vA;


%% plot figure
Ly = ny/di;
y = linspace(-Ly/2, Ly/2, ny);
xrange=[y(1), y(end)];
% magnetic field
f1 = figure;
plot(y, Bx, '-k', 'LineWidth', 1);
xlabel('Z');
ylabel('Bx');
set(gca, 'FontSize', 14);
xlim(xrange);

% temperature
f2 = figure;
plot(y, Ti*coeff, '-k', 'LineWidth', 1);
hold on
plot(y, Te*coeff, '-r', 'LineWidth', 1);
legend('Ti', 'Te');
xlabel('Z');
ylabel('T');
set(gca, 'FontSize', 14);
xlim(xrange);

% density
f3 = figure;
plot(y, N, '-k', 'LineWidth', 1);
xlabel('Z');
ylabel('N');
set(gca, 'FontSize', 14);
disp(['Nsh/Nsp = ', num2str(Nsh/Nsp)]);
xlim(xrange);


% pressure
f4 = figure;
plot(y, Pi, '-r', 'LineWidth', 1);
hold on
plot(y, Pe, '-b', 'LineWidth', 1);
plot(y, Pb, '-g', 'LineWidth', 1);
plot(y, PP, '-k', 'LineWidth', 1);
legend('Pi', 'Pe', 'Pb', 'P');
xlabel('Z');
ylabel('P');
set(gca, 'FontSize', 14);
xlim(xrange);

% thermal energy
E = [sum(Pb), sum(Ui), sum(Ue)];
f5 = figure;
X = categorical({'Pb','Ui','Ue'});
X = reordercats(X,{'Pb','Ui','Ue'});
bar(X, E, 'b');
ylabel('Thermal Energy');
set(gca, 'FontSize', 14);

% total energy
E = [sum(Pb), sum(Ei), sum(Ee)];
f6 = figure;
X = categorical({'Eb','Ei','Ee'});
X = reordercats(X,{'Eb','Ei','Ee'});
bar(X, E, 'b');
ylabel('Total Energy');
set(gca, 'FontSize', 14);

f7 = figure;
plot(y,lambda, '-k','LineWidth',1);
xlabel('Z');
ylabel('\lambda_D');
set(gca, 'FontSize', 14);
xlim(xrange);

Bsh = abs(Bsh);
Bsp = abs(Bsp);
vA_asym = sqrt(Bsh * Bsp * (Bsh + Bsp)/(mu0 * mi * (Nsh * Bsp + Nsp * Bsh)));
disp(['v_{A,asym} = ', num2str(vA_asym)]);

f8 = figure;
plot(y,rcvA, '-k','LineWidth',1);
xlabel('Z');
ylabel('c/v_{A}');
set(gca, 'FontSize', 14);
ylim([0,100]);
xlim(xrange);