%% asymmetric reconnection with cold ions initialization, asym-slj2
% writen by Liangjin Song
clear;
%% parameters
% directory
dir='E:\Asym\Cold1\out\Global';
% the box size
ny = 10000;

% the ineral lengthe of hot ions
dih = 200;

% the number electrons per cell
ppc = 200;

% the mass ratio between ion and electron
mie = 1836;

% the half width of the current sheet
L=0.7;

% Br =|Bsheath∕Bsphere|, the magnetic field ratio between both sides of the current sheet
Br=1/2;

% Tr=Tsheath∕Tsphere the temperature ratio between both sides of the current sheet
Tr=1/4;

% density ratio between cold ions and the hot ions density at the magnetosphere side
phi=10;

% the distance between cold ions and the current sheet
s=0;

% temperature ratio between hot ions and cold ions at the magnetosphere side
theta2=100;

% the temperature ratio between electron and hot ion
theta1=1/5;

% the beta value at the magnetosheath
betas=10;

% the ratio between electron plasma frequency and gryofrequency
fr = 10;

% the current ratio between ion and electron, rate = Ji/Je
jrate = 1/theta1;

% the light speed
c=0.5;
mu0=1/(c*c);

%% calculate
% the array in y-direction
y = 1:ny;
% the current sheet position
y0 = ny/2 + 0.5;
% the current sheet width
L = L*dih;
% electron ineral length
de = dih/sqrt(mie);
dic = dih;


%% magnetic field profiles of asymmetric reconnection
B = magnetic_field(Br, y, y0, L);

%% plasma temperature
[Tih, Tic, Te, Tish] = plasma_temperature(Tr, theta1, theta2, y, y0, L);

%% plasma density
[P, Pb, Nih, Nic, N, Bsh, Bsp] = plasma_density(mu0, betas, Br, Tr, Tish, Tic, theta1, phi, y, y0, s, L, Te, Tih, B);

%% coefficient
coeff = coefficient(ny, ppc, N);

%% reset the temperature and density
% plasma density
N = N*coeff;
Nih = Nih * coeff;
Nic = Nic * coeff;
% temperature
Tih = Tih/coeff;
Tic = Tic/coeff;
Te = Te/coeff;
Tish = Tish/coeff;

%% pressure
[Pih, Pic, Pe, Pp]=pressure(Tih, Nih, Te, N, Nic, Tic, Pb);

%% frequency
[wpe, wce, wpih, wcih, wpic, wcic]=frequency(c, de, fr, mie, dih, dic);

%% mass and charge
% the asymptotic magnetic field
bsym = (abs(Bsh) + abs(Bsp))*0.5;
% the asymptotic density
encs = (N(1) + N(end))*0.5;
% mass and charge
[mi, me, qi, qe] = qm(bsym, encs, fr, mie, wcih);

%% calculate the current density
J=current(B, mu0);

%% the electron and ion bulk velocity
[vih, ve] = velocity(J, qi, N, Nih, jrate);

%% thermal energy
[Uih, Uic, Ue]=thermal(Pih, Pic, Pe);

%% bulk kinetic energy
[Kih, Ke] = kinetic(mi, me, Nih, N, vih, ve);
Kic = zeros(1, ny);

%% Alfven speed
[Vaih, Vae, Vaic, Vai] = alfven(B, mu0, mi, me, Nih, Nic, N);

%% plot figure
Ly = ny/dih;
ly = linspace(-Ly/2, Ly/2, ny);
xrange = [-Ly/2, Ly/2];
fs=15;
lw=2;
% magnetic field
f1=figure;
plot(ly,B,'-k','LineWidth',lw);
xlabel('Z');
ylabel('Bx');
xlim(xrange);
set(gca,'FontSize',fs);

% the temperature
f2=figure;
plot(ly,Tih,'-r','LineWidth',lw);
hold on
plot(ly,Te,'-b','LineWidth',lw);
hold off
xlabel('Z');
ylabel('T');
legend('Tih', 'Te');
xlim(xrange);
set(gca,'FontSize',fs);

% density
f3=figure;
plot(ly,N,'-k','LineWidth',lw); hold on
plot(ly,Nic,'-r','LineWidth',lw);
plot(ly,Nih,'-b','LineWidth',lw); hold off
legend('Nic+Nih','Nic','Nih','Location','Best');
xlabel('Z');
ylabel('N');
xlim(xrange);
set(gca,'FontSize',fs);

