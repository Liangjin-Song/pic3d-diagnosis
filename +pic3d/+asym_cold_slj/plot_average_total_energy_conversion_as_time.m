%% plot the average total energy conversion profiles
% written by Liangjin Song on 20220412 at Nanchang University
%%
clear;
%% parameters
indir='E:\Asym\cold2\data';
outdir='E:\Asym\cold2\out\Energy\Region1';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=1:dt:50;
name='h';

% xindex = [1201, prm.value.nx];
% zindex = [441, 501];
% xindex = [881, 1120];
% zindex = [441, 621];
xindex = [1401, prm.value.nx];
zindex = [421, 501];

xrange=[tt(1),tt(end)];

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

norm = 1;

nt=length(tt);
rate=zeros(5,nt);

for t=1:nt
    %% calculation
    [pAt, qVE, VdA, divF] = slj.Physics.average_total_energy_conversion(prm, name, tt(t), dt, q, m);
    rate(1,t)=sum(pAt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=sum(qVE.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=sum(VdA.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(4,t)=sum(divF.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);
rate0 = rate;
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
%%
legend('\partial [(K+U)/N]/\partial t', 'qV\cdot E', '-V\cdot \nabla A', '-1/N*\nabla \cdot (Q + P\cdot V)', 'Sum', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial [(K',sfx,'+U',sfx,')/N]/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_average_total_energy_as_time_dt=',num2str(dt),'.png']);
