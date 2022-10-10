% function plot_kinetic_energy_conversion_as_time
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
    %% read data
    % B=prm.read('B',tt(t));

    %% calculation
    [pKt, divKV, qVE, divPV] = slj.Physics.kinetic_energy_conversion(prm, name, tt(t), dt, q, m);

    rate(1,t)=sum(pKt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=sum(divKV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=sum(qVE.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(4,t)=sum(divPV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
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
legend('\partial K/\partial t', '-\nabla\cdot(KV)', 'qNV\cdot E', '- (\nabla\cdot P) \cdot V', 'Sum', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial K',sfx,'/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_bulk_kinetic_conversion_as_time_dt=',num2str(dt),'.png']);
% close(gcf);



% end