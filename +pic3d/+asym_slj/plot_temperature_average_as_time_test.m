%% plot the average temperature evolution in a region
clear;
%% parameters
pic3d.asym_slj.energy_equation_parameters;

%% normalization
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(10,nt);
for t = 1:nt
    %%
    % [aTt, TNt, divQ, DUV, PdV] = average_temperature_evolution2(prm, name, tt(t), dt, xindex, zindex);
    % rate(1, t) = aTt;
    % rate(2, t) = TNt;
    % rate(3, t) = divQ;
    % rate(4, t) = DUV;
    % rate(5, t) = PdV;
    % rate(6, t) = aTt + TNt;
    % rate(7, t) = divQ + DUV + PdV;
    %%

    %%
    [aTt, TNV, divQ, DUV, cTNV, cNVT, PdV] = average_temperature_evolution4(prm, name, tt(t), dt, xindex, zindex);
    rate(1, t) = aTt;
    rate(2, t) = TNV;
    rate(3, t) = divQ;
    rate(4, t) = cTNV;
    rate(5, t) = cNVT;
    rate(6, t) = PdV;
    rate(7, t) = aTt + TNV;
    rate(8, t) = divQ + cTNV + cNVT + PdV;
    rate(9, t) = DUV;
    %%
end

cd(outdir)
plot_temperature_evolution3(tt, rate);
% print(f1, '-dpng','-r300',[sfx,'_average_temperature_evolution_as_time_dt=',num2str(dt),'.png']);
% print(f2, '-dpng','-r300',[sfx,'_average_temperature_evolution_as_time_dt=',num2str(dt),'_sum.png']);
% print(f3, '-dpng','-r300',[sfx,'_average_temperature_convection_as_time_dt=',num2str(dt),'.png']);
% print(f4, '-dpng','-r300',[sfx,'_average_temperature_pressure_work_as_time_dt=',num2str(dt),'.png']);


%% ======================================================================================= %%
function [aTt, TNt, divQ, DUV, PdV] = average_temperature_evolution1(prm, name, t, dt, xindex, zindex)
aTt = average_temperature_change(prm, name, t, dt, xindex, zindex);
[TNt, ~] = temperature_continuity(prm, name, t, dt, xindex, zindex);
divQ = divergence_heat_flux(prm, name, t, xindex, zindex);
DUV = thermal_convection(prm, name, t, xindex, zindex);
PdV = pressure_work(prm, name, t, xindex, zindex);
end

function plot_temperature_evolution1(tt, rate)
f1 = figure;
plot(tt, rate(6, :), '-k', 'LineWidth', 2); hold on
plot(tt, rate(7, :), '-r', 'LineWidth', 2);
end

%% ======================================================================================= %%
function [aTt, TNV, divQ, DUV, PdV] = average_temperature_evolution2(prm, name, t, dt, xindex, zindex)
aTt = average_temperature_change(prm, name, t, dt, xindex, zindex);
[~, TNV] = temperature_continuity(prm, name, t, dt, xindex, zindex);
divQ = divergence_heat_flux(prm, name, t, xindex, zindex);
DUV = thermal_convection(prm, name, t, xindex, zindex);
PdV = pressure_work(prm, name, t, xindex, zindex);
end

%% ======================================================================================= %%
function [aTt, TNV, divQ, DUV, cTNV, cNVT, PdV] = average_temperature_evolution3(prm, name, t, dt, xindex, zindex)
aTt = average_temperature_change(prm, name, t, dt, xindex, zindex);
[~, TNV] = temperature_continuity(prm, name, t, dt, xindex, zindex);
divQ = divergence_heat_flux(prm, name, t, xindex, zindex);
[DUV, cTNV, cNVT] = temperature_convection(prm, name, t, xindex, zindex);
PdV = pressure_work(prm, name, t, xindex, zindex);
end

function plot_temperature_evolution3(tt, rate)
f1 = figure;
plot(tt, rate(1, :), '-k', 'LineWidth', 2);
hold on
plot(tt, rate(2, :), '-g', 'LineWidth', 2);
plot(tt, rate(3, :), '-r', 'LineWidth', 2);
plot(tt, rate(4, :), '-m', 'LineWidth', 2);
plot(tt, rate(5, :), '-b', 'LineWidth', 2);
plot(tt, rate(6, :), '--r', 'LineWidth', 2);

f2 = figure;
plot(tt, rate(7, :), '-k', 'LineWidth', 2); hold on
plot(tt, rate(8, :), '-r', 'LineWidth', 2);

f3 = figure;
plot(tt, rate(9, :), '-k', 'LineWidth', 2); hold on
plot(tt, rate(4, :), '-b', 'LineWidth', 2);
plot(tt, rate(5, :), '-g', 'LineWidth', 2);
plot(tt, rate(4, :) + rate(5, :), '-r', 'LineWidth', 2);
end