% pressure
f4=figure;
plot(ly,Pp,'-k','LineWidth',lw); hold on
plot(ly,Pb,'-r','LineWidth',lw);
plot(ly,Pic,'-g','LineWidth',lw);
plot(ly,Pih,'-b','LineWidth',lw);
plot(ly,Pe,'-m','LineWidth',lw); hold off
legend('P_{tot}','Pb','Pic','Pih','Pe','Location','Best');
xlabel('Z');
ylabel('Pressure');
xlim(xrange);
set(gca,'FontSize',fs);

% check the Ampere's law
f5 = figure;
plot(ly, J, '-k', 'LineWidth', lw);
hold on
plot(ly, qi.*Nih.*vih, '-r', 'LineWidth', lw);
plot(ly, qe.*N.*ve, '-b', 'LineWidth', lw);
plot(ly, qi.*Nih.*vih+qe.*N.*ve, '--g', 'LineWidth', lw);
hold off
legend('J', 'Ji', 'Je', 'Ji + Je');
xlabel('Z');
ylabel('J');
xlim(xrange);
set(gca,'FontSize',fs);


% thermal energy
f6=figure;
plot(ly, Uih, '-k','LineWidth',lw); hold on
plot(ly, Uic, '-r','LineWidth',lw);
plot(ly, Ue, '-b','LineWidth',lw);
plot(ly, Pb, '-g', 'LineWidth', lw);
hold off
legend('Uih', 'Uic', 'Ue', 'Pb');
xlabel('Z');
ylabel('Thermal Energy');
xlim(xrange);
set(gca,'FontSize',fs);

% bulk kinetic energy
f7 = figure;
plot(ly, Kih, '-r', 'LineWidth', lw);
hold on
plot(ly, Ke, '-b', 'LineWidth', lw);
plot(ly, Kic, '-g', 'LineWidth', lw);
hold off
legend('Kih', 'Ke', 'Kic');
xlabel('Z');
ylabel('bulk kinetic energy');
xlim(xrange);
set(gca,'FontSize',fs);

% total energy
f8 = figure;
plot(ly, Kih + Uih, '-r', 'LineWidth', lw);
hold on
plot(ly, Ke + Ue, '-b', 'LineWidth', lw);
plot(ly, Kic + Uic, '-g', 'LineWidth', lw);
plot(ly, Pb, '-m', 'LineWidth', lw);
plot(ly, Kih + Uih + Ke + Ue + Kic + Uic + Pb, '--k', 'LineWidth', lw);
hold on
legend('Eih', 'Ee', 'Eic', 'Eb', 'Sum');
xlabel('Z');
ylabel('total energy');
xlim(xrange);
set(gca,'FontSize',fs);

%% thermal energy
E = [sum(Pb), sum(Uih), sum(Ue), sum(Uic)];
f9 = figure;
X = categorical({'Pb','Uih','Ue','Uic'});
X = reordercats(X,{'Pb','Uih','Ue','Uic'});
bar(X, E, 'b');
ylabel('Thermal Energy');
set(gca, 'FontSize', fs);

%% total energy
E = [sum(Pb), sum(Uih + Kih), sum(Ue + Ke), sum(Uic + Kic)];
f10 = figure;
X = categorical({'Eb','Eih','Ee','Eic'});
X = reordercats(X,{'Eb','Eih','Ee','Eic'});
bar(X, E, 'b');
ylabel('Total Energy');
set(gca, 'FontSize', fs);

%% Alfven speed
f11 = figure;
plot(ly, Vaih, '-r', 'LineWidth', lw);
hold on
plot(ly, Vae, '-b', 'LineWidth', lw);
plot(ly, Vaic, '-g', 'LineWidth', lw);
plot(ly, Vai, '--k', 'LineWidth', lw)
hold off
legend('VA_{ih}', 'VA_e', 'VA_{ic}', 'VA_i');
xlabel('Z');
ylabel('Alfven speed');
xlim(xrange);
set(gca,'FontSize',fs);
ylim([0, max(Vae)]);




% cd(dir);
% print(f1,'-r300','-dpng','B.png');



Bsh=abs(Bsh);
Bsp=abs(Bsp);

rho_sh=N(end);
rho_sp=N(1);

vA_asym=sqrt((Bsh*Bsp*(Bsh+Bsp))/(mu0*(rho_sh*Bsp+rho_sp*Bsh)));
disp(['v_{A,asym} = ', num2str(vA_asym)]);

