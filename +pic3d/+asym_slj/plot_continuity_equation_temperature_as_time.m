% function plot_continuity_equation_dt
clear;
%{
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region3';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=20:dt:60;
name='h';

% the box and box size
xx = [0,6];
zz = [-2,2];
% xindex = [1201, prm.value.nx];
% zindex = [441, 501];
% xindex = [881, 1120];
% zindex = [441, 621];
% xindex = [1, 321];
% zindex = [441, 621];

xrange=[tt(1),tt(end)];
[~, a] = min(abs(prm.value.lx - xx(1)));
[~, b] = min(abs(prm.value.lx - xx(2)));
xindex = [a, b];
[~, a] = min(abs(prm.value.lz - zz(1)));
[~, b] = min(abs(prm.value.lz - zz(2)));
zindex = [a, b]; 


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
%}

pic3d.asym_slj.energy_equation_parameters;
% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
% norm=2*dt*prm.value.wci*prm.value.n0;
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(2,nt);


for t=1:nt
    %% calculation
    [pNt, divNV] = slj.Physics.continuity_equation(prm, name, tt(t), dt);

    [T, N] = average_temperature(prm, name, tt(t), xindex, zindex);
    rate(1,t)=sum(pNt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all').*T./N;
    rate(2,t)=sum(divNV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all').*T./N;
end

rate0 = rate;
% rate(1,:)=smoothdata(rate0(1,:));
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:));
% rate(5,:)=smoothdata(rate0(5,:));
rate = rate/norm;

%% plot figure
f=figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-r', 'LineWidth', 2);
hold off


%% set figure
xlim(xrange);
legend('\partial n/\partial t', '-\nabla\cdot(nv)', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial n',sfx,'/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',[sfx,'_continuity_equation_as_dt=',num2str(dt),'_temperature.png']);
% close(gcf);


%% ======================================================================================= %%
function N = particles_number(prm, name, t, xindex, zindex)
N = prm.read(['N', name], t);
N = sum(N.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
end

function [T, N]= average_temperature(prm, name, t, xindex, zindex)
U = slj.Physics.thermal_energy(prm.read(['P', name], t));
U = sum(U.value(zindex(1):zindex(2),xindex(1):xindex(2)), 'all');
N = particles_number(prm, name, t, xindex, zindex);
T = U./N;
end