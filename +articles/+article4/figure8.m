%%
% figure8
% the pressure work at two moments
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper4';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\Paper4\data';

%% time
tt1 = 18;
tt2 = 48;

%% normalization
norm=prm.value.thm*prm.value.n0*prm.value.vA/prm.value.di;

%% figure proterties
fontsize = 14;
extra = [];
yrange = [-10,10];

%% read data
ss1=prm.read('stream',tt1);
P1 = prm.read('Ph', tt1);
V1 = prm.read('Vh', tt1);
ss2=prm.read('stream',tt2);
P2 = prm.read('Ph', tt2);
V2 = prm.read('Vh', tt2);

%% calculation
PV1 = pressure_work(prm, P1, V1);
PV2 = pressure_work(prm, P2, V2);

%% figure size
f=figure('Position',[500,500,1000,400]);
ha=slj.Plot.subplot(1,2,[0.0001,0.1],[0.2,0.07],[0.1,0.025]);

%% plot figure
axes(ha(1));
slj.Plot.overview(PV1/norm, ss1, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.5, 0.5]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
title(['t = ', num2str(tt1)]);
set(gca, 'FontSize', fontsize);


axes(ha(2));
slj.Plot.overview(PV2/norm, ss2, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.5, 0.5]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
title(['t = ', num2str(tt2)]);
set(gca, 'FontSize', fontsize);


%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.031 0.714000001788139 0.0494999988228083 0.0849999982118607],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.518 0.706500001788139 0.0494999988228083 0.0849999982118607],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);

%% save figure
%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure8.png');



function PV = pressure_work(prm, P, V)
gV = slj.Scalar(V.x);
gV = gV.gradient(prm);
PV1 = P.xx .* gV.x + P.xy .* gV.y + P.xz .* gV.z;
gV = slj.Scalar(V.y);
gV = gV.gradient(prm);
PV2 = P.xy .* gV.x + P.yy .* gV.y + P.yz .* gV.z;
gV = slj.Scalar(V.z);
gV = gV.gradient(prm);
PV3 = P.xz .* gV.x + P.yz .* gV.y + P.zz .* gV.z;
PV = PV1 + PV2 + PV3;
end