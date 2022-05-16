% function plot_thermal_energy_conversion_dt
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region4';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=20:dt:60;
name='h';

% xindex = [1201, prm.value.nx];
% zindex = [441, 501];
xrange=[tt(1)-1,tt(end)+1];
xindex = [1581, 1621];
zindex = [461, 501];


if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tlm;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.thm;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

% norm=prm.value.wci*prm.value.n0*tm/(prm.value.coeff * 2 * dt);
% norm=prm.value.wci*tm/(prm.value.coeff * 2 * dt);
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(10,nt);


for t=1:nt
    rate = calc_energy_density_6(rate, prm, name, tt, t, dt, xindex, zindex);
end

rate0 = rate;
rate=set_rate_6(rate0, norm);
itest = 6;

%% plot figure
plot_figure_6(tt, rate, xrange, sfx);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_temperature_as_dt=',num2str(dt),'_test',num2str(itest),'.png']);
% close(gcf);



% end

%% ==================================================================================================== %%
function rate = calc_energy_density_1(rate, prm, name, tt, t, dt, xindex, zindex)
[~, divPV, divQ, divH]= slj.Physics.thermal_energy_conversion(prm, name, tt(t), dt);
%% partial U/\partial t
u2 = sum(U2.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
u1 = sum(U1.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(1, t) = (u2 - u1)*prm.value.wci/(2*dt);

%% get the average value
rate(2,t)=sum(divPV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(3,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(4,t)=sum(divH.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

function rate=set_rate_1(rate, norm)
% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));
rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);
rate = rate/norm;
end

function plot_figure_1(tt, rate, xrange, sfx)
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-\nabla\cdot Q', '-\nabla\cdot(UV + P\cdot V)', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);
end



%% ==================================================================================================== %%
function rate = calc_energy_density_2(rate, prm, name, tt, t, dt, xindex, zindex)
%% -\nabla\cdot\vec{Q}
divQ = prm.read(['qflux',name],tt(t));
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-divQ.value);

%% -\nabla \cdot (Uv)
P = prm.read(['P', name], tt(t));
U = slj.Physics.thermal_energy(P);
V=prm.read(['V',name],tt(t));
divUV.x = V.x.*U.value;
divUV.y = V.y.*U.value;
divUV.z = V.z.*U.value;
divUV = slj.Vector(divUV);
divUV = divUV.divergence(prm);
divUV = slj.Scalar(-divUV.value);


%% - (P \cdot \nabla)\cdot v
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*P.xx+g.y.*P.xy+g.z.*P.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*P.xy+g.y.*P.yy+g.z.*P.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*P.xz+g.y.*P.yz+g.z.*P.zz;
PdV = slj.Scalar(-px - py - pz);

%% \partial u/dt
u2 = sum(U2.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
u1 = sum(U1.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(1, t) = (u2 - u1)*prm.value.wci/(2*dt);

%% get the average value
rate(2,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(3,t)=sum(divUV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(4,t)=sum(PdV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

function rate=set_rate_2(rate, norm)
% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));
rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);
rate = rate/norm;
end

function plot_figure_2(tt, rate, xrange, sfx)
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial U/\partial t', '-\nabla\cdot Q', '-\nabla\cdot(UV)','-(P\cdot\nabla) \cdot V', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);
end


%% ==================================================================================================== %%
function rate = calc_energy_density_3(rate, prm, name, tt, t, dt, xindex, zindex)
%% -\nabla\cdot\vec{Q}
divQ = prm.read(['qflux',name],tt(t));
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-divQ.value);

%% -\nabla \cdot (Uv)
P = prm.read(['P', name], tt(t));
U = slj.Physics.thermal_energy(P);
V=prm.read(['V',name],tt(t));
divUV.x = V.x.*U.value;
divUV.y = V.y.*U.value;
divUV.z = V.z.*U.value;
divUV = slj.Vector(divUV);
divUV = divUV.divergence(prm);
divUV = slj.Scalar(-divUV.value);


%% - (P \cdot \nabla)\cdot v
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*P.xx+g.y.*P.xy+g.z.*P.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*P.xy+g.y.*P.yy+g.z.*P.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*P.xz+g.y.*P.yz+g.z.*P.zz;
PdV = slj.Scalar(-px - py - pz);


%% 3/2n\partial T/\partial t + 3/2 T \partial n/\partial t
% 3/2T\partial n/\partial t
N1 = prm.read(['N', name], tt(t) - dt);
N2 = prm.read(['N', name], tt(t) + dt);
N = prm.read(['N', name], tt(t));
T = slj.Physics.temperature(P, N);
pN = (N2.value - N1.value) * prm.value.wci / (2 * dt);
pN = pN .* T.value * 3 / 2;

% 3/2 n \partial T/\partial t
T1 = slj.Physics.temperature(prm.read(['P', name], tt(t) - dt), prm.read(['N', name], tt(t) - dt));
T2 = slj.Physics.temperature(prm.read(['P', name], tt(t) + dt), prm.read(['N', name], tt(t) + dt));
pT = (T2.value - T1.value) * prm.value.wci / (2 * dt);
pT = pT .* N.value *3 / 2;

rate(1, t) = sum(pN(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
rate(2, t) = sum(pT(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
rate(3, t) = rate(1, t) + rate(2, t);

%% get the average value
rate(4,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(5,t)=sum(divUV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(6,t)=sum(PdV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

function rate=set_rate_3(rate, norm)
% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));
rate(7,:)=rate(4,:) + rate(5,:) + rate(6,:);
rate = rate/norm;
end

function plot_figure_3(tt, rate, xrange, sfx)
figure;
plot(tt, rate(3,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(4,:), '-b', 'LineWidth', 2);
plot(tt, rate(5,:), '-m', 'LineWidth', 2);
plot(tt, rate(6,:), '-r', 'LineWidth', 2);
plot(tt, rate(7,:), '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('3/2N\partial T/\partial t + 3/2T\partial N/\partial t', '-\nabla\cdot Q', '-\nabla\cdot(UV)','-(P\cdot\nabla) \cdot V', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);
end


%% ==================================================================================================== %%
function rate = calc_energy_density_4(rate, prm, name, tt, t, dt, xindex, zindex)
%% -\nabla\cdot\vec{Q}
divQ = prm.read(['qflux',name],tt(t));
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-divQ.value);

%% -3/2 T \nabla \cdot (nv)
N = prm.read(['N', name], tt(t));
P = prm.read(['P', name], tt(t));
V = prm.read(['V',name],tt(t));
T = slj.Physics.temperature(P, N);
tnv.x = V.x .* N.value;
tnv.y = V.y .* N.value;
tnv.z = V.z .* N.value;
tnv = slj.Vector(tnv);
tnv = tnv.divergence(prm);
tnv = slj.Scalar(-3.*0.5.*T.value.*tnv.value);

%% -3/2 nv \cdot \nabla T
nvt = T.gradient(prm);
nvt = nvt.x .* V.x + nvt.y .* V.y + nvt.z .* V.z;
nvt = slj.Scalar(-3 .* 0.5 .* nvt .* N.value);

%% - (P \cdot \nabla)\cdot v
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*P.xx+g.y.*P.xy+g.z.*P.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*P.xy+g.y.*P.yy+g.z.*P.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*P.xz+g.y.*P.yz+g.z.*P.zz;
PdV = slj.Scalar(-px - py - pz);

%% 3/2n\partial T/\partial t + 3/2 T \partial n/\partial t
% 3/2T\partial n/\partial t
N1 = prm.read(['N', name], tt(t) - dt);
N2 = prm.read(['N', name], tt(t) + dt);
N = prm.read(['N', name], tt(t));
T = slj.Physics.temperature(P, N);
pN = (N2.value - N1.value) * prm.value.wci / (2 * dt);
pN = pN .* T.value * 3 / 2;

% 3/2 n \partial T/\partial t
T1 = slj.Physics.temperature(prm.read(['P', name], tt(t) - dt), prm.read(['N', name], tt(t) - dt));
T2 = slj.Physics.temperature(prm.read(['P', name], tt(t) + dt), prm.read(['N', name], tt(t) + dt));
pT = (T2.value - T1.value) * prm.value.wci / (2 * dt);
pT = pT .* N.value *3 / 2;

rate(1, t) = sum(pN(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
rate(2, t) = sum(pT(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
rate(3, t) = rate(1, t) + rate(2, t);

%% get the average value
rate(4,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(5,t)=sum(tnv.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(6,t)=sum(nvt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(7,t)=sum(PdV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

function rate=set_rate_4(rate, norm)
% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));
rate(8,:)=rate(4,:) + rate(5,:) + rate(6,:) + rate(7, :);
rate = rate/norm;
end

function plot_figure_4(tt, rate, xrange, sfx)
figure;
plot(tt, rate(3,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(4,:), '-b', 'LineWidth', 2);
plot(tt, rate(5,:), '-m', 'LineWidth', 2);
plot(tt, rate(6,:), '-r', 'LineWidth', 2);
plot(tt, rate(7,:), '-g', 'LineWidth', 2);
plot(tt, rate(8,:), '--k', 'LineWidth', 2);

%% set figure
xlim(xrange);
h=legend('3/2N \partial T/\partial t + 3/2T \partial N/\partial t', '-\nabla\cdot Q', '-3/2 T\nabla \cdot (NV)', '-3/2 NV\cdot \nabla T','-(P\cdot\nabla) \cdot V', 'Sum', 'Location', 'Best');
set(h,'Box','off');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);
end



%% ==================================================================================================== %%
function rate = calc_energy_density_5(rate, prm, name, tt, t, dt, xindex, zindex)
%% -\nabla\cdot\vec{Q}
divQ = prm.read(['qflux',name],tt(t));
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-divQ.value);

%% -3/2 nv \cdot \nabla T
N = prm.read(['N', name], tt(t));
P = prm.read(['P', name], tt(t));
V = prm.read(['V',name],tt(t));
T = slj.Physics.temperature(P, N);
nvt = T.gradient(prm);
nvt = nvt.x .* V.x + nvt.y .* V.y + nvt.z .* V.z;
nvt = slj.Scalar(-3 .* 0.5 .* nvt .* N.value);

%% - (P \cdot \nabla)\cdot v
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*P.xx+g.y.*P.xy+g.z.*P.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*P.xy+g.y.*P.yy+g.z.*P.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*P.xz+g.y.*P.yz+g.z.*P.zz;
PdV = slj.Scalar(-px - py - pz);

%% 3/2 n \partial T/\partial t
T1 = slj.Physics.temperature(prm.read(['P', name], tt(t) - dt), prm.read(['N', name], tt(t) - dt));
T2 = slj.Physics.temperature(prm.read(['P', name], tt(t) + dt), prm.read(['N', name], tt(t) + dt));
pT = (T2.value - T1.value) * prm.value.wci / (2 * dt);
pT = slj.Scalar(pT .* N.value *3 / 2);

rate(1, t) = sum(pT.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');

%% get the average value
rate(2,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(3,t)=sum(nvt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(4,t)=sum(PdV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

function rate=set_rate_5(rate, norm)
% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));
rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);
rate = rate/norm;
end

function plot_figure_5(tt, rate, xrange, sfx)
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '--k', 'LineWidth', 2);

%% set figure
legend('3/2N \partial T/\partial t', '-\nabla\cdot Q', '-3/2NV\cdot \nabla T','-(P\cdot\nabla) \cdot V', 'Sum', 'Location', 'Best');
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['3/2N\partial T',sfx,'/\partial t']);
set(gca,'FontSize',14);
end


%% ==================================================================================================== %%
function rate = calc_energy_density_6(rate, prm, name, tt, t, dt, xindex, zindex)
%% -\nabla\cdot\vec{Q}
N = prm.read(['N', name], tt(t));
divQ = prm.read(['qflux',name],tt(t));
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-2 .* divQ.value./(N.value .* 3) );

%% -v \cdot \nabla T
P = prm.read(['P', name], tt(t));
V = prm.read(['V',name],tt(t));
T = slj.Physics.temperature(P, N);
vdt = T.gradient(prm);
vdt = vdt.x .* V.x + vdt.y .* V.y + vdt.z .* V.z;
vdt = slj.Scalar(-vdt);

%% - (P \cdot \nabla)\cdot v
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*P.xx+g.y.*P.xy+g.z.*P.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*P.xy+g.y.*P.yy+g.z.*P.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*P.xz+g.y.*P.yz+g.z.*P.zz;
PdV = slj.Scalar(2.*(-px - py - pz)./(N.value.*3));

%% \partial T/\partial t
T1 = slj.Physics.temperature(prm.read(['P', name], tt(t) - dt), prm.read(['N', name], tt(t) - dt));
T2 = slj.Physics.temperature(prm.read(['P', name], tt(t) + dt), prm.read(['N', name], tt(t) + dt));
pT = slj.Scalar((T2.value - T1.value) * prm.value.wci / (2 * dt));

rate(1, t) = sum(pT.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');

%% get the average value
rate(2,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(3,t)=sum(vdt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(4,t)=sum(PdV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(6,t)=sum(N.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all')*3/2;
end

function rate=set_rate_6(rate, norm)
% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));
rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);
rate = rate/norm;
end

function plot_figure_6(tt, rate, xrange, sfx)
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '--k', 'LineWidth', 2);

%% set figure
legend('\partial T/\partial t', '-2*\nabla\cdot Q/3N', '-V\cdot \nabla T','-2*(P\cdot\nabla) \cdot V/3N', 'Sum', 'Location', 'Best');
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial T',sfx,'/\partial t']);
set(gca,'FontSize',14);
end


%% ==================================================================================================== %%
function rate = calc_energy_density_7(rate, prm, name, tt, t, dt, xindex, zindex)
%% -\nabla\cdot\vec{Q}
N = prm.read(['N', name], tt(t));
divQ = prm.read(['qflux',name],tt(t));
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-2 .* divQ.value./(N.value .* 3) );

%%  - v \cdot \nabla T
P = prm.read(['P', name], tt(t));
V = prm.read(['V',name],tt(t));
T = slj.Physics.temperature(P, N);
vdt = T.gradient(prm);
vdt = vdt.x .* V.x + vdt.y .* V.y + vdt.z .* V.z;
vdt = slj.Scalar(-vdt);

%% - (P' \cdot \nabla)\cdot v
p = (P.xx + P.yy + P.zz)/3;
Pd.xx = P.xx - p;
Pd.xy = P.xy;
Pd.xz = P.xz;
Pd.yy = P.yy - p;
Pd.yz = P.yz;
Pd.zz = P.zz - p;
VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*Pd.xx+g.y.*Pd.xy+g.z.*Pd.xz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*Pd.xy+g.y.*Pd.yy+g.z.*Pd.yz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*Pd.xz+g.y.*Pd.yz+g.z.*Pd.zz;
PdV = slj.Scalar(2.*(-px - py - pz)./(N.value.*3));

%% - p \nabla \cdot v
pdv = V.divergence(prm);
pdv = p .* pdv.value;
pdv = slj.Scalar(-2 .* pdv ./ (3.*N.value));

%% \partial T/\partial t
T1 = slj.Physics.temperature(prm.read(['P', name], tt(t) - dt), prm.read(['N', name], tt(t) - dt));
T2 = slj.Physics.temperature(prm.read(['P', name], tt(t) + dt), prm.read(['N', name], tt(t) + dt));
pT = (T2.value - T1.value) * prm.value.wci / (2 * dt);

rate(1, t) = sum(pT(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');

%% get the average value
rate(2,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(3,t)=sum(vdt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(4,t)=sum(PdV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
rate(5,t)=sum(pdv.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

function rate=set_rate_7(rate, norm)
% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));
rate(6,:)=rate(2,:) + rate(3,:) + rate(4,:) + rate(5,:);
rate = rate/norm;
end

function plot_figure_7(tt, rate, xrange, sfx)
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '-g', 'LineWidth', 2);
plot(tt, rate(6,:), '--k', 'LineWidth', 2);

%% set figure
xlim(xrange);
legend('\partial T/\partial t', '-2*\nabla\cdot Q/3N', '-V\cdot \nabla T','-2(P''\cdot\nabla) \cdot V/3N', '-2p\nabla\cdot V/3N', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial T',sfx,'/\partial t']);
set(gca,'FontSize',14);
end