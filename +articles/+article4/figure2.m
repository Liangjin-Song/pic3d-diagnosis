%%
% plot figure2
% overview of (a) density, (b) temperature, (c) total energy, and (d) bulk velocity Vx of cold ions
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper4';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\Paper4\data';

%% time
tt = 40;

%% figure proterties
fontsize = 14;
extra = [];

%% read data
ss=prm.read('stream',tt);
N=prm.read('Nh',tt);
V=prm.read('Vh',tt);
P=prm.read('Ph',tt);

%% calculation
K=V.sqre();
TE=(P.xx+P.yy+P.zz).*0.5 + 0.5.*prm.value.mi.*N.value.*K.value;
T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));

%% set the white background
Ns = N.value./N.value;
N = N.value + Ns - 1;

Ts = TE./TE;
TE = TE + Ts - 1;

V=V.x;
Vs = V./V;
V = V + Vs - 1;

%% the size of the figure
f=figure('Position',[500,500,800,375]);
ha=slj.Plot.subplot(2,2,[0.0001,0.12],[0.2,0.07],[0.1,0.028]);

%% plot the density
axes(ha(1));
slj.Plot.overview(N,ss,prm.value.lx,prm.value.lz,prm.value.nhm,extra);
ylabel('Z [c/\omega_{pi}]');
set(ha(1),'XTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% plot the temperature
axes(ha(2));
slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, prm.value.thm/prm.value.coeff, extra);
ylabel('Z [c/\omega_{pi}]');
set(ha(2),'XTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% plot the total energy
axes(ha(3));
slj.Plot.overview(TE, ss, prm.value.lx, prm.value.lz, prm.value.nhm*prm.value.thm/prm.value.coeff, extra);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
p1 = get(ha(1), 'Position');
p2 = get(ha(3), 'Position');
p2(3) = p1(3);
set(ha(3), 'Position', p2);
set(ha(3), 'XTick', 0:10:50, 'XTicklabel', {'0', '10', '20', '30', '40', '50'});
set(gca, 'FontSize', fontsize);

%% plot Vx
axes(ha(4));
slj.Plot.overview(V,ss,prm.value.lx,prm.value.lz,prm.value.bm*prm.value.c./sqrt(prm.value.mi*prm.value.nhm),extra);
caxis([-0.5, 0.5]);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
p1 = get(ha(2), 'Position');
p2 = get(ha(4), 'Position');
p2(3) = p1(3);
set(ha(4), 'Position', p2);
set(ha(4), 'XTick', 0:10:50, 'XTicklabel', {'0', '10', '20', '30', '40', '50'});
set(gca, 'FontSize', fontsize);


%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.0275 0.881666668574015 0.0618749985285104 0.0906666647593181],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.52375 0.881666668574015 0.0618749985285104 0.0906666647593181],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.0275 0.508333335240682 0.0606249985657633 0.0906666647593181],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.52375 0.508333338574015 0.0618749985285104 0.0906666647593181],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',fontsize);


%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure2.png');
% print(f,'-depsc','-painters','figure2.eps');