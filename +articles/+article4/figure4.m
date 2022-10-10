%%
% figure4
% the overview of Jic.E and their components
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\data';

%% time
tt1 = 26;
tt2 = 48;

%% normalization
norm=prm.value.nhm*prm.value.vA*prm.value.vA;

%% figure proterties
fontsize = 14;
extra = [];
yrange = [-10,10];

%% read data
ss1=prm.read('stream',tt1);
N1=prm.read('Nh',tt1);
V1=prm.read('Vh',tt1);
E1=prm.read('E', tt1);
ss2=prm.read('stream',tt2);
N2=prm.read('Nh',tt2);
V2=prm.read('Vh',tt2);
E2=prm.read('E', tt2);

%% calculation
JEt1=(E1.x .* V1.x + E1.y .* V1.y + E1.z .* V1.z) .* N1.value;
JEy1=V1.y .* E1.y .* N1.value;
JEz1=V1.z .* E1.z .* N1.value;
JEt2=(E2.x .* V2.x + E2.y .* V2.y + E2.z .* V2.z) .* N2.value;
JEy2=V2.y .* E2.y .* N2.value;
JEz2=V2.z .* E2.z .* N2.value;

%% the size of the figure
f=figure('Position',[500,300,1000,600]);
ha=slj.Plot.subplot(3,2,[0.0001,0.12],[0.17,0.1],[0.1,0.035]);

%% J.E at tt1
axes(ha(1));
slj.Plot.overview(JEt1, ss1, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.07, 0.07]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
ylabel('Z [c/\omega_{pi}]');
set(ha(1),'XTicklabel',[]);
title(['t = ', num2str(tt1)]);
set(gca, 'FontSize', fontsize);

%% J.E at tt2
axes(ha(2));
slj.Plot.overview(JEt2, ss2, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.08, 0.08]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
ylabel('Z [c/\omega_{pi}]');
set(ha(2),'XTicklabel',[]);
title(['t = ', num2str(tt2)]);
set(gca, 'FontSize', fontsize);

%% JyEy at tt1
axes(ha(3));
slj.Plot.overview(JEy1, ss1, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.025, 0.025]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
ylabel('Z [c/\omega_{pi}]');
set(ha(3),'XTicklabel',[]);
set(gca, 'FontSize', fontsize);


%% JyEy at tt2
axes(ha(4));
slj.Plot.overview(JEy2, ss2, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.05, 0.05]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
ylabel('Z [c/\omega_{pi}]');
set(ha(4),'XTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% JzEz at tt1
axes(ha(5));
slj.Plot.overview(JEz1, ss1, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.05, 0.05]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(ha(5), 'XTick', 0:10:50, 'XTicklabel', {'0', '10', '20', '30', '40', '50'});
p1 = get(ha(3), 'Position');
p2 = get(ha(5), 'Position');
p2(3) = p1(3);
set(ha(5), 'Position', p2);
set(gca, 'FontSize', fontsize);

%% JzEz at tt2
axes(ha(6));
slj.Plot.overview(JEz2, ss2, prm.value.lx, prm.value.lz, norm, extra);
caxis([-0.08, 0.08]);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(ha(6), 'XTick', 0:10:50, 'XTicklabel', {'0', '10', '20', '30', '40', '50'});
p1 = get(ha(4), 'Position');
p2 = get(ha(6), 'Position');
p2(3) = p1(3);
set(ha(6), 'Position', p2);
set(gca, 'FontSize', fontsize);


%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.029 0.86066666785876 0.0494999988228083 0.0566666654745738],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.523 0.86066666785876 0.0494999988228083 0.0566666654745738],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.03 0.617333334525427 0.0484999988526106 0.0566666654745738],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.523 0.617333334525427 0.0494999988228083 0.0566666654745738],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.03 0.374000001192093 0.0494999988228083 0.0566666654745738],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.528 0.374000001192093 0.0444999989718199 0.0566666654745738],...
    'String',{'(f)'},...
    'LineStyle','none',...
    'FontSize',fontsize);

%% label
annotation(f,'textbox',...
    [0.101 0.820666668007772 0.073499998703599 0.0616666653255622],...
    'String',{'Jic\cdot E'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.594 0.815666668007773 0.073499998703599 0.0616666653255622],...
    'String',{'Jic\cdot E'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.101 0.567333334674439 0.073499998703599 0.0616666653255622],...
    'String',{'JicyEy'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.595 0.567333334674439 0.073499998703599 0.0616666653255622],...
    'String',{'JicyEy'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.101 0.329000001341106 0.073499998703599 0.0616666653255622],...
    'String',{'JiczEz'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.595 0.329000001341106 0.073499998703599 0.0616666653255622],...
    'String',{'JiczEz'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);

%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure4.png');