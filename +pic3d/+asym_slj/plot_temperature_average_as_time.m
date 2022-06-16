%% plot the average temperature evolution in a region
clear;
%% parameters
pic3d.asym_slj.energy_equation_parameters;

%% normalization
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(7,nt);
work=zeros(4, nt);
for t = 1:nt
    [aTt, divQ, PdV, NVT1, TNV, T1NV] = average_temperature_evolution1(prm, name, tt(t), dt, xindex, zindex);
    rate(1, t) = aTt;
    rate(2, t) = divQ;
    rate(3, t) = PdV;
    rate(4, t) = NVT1;
    rate(5, t) = TNV;
    rate(6, t) = T1NV;
    rate(7, t) = divQ + PdV + NVT1 + TNV + T1NV;

    [PdV, P1dV, pdv] = pressure_work2(prm, name, tt(t), xindex, zindex);
    work(1, t) = PdV;
    work(2, t) = P1dV;
    work(3, t) = pdv;
    work(4, t) = P1dV + pdv;
end

%% figure
f1 = figure;
plot(tt, rate(1, :), '-k', 'LineWidth', 2);
hold on
plot(tt, rate(2, :), '-g', 'LineWidth', 2);
plot(tt, rate(3, :), '-r', 'LineWidth', 2);
plot(tt, rate(4, :), '-m', 'LineWidth', 2);
plot(tt, rate(5, :) + rate(6, :), '-b', 'LineWidth', 2);
plot(tt, rate(7, :), '--k', 'LineWidth', 2);
legend('\partial T/\partial t', '\nabla \cdot Q term', '(P\cdot\nabla)\cdot V term', 'nv\cdot\nabla T'' term', ...
    '\nabla \cdot (nv) terms', 'Sum', 'Box', 'off', 'Location', 'Best');
xlabel('\Omega_{ci}t');
ylabel(['\partial T', sfx, '/\partial t']);
set(gca,'FontSize', 14);

f2 = figure;
plot(tt, rate(1, :), '-k', 'LineWidth', 2);
hold on
plot(tt, rate(7, :), '-r', 'LineWidth', 2);
legend('\partial T/\partial t', 'Sum', 'Box', 'off', 'Location', 'Best');
xlabel('\Omega_{ci}t');
ylabel(['\partial T', sfx, '/\partial t']);
set(gca,'FontSize', 14);

f3 = figure;
plot(tt, rate(5, :), '-r', 'LineWidth', 2);
hold on
plot(tt, rate(6, :), '-b', 'LineWidth', 2);
plot(tt, rate(5, :) + rate(6, :), '-k', 'LineWidth', 2);
legend('T\nabla\cdot(nv) term', 'T''\nabla\cdot(nv) term', 'Sum', 'Box', 'off', 'Location', 'Best');
xlabel('\Omega_{ci}t');
set(gca,'FontSize', 14);