%% ======================================================================================= %%
function [aTt, TNV, divQ, DUV, cTNV, cNVT, PdV] = average_temperature_evolution4(prm, name, t, dt, xindex, zindex)
aTt = average_temperature_change4(prm, name, t, dt, xindex, zindex);
[~, TNV] = temperature_continuity4(prm, name, t, dt, xindex, zindex);
divQ = divergence_heat_flux4(prm, name, t, xindex, zindex);
[DUV, cTNV, cNVT] = temperature_convection4(prm, name, t, xindex, zindex);
PdV = pressure_work4(prm, name, t, xindex, zindex);
end


%% ======================================================================================= %%
function N = particles_number(prm, name, t, xindex, zindex)
N = prm.read(['N', name], t);
N = sum(N.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
end

function [T, N] = average_temperature(prm, name, t, xindex, zindex)
U = slj.Physics.thermal_energy(prm.read(['P', name], t));
U = sum(U.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
T = U./N;
end

%% ======================================================================================= %%
function aTt = average_temperature_change(prm, name, t, dt, xindex, zindex)
T2 = average_temperature(prm, name, t + dt, xindex, zindex);
T1 = average_temperature(prm, name, t - dt, xindex, zindex);
N = particles_number(prm, name, t, xindex, zindex);
aTt = (T2 - T1).*prm.value.wci./(2.*dt);
aTt = aTt .* N;
end

function aTt = average_temperature_change4(prm, name, t, dt, xindex, zindex)
T2 = average_temperature(prm, name, t + dt, xindex, zindex);
T1 = average_temperature(prm, name, t - dt, xindex, zindex);
N = particles_number(prm, name, t, xindex, zindex);
aTt = (T2 - T1).*prm.value.wci./(2.*dt);
end

%% ======================================================================================= %%
function divQ = divergence_heat_flux(prm, name, t, xindex, zindex)
% -\nabla\cdot\vec{Q}
divQ = prm.read(['qflux',name],t);
divQ = divQ.divergence(prm); 
divQ = -sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
end

function divQ = divergence_heat_flux4(prm, name, t, xindex, zindex)
% -\nabla\cdot\vec{Q}/N
divQ = prm.read(['qflux',name],t);
divQ = divQ.divergence(prm); 
divQ = -sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
divQ = divQ ./ N;
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
PdV = -sum(PdV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
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


function PdV = pressure_work4(prm, name, t, xindex, zindex)
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
PdV = -sum(PdV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
PdV = PdV ./ N;
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
function [DUV, TNV, NVT] = temperature_convection(prm, name, t, xindex, zindex)
DUV = thermal_convection(prm, name, t, xindex, zindex);

U = slj.Physics.thermal_energy(prm.read(['P', name], t));
N = prm.read(['N', name], t);
V = prm.read(['V', name], t);
T = slj.Scalar(U.value./N.value);

NV.x = N.value.*V.x;
NV.y = N.value.*V.y;
NV.z = N.value.*V.z;
TNV = slj.Vector(NV);
TNV = TNV.divergence(prm);
TNV = TNV.value .* T.value;
TNV = -sum(TNV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');

gT = T.gradient(prm);
NVT = NV.x .* gT.x + NV.y .* gT.y + NV.z .* gT.z;
NVT = -sum(NVT(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
end


function [DUV, TNV, NVT] = temperature_convection4(prm, name, t, xindex, zindex)
DUV = thermal_convection(prm, name, t, xindex, zindex);
NN = particles_number(prm, name, t, xindex, zindex);
DUV = DUV./NN;


U = slj.Physics.thermal_energy(prm.read(['P', name], t));
N = prm.read(['N', name], t);
V = prm.read(['V', name], t);
T = slj.Scalar(U.value./N.value);

NV.x = N.value.*V.x;
NV.y = N.value.*V.y;
NV.z = N.value.*V.z;
TNV = slj.Vector(NV);
TNV = TNV.divergence(prm);
TNV = TNV.value .* T.value;
TNV = -sum(TNV(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
TNV = TNV./NN;

gT = T.gradient(prm);
NVT = NV.x .* gT.x + NV.y .* gT.y + NV.z .* gT.z;
NVT = -sum(NVT(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
NVT = NVT./NN;
end

%% ======================================================================================= %%
function DUV = thermal_convection(prm, name, t, xindex, zindex)
U = slj.Physics.thermal_energy(prm.read(['P', name], t));
V = prm.read(['V', name], t);
DUV.x = U.value .* V.x;
DUV.y = U.value .* V.y;
DUV.z = U.value .* V.z;
DUV = slj.Vector(DUV);
DUV = DUV.divergence(prm);
DUV = -sum(DUV.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
end

%% ======================================================================================= %%
function [TNt, TNV] = temperature_continuity(prm, name, t, dt, xindex, zindex)
[TNt, TNV] = slj.Physics.continuity_equation(prm, name, t, dt);
[T, ~] = average_temperature(prm, name, t, xindex, zindex);
TNt = sum(TNt.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all').*T;
TNV = sum(TNV.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all').*T;
end

function [TNt, TNV] = temperature_continuity4(prm, name, t, dt, xindex, zindex)
[TNt, TNV] = slj.Physics.continuity_equation(prm, name, t, dt);
[T, N] = average_temperature(prm, name, t, xindex, zindex);
TNt = sum(TNt.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all').*T./N;
TNV = sum(TNV.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all').*T./N;
end