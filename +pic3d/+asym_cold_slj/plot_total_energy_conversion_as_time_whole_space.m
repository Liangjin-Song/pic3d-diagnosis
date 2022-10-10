%% plot the total energy conversion profiles
% written by Liangjin Song on 20220412 at Nanchang University
%%
clear;
%% parameters
indir='E:\Simulation\Cold2_ds1_large\data';
outdir='E:\Simulation\Cold2_ds1_large\out\Energy';
disp(outdir);
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=0.1:dt:70;
name='h';

xrange=[0,70];

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
%% the loop
nt=length(tt);
rate=zeros(4,nt);
for t=1:nt
    % kinetic energy
    K2 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt(t)+dt), prm.read(['V',name],tt(t)+dt));
    K1 = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt(t)-dt), prm.read(['V',name],tt(t)-dt));
    % thermal energy
    U2 = slj.Physics.thermal_energy(prm.read(['P',name], tt(t)+dt));
    U1 = slj.Physics.thermal_energy(prm.read(['P',name], tt(t)-dt));
    % total energy
    T2 = K2.value + U2.value;
    T1 = K1.value + U1.value;
    pTt= (T2 - T1).*prm.value.wci./(2.*dt);
    % qN\vec{V} \cdot \vec{E}
    N=prm.read(['N',name],tt(t));
    V=prm.read(['V',name],tt(t));
    E=prm.read('E', tt(t));
    qVE = q.*N.value.*(V.x.*E.x + V.y.*E.y + V.z.*E.z);

    rate(1,t)=sum(pTt,'all');
    rate(2,t)=sum(qVE,'all');
end

%% smooth
% lpTt = smoothdata(lpTt, 'movmean', 10);
% lqVE = smoothdata(lqVE, 'movmean', 10);


%% plot figure
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-r', 'LineWidth', 2);

%% set figure
legend('\partial (K+U)/\partial t', 'qNV\cdot E', 'Location', 'Best', 'Box', 'off');
xlim(xrange);
xlabel('\Omega_{ci}t');
set(get(gca, 'YLabel'), 'String', ['\partial (K',sfx,'+U',sfx,')/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
save('total_energy_conversion.mat', 'tt', 'rate', 'dt','sfx');
print('-dpng','-r300',[sfx,'_total_energy_as_time_dt=',num2str(dt),'_whole_space.png']);
close(gcf);
