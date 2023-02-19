%%
% figure4
% the overview of Jic.E and their components
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper4';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\Paper4\data';

%% time
tt1 = 26;
tt2 = 48;

%% normalization
norm=prm.value.nhm*prm.value.vA*prm.value.vA;

%% figure proterties
fontsize = 14;
extra = [];
yrange = [-10,10];
cxs = [-0.06, 0.06];

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
ha=slj.Plot.subplot(3,2,[0.03,-0.1],[0.17,0.1],[0.05,0.08]);
dh = 0.001;

%% J.E at tt1
axes(ha(1));
h=slj.Plot.overview(JEt1, ss1, prm.value.lx, prm.value.lz, norm, extra);
caxis(cxs);
colormap(slj.Plot.mycolormap(0));
delete(h);
ylim(yrange);
ylabel('Z [c/\omega_{pi}]');
set(ha(1),'XTicklabel',[]);
title(['t = ', num2str(tt1)]);
set(gca, 'FontSize', fontsize);

%% J.E at tt2
axes(ha(2));
h=slj.Plot.overview(JEt2, ss2, prm.value.lx, prm.value.lz, norm, extra);
caxis(cxs);
colormap(slj.Plot.mycolormap(0));
delete(h);
ylim(yrange);
set(ha(2),'XTicklabel',[]);
set(ha(2),'YTicklabel',[]);
title(['t = ', num2str(tt2)]);
set(gca, 'FontSize', fontsize);



%% JyEy at tt1
axes(ha(3));
h3=slj.Plot.overview(JEy1, ss1, prm.value.lx, prm.value.lz, norm, extra);
caxis(cxs);
colormap(slj.Plot.mycolormap(0));
delete(h3);
ylim(yrange);
ylabel('Z [c/\omega_{pi}]');
set(ha(3),'XTicklabel',[]);
set(gca, 'FontSize', fontsize);


%% JyEy at tt2
axes(ha(4));
h4=slj.Plot.overview(JEy2, ss2, prm.value.lx, prm.value.lz, norm, extra);
caxis(cxs);
colormap(slj.Plot.mycolormap(0));
delete(h4);
ylim(yrange);
set(ha(4),'XTicklabel',[]);
set(ha(4),'YTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% JzEz at tt1
axes(ha(5));
h=slj.Plot.overview(JEz1, ss1, prm.value.lx, prm.value.lz, norm, extra);
caxis(cxs);
colormap(slj.Plot.mycolormap(0));
delete(h);
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
h=slj.Plot.overview(JEz2, ss2, prm.value.lx, prm.value.lz, norm, extra);
caxis(cxs);
colormap(slj.Plot.mycolormap(0));
ylim(yrange);
xlabel('X [c/\omega_{pi}]');
set(ha(6),'YTicklabel',[]);
set(ha(6), 'XTick', 0:10:50, 'XTicklabel', {'0', '10', '20', '30', '40', '50'});
p1 = get(ha(4), 'Position');
p2 = get(ha(6), 'Position');
p2(3) = p1(3);
set(ha(6), 'Position', p2);
p1 = get(ha(2), 'Position');
p2 = get(h, 'Position');
p2(4) = p1(2)+p1(4)-p2(2);
p2(1) = p2(1) - dh;
set(h,'Position', p2);
set(gca, 'FontSize', fontsize);



%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.06 0.86066666785876 0.0494999988228083 0.0566666654745738],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.475 0.86066666785876 0.0494999988228083 0.0566666654745738],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.06 0.607333334525427 0.0484999988526106 0.0566666654745738],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.475 0.607333334525427 0.0494999988228083 0.0566666654745738],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.06 0.354000001192093 0.0494999988228083 0.0566666654745738],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.479 0.354000001192093 0.0444999989718199 0.0566666654745738],...
    'String',{'(f)'},...
    'LineStyle','none',...
    'FontSize',fontsize);

%% label
annotation(f,'textbox',...
    [0.125 0.835666668007772 0.073499998703599 0.0616666653255622],...
    'String',{'Jic\cdot E'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.510 0.835666668007773 0.073499998703599 0.0616666653255622],...
    'String',{'Jic\cdot E'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.125 0.577333334674439 0.073499998703599 0.0616666653255622],...
    'String',{'JicyEy'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.510 0.577333334674439 0.073499998703599 0.0616666653255622],...
    'String',{'JicyEy'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.125 0.330000001341106 0.073499998703599 0.0616666653255622],...
    'String',{'JiczEz'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.510 0.327000001341106 0.073499998703599 0.0616666653255622],...
    'String',{'JiczEz'},...
    'LineStyle','none',...
    'FontSize',16,...
    'BackgroundColor',[1 1 1]);

%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure4.png');