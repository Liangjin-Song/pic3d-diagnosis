% function plot_thermal_energy_conversion_as_time
clear;
%{
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region3';
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=20:dt:60;
name='h';

xx = [0,6];


zz = [-2,2];

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
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
else
    error('Parameters Error!');
end
%}

pic3d.asym_slj.energy_equation_parameters;

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(5,nt);


for t=1:nt
    %% calculation
    [pUt, divPV, divQ, divH]= slj.Physics.thermal_energy_conversion(prm, name, tt(t), dt);

    rate(1,t)=sum(pUt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=sum(divPV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(4,t)=sum(divH.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end
rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);
rate0=rate;
rate = rate/norm;

% rate(1,:)=smoothdata(rate0(1,:));
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:));
% rate(5,:)=smoothdata(rate0(5,:));


%% plot figure
f=figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '--k', 'LineWidth', 2);


%% set figure
legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-\nabla\cdot Q', '-\nabla\cdot(UV + P\cdot V)', 'Sum', ...
    'Location', 'Best','Box','off', 'FontSize', 12);
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_thermal_energy_conversion_as_time_dt=',num2str(dt),'.png']);
% close(gcf);



% end
