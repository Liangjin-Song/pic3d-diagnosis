% function plot_thermal_energy_conversion_as_time
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Energy';
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=0.1:dt:80;
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
xrange = [0, 60];
%% the loop
nt=length(tt);
rate=zeros(2,nt);


for t=1:nt
    %% calculation
    V=prm.read(['V',name],tt(t));
    P=prm.read(['P',name],tt(t));
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
    

    rate(1,t)=sum(PdivV(prm.value.nz/2:end, :),'all');
    rate(2,t)=sum(PdivV,'all');
end
rate = rate/norm;

% rate(1,:)=smoothdata(rate0(1,:));
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:));
% rate(5,:)=smoothdata(rate0(5,:));


%% plot figure
f1=figure;
plot(tt, -rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, -rate(2,:), '-b', 'LineWidth', 2);
%% set figure
% legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-(P\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
legend('sheath','whole system', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', '-(P\cdot\nabla)\cdot V');
set(gca,'FontSize',14);


%% save figure
cd(outdir);
% print('-dpng','-r300',[sfx,'_thermal_energy_conversion_as_time_dt=',num2str(dt),'_whole_space.png']);
% print('-dpng','-r300',[sfx,'_pressure_work_integral_as_time_dt=',num2str(dt),'_whole_space.png']);
% close(gcf);
