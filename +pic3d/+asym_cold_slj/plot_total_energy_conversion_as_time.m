%% plot the total energy conversion profiles
% written by Liangjin Song on 20220412 at Nanchang University
%%
clear;
%% parameters
indir='E:\Asym\cold2\data';
outdir='E:\Asym\cold2\out\Energy\Region1';
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=1:dt:50;
name='h';

% xindex = [1201, prm.value.nx];
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

% norm=2*dt*prm.value.wci*prm.value.n0*tm/prm.value.coeff;
norm = 1;
%% the loop
nt=length(tt);
rate=zeros(4,nt);


for t=1:nt
    %% calculation
    [pTt, divF, qVE] = slj.Physics.total_energy_conversion(prm, name, tt(t), dt, q, m);


    rate(1,t)=sum(pTt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=sum(divF.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=sum(qVE.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

rate(4,:)=rate(2,:) + rate(3,:);

%% smooth
% lpTt = smoothdata(lpTt, 'movmean', 10);
% ldivF = smoothdata(ldivF, 'movmean', 13);
% lqVE = smoothdata(lqVE, 'movmean', 10);


%% plot figure
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-r', 'LineWidth', 2);
plot(tt, rate(4,:), '--k', 'LineWidth', 2);

%% set figure
legend('\partial (K+U)/\partial t','-\nabla \cdot (KV + Q + H)', 'qNV\cdot E', 'Sum');
xlim(xrange);
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial (K',sfx,'+U',sfx,')/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_total_energy_as_time_dt=',num2str(dt),'.png']);