f4 = figure;
plot(tt, work(1, :), '-k', 'LineWidth', 2);
hold on
plot(tt, work(2, :), '-r', 'LineWidth', 2);
plot(tt, work(3, :), '-b', 'LineWidth', 2);
plot(tt, work(4, :), '--k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
legend('(P\cdot\nabla)\cdot v', '(P''\cdot\nabla)\cdot v', 'p\nabla\cdot v', 'Sum', 'Box', 'off', 'Location', 'Best');
set(gca,'FontSize', 14);

cd(outdir)
print(f1, '-dpng','-r300',[sfx,'_average_temperature_evolution_as_time_dt=',num2str(dt),'.png']);
print(f2, '-dpng','-r300',[sfx,'_average_temperature_evolution_as_time_dt=',num2str(dt),'_sum.png']);
print(f3, '-dpng','-r300',[sfx,'_average_temperature_convection_as_time_dt=',num2str(dt),'.png']);
print(f4, '-dpng','-r300',[sfx,'_average_temperature_pressure_work_as_time_dt=',num2str(dt),'.png']);


%% ======================================================================================= %%
function [aTt, divQ, PdV, NVT1, TNV, T1NV] = average_temperature_evolution1(prm, name, t, dt, xindex, zindex)
aTt = average_temperature_change(prm, name, t, dt, xindex, zindex);
divQ = divergence_heat_flux(prm, name, t, xindex, zindex);
PdV = pressure_work(prm, name, t, xindex, zindex);
NVT1 = temperature_gradient(prm, name, t, xindex, zindex);
TNV = temperature_convection(prm, name, t, xindex, zindex);
T1NV = temperature_convection2(prm, name, t, xindex, zindex);
end

%% ======================================================================================= %%
function N = particles_number(prm, name, t, xindex, zindex)
N = prm.read(['N', name], t);
N = sum(N.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
end

function T = average_temperature(prm, name, t, xindex, zindex)
U = slj.Physics.thermal_energy(prm.read(['P', name], t));
U = sum(U.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
T = U./N;
end

%% ======================================================================================= %%
function aTt = average_temperature_change(prm, name, t, dt, xindex, zindex)
T2 = average_temperature(prm, name, t + dt, xindex, zindex);
T1 = average_temperature(prm, name, t - dt, xindex, zindex);
aTt = (T2 - T1).*prm.value.wci./(2.*dt);
end

%% ======================================================================================= %%
function divQ = divergence_heat_flux(prm, name, t, xindex, zindex)
% -\nabla\cdot\vec{Q}/N
divQ = prm.read(['qflux',name],t);
divQ = divQ.divergence(prm); 
divQ = sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
divQ = -divQ./N;
end

%% ======================================================================================= %%
function PdV = pressure_work(prm, name, t, xindex, zindex)
V = prm.read(['V', name], t);
P = prm.read(['P', name], t);
% - (P \cdot \nabla)\cdot v
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*P.xx+g.y.*P.xy+g.z.*P.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*P.xy+g.y.*P.yy+g.z.*P.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*P.xz+g.y.*P.yz+g.z.*P.zz;
PdV = px + py + pz;

PdV = sum(PdV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
PdV = -PdV./N;
end

function [PdV, P1dV, pdv] = pressure_work2(prm, name, t, xindex, zindex)
V = prm.read(['V', name], t);
P = prm.read(['P', name], t);

% - (P \cdot \nabla)\cdot v
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*P.xx+g.y.*P.xy+g.z.*P.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*P.xy+g.y.*P.yy+g.z.*P.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*P.xz+g.y.*P.yz+g.z.*P.zz;
PdV = -px - py - pz;
PdV = sum(PdV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');

% - (P'\cdot \nabla)\cdot V
p=(P.xx+P.yy+P.zz)/3;
pdxx=P.xx-p;
pdxy=P.xy;
pdxz=P.xz;
pdyy=P.yy-p;
pdyz=P.yz;
pdzz=P.zz-p;

VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*pdxx+g.y.*pdxy+g.z.*pdxz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*pdxy+g.y.*pdyy+g.z.*pdyz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*pdxz+g.y.*pdyz+g.z.*pdzz;
P1dV = -px - py - pz;
P1dV = sum(P1dV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');

% -p\nabla\cdot V
pdv=V.divergence(prm);
pdv=-pdv.value.*p;
pdv = sum(pdv(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
end

%% ======================================================================================= %%
function NVT1 = temperature_gradient(prm, name, t, xindex, zindex)
U = slj.Physics.thermal_energy(prm.read(['P', name], t));
N = prm.read(['N', name], t);
V = prm.read(['V', name], t);
T = slj.Scalar(U.value./N.value);
gT = T.gradient(prm);
NVT1 = N.value.*(V.x .* gT.x + V.y .* gT.y + V.z .* gT.z);

NVT1 = sum(NVT1(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
NVT1 = -NVT1./N;
end

%% ======================================================================================= %%
function TNV = temperature_convection(prm, name, t, xindex, zindex)
N = prm.read(['N', name], t);
V = prm.read(['V', name], t);
NV.x = N.value.*V.x;
NV.y = N.value.*V.y;
NV.z = N.value.*V.z;
NV = slj.Vector(NV);
TNV = NV.divergence(prm);

TNV = sum(TNV.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
T = average_temperature(prm, name, t, xindex, zindex);
N = particles_number(prm, name, t, xindex, zindex);
TNV = T.*TNV./N;
end

%% ======================================================================================= %%
function T1NV = temperature_convection2(prm, name, t, xindex, zindex)
U = slj.Physics.thermal_energy(prm.read(['P', name], t));
N = prm.read(['N', name], t);
T = slj.Scalar(U.value./N.value);

V = prm.read(['V', name], t);
NV.x = N.value.*V.x;
NV.y = N.value.*V.y;
NV.z = N.value.*V.z;
NV = slj.Vector(NV);
T1NV = NV.divergence(prm);
T1NV = T1NV.value .* T.value;

T1NV = sum(T1NV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
T1NV = - T1NV./N;
end