disp(['Nsh/Nsp = ', num2str(N(end)/N(1))]);

disp(['Nih_sh/Nih_sp = ', num2str(Nih(end)/Nih(1))]);


%% obtain the magnetic field profiles
function B = magnetic_field(Br, y, y0, L)
B=atanh((Br-1)/(Br+1));
B=tanh((y-y0)/L+B);
B=-B*(Br+1)/2-(Br-1)/2;
B=B/Br;
end

%% plasma temperature profiles
function [Tih, Tic, Te, Tish] = plasma_temperature(Tr, theta1, theta2, y, y0, L)
% the hot ion temperature profile
Tih=tanh((y-y0)/L)+1;
Tih=Tih*(Tr-1)/2+1;
Tih=Tih/Tr;
% the electron temperature profile
Te=Tih*theta1;
% the cold ion temperature
Tish=1;
Tic=Tish/Tr;
Tic=Tic/theta2;
end

%% plasma density profiles
function [P, Pb, Nih, Nic, N, Bsh, Bsp] = plasma_density(mu0, betas, Br, Tr, Tish, Tic, theta1, phi, y, y0, s, L, Te, Tih, B)
% total pressure
Bsh=-1;
P=(1+betas)*Bsh*Bsh/(2*mu0);
% cold ion density
Bsp=-Bsh/Br;
PBsp=Bsp*Bsp/(2*mu0);
Tisp=Tish/Tr;
Tesp=Tisp*theta1;
k=(P-PBsp)/(Tisp/phi + Tic + (1 + 1/phi)*Tesp);
Nic=0.5*k*(1-tanh((y-y0+s)/L));
% hot ion density
Pb=B.*B/(2*mu0);
Nih=(P - Pb - Nic.*Tic - Nic.*Te)./(Tih + Te);
N=Nih+Nic;
end

%% the coefficient
function coeff = coefficient(ny, ppc, N)
nn = sum(N, 'all');
coeff = ny*ppc/nn;
end

%% pressure
function [Pih, Pic, Pe, Pp]=pressure(Tih, Nih, Te, N, Nic, Tic, Pb)
Pih=Tih.*Nih;
Pe=Te.*N;
Pic=Nic*Tic;
Pp=Pih+Pe+Pic+Pb;
end

%% mass and charge
function [mi, me, qi, qe] = qm(bsym, encs, fr, mie, wci)
me = fr*bsym;
me = me*me;
me = me / encs;
mi = me * mie;
qi = wci * mi / abs(bsym);
qe = -qi;
end

%% frequency
function [wpe, wce, wpl, wcl, wph, wch]=frequency(c, de, fr, mie, dih, dic)
qhl = 1;
mhl = 1;
wpe = c / de;
wce = wpe / fr;
wpl = c / dih;
wcl = wce / mie;
wph = c / dic;
wch = wcl * qhl / mhl;
end

%% calculate the thermal energy
function [Uih, Uic, Ue]=thermal(Pih, Pic, Pe)
Uih = Pih *3/2;
Uic = Pic *3/2;
Ue = Pe *3/2;
end

%% calculate the current density
function J=current(B, mu0)
n = length(B);
J = zeros(1, n);
J(2:end) = B(2:end) - B(1:end - 1);
J = J / mu0;
end

%% the electron and ion bulk velocity
function [vi, ve] = velocity(J, qi, N, Ni, rate)
% the plasma current
ki = rate/(1 + rate);
ke = 1/(1 + rate);
Ji = J*ki;
Je = J*ke;
% the velocity
vi = Ji ./ (qi*Ni);
ve = -Je./ (qi*N);
end

%% the bulk kinetic energy
function [Ki, Ke] = kinetic(mi, me, Ni, Ne, Vi, Ve)
Ki = 0.5 .* mi .* Ni .* Vi .* Vi;
Ke = 0.5 .* me .* Ne .* Ve .* Ve;
end

%% the alfven speed
function [Vih, Ve, Vic, Vi] = alfven(B, mu0, mi, me, Nih, Nic, Ne)
Vih = abs(B)./sqrt(mu0.*mi.*Nih);
Vic = abs(B)./sqrt(mu0.*mi.*Nic);
Ve = abs(B)./sqrt(mu0.*me.*Ne);
Vi = abs(B)./sqrt(mu0.*mi.*(Nih + Nic));
end