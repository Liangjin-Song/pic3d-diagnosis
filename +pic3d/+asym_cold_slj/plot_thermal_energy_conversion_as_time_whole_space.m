% function plot_thermal_energy_conversion_as_time
clear;
%% parameters
indir='E:\Simulation\Cold2_ds1_large\data';
outdir='E:\Simulation\Cold2_ds1_large\out\Energy';
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=0.1:dt:70;
name='h';

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

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(4,nt);


for t=1:nt
    %% calculation
    U2 = slj.Physics.thermal_energy(prm.read(['P',name], tt(t)+dt));
    U1 = slj.Physics.thermal_energy(prm.read(['P',name], tt(t)-dt));
    pUt=(U2.value-U1.value).*prm.value.wci./(2.*dt);
    %%
    V=prm.read(['V',name],tt(t));
    P=prm.read(['P',name],tt(t));
    VdivP=P.divergence(prm);
    VdivP = VdivP.x.*V.x + VdivP.y.*V.y + VdivP.z.*V.z;
    %%
    gV = slj.Scalar(V.x);
    gV = gV.gradient(prm);
    PV1 = P.xx .* gV.x + P.xy .* gV.y + P.xz .* gV.z;
    gV = slj.Scalar(V.y);
    gV = gV.gradient(prm);
    PV2 = P.xy .* gV.x + P.yy .* gV.y + P.yz .* gV.z;
    gV = slj.Scalar(V.z);
    gV = gV.gradient(prm);
    PV3 = P.xz .* gV.x + P.yz .* gV.y + P.zz .* gV.z;
    PdivV = PV1 + PV2 + PV3;
    
    %% \nbala \cdot (P \cdot V)
    PV=[];
    PV.x = P.xx.*V.x + P.xy.*V.y + P.xz.*V.z;
    PV.y = P.xy.*V.x + P.yy.*V.y + P.yz.*V.z;
    PV.z = P.xz.*V.x + P.yz.*V.y + P.zz.*V.z;
    PV = slj.Vector(PV);
    divPV = PV.divergence(prm);
    divPV = divPV.value;


    rate(1,t)=sum(pUt,'all');
    rate(2,t)=sum(VdivP,'all');
    rate(3,t)=sum(PdivV,'all');
    rate(4,t)=sum(divPV,'all');
end
rate = rate/norm;

% rate(1,:)=smoothdata(rate0(1,:));
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:));
% rate(5,:)=smoothdata(rate0(5,:));


%% plot figure
f1=figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
% plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, -rate(3,:), '-r', 'LineWidth', 2);
%% set figure
% legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-(P\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
legend('\partial U/\partial t', '-(P\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);


f2=figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(2,:)-rate(4,:), '-r', 'LineWidth', 2);
%% set figure
legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-(P\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
% xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);

f3=figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(4,:)-rate(3,:), '-b', 'LineWidth', 2);
plot(tt, -rate(3,:), '-r', 'LineWidth', 2);
%% set figure
legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-(P\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
% xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
set(gca,'FontSize',14);


%% save figure
cd(outdir);
save('thermal_energy_conversion.mat', 'tt', 'rate', 'dt','sfx');
print('-dpng','-r300',[sfx,'_thermal_energy_conversion_as_time_dt=',num2str(dt),'_whole_space.png']);
close(gcf);
