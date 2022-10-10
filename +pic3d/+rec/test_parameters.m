%%
% writen by Liangjin Song on 20220326 at Nanchang University
% test the paremeters for the asym-rec model
%%
clear;
%%
% size in y direction
y = -10:0.01:10;

% current sheet position
y0 = 0;

% the half-width of the current sheet
L = 1;

% the magnetic ratio between Bsh and Bsh
Br = 0.5;

% the beta value at the magnetosheath side
betas = 5;

% the temperature between Tsh and Tsp
Tr = 0.5;

% the temperature between electrons and ions
Tie = 4;
theta = 1/Tie;

%% the light speed
c = 0.5;
mu0 = 1/(c*c);

%% calculation
%% the magnetic field Bx distribution
Bx = atanh((Br - 1)/(Br + 1));
Bx = (y - y0)/L + Bx;
Bx = -tanh(Bx);
Bx = Bx * (Br + 1)/2;
Bx = Bx - (Br - 1)/2;
Bx = Bx/Br;

%% the ion temperature distribution
Ti = tanh((y - y0)/L) + 1;
Ti = Ti*(Tr - 1)/2 + 1;
Ti = Ti/Tr;
Te = Ti*theta;

%% the total pressure
Bsh = -1;
P = (1 + betas) * Bsh * Bsh/(2*mu0);

%% the density distribution
Pb = Bx.^2/(2*mu0);
N = (P-Pb)./((1 + theta)*Ti);


%% plot figure
% magnetic field
f1 = figure;
plot(y, Bx, '-k', 'LineWidth', 1);
xlabel('Z');
ylabel('Bx');
set(gca, 'FontSize', 14);

% temperature
f2 = figure;
plot(y, Ti, '-k', 'LineWidth', 1);
hold on
plot(y, Te, '-r', 'LineWidth', 1);
legend('Ti', 'Te');
xlabel('Z');
ylabel('T');
set(gca, 'FontSize', 14);

% density
f3 = figure;
plot(y, N, '-k', 'LineWidth', 1);
xlabel('Z');
ylabel('N');
set(gca, 'FontSize', 14);


% pressure
Pi = Ti.*N;
Pe = Te.*N;
PP = Pb + Pi + Pe;
f4 = figure;
plot(y, Pi, '-r', 'LineWidth', 1);
hold on
plot(y, Pe, '-b', 'LineWidth', 1);
plot(y, PP, '-k', 'LineWidth', 1);
legend('Pi', 'Pe', 'P');
xlabel('Z');
ylabel('P');
set(gca, 'FontSize', 14);