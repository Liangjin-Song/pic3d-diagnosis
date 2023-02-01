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
yrange = [-10, 10];

%% read data
ss=prm.read('stream',tt);
N=prm.read('Nh',tt);
V=prm.read('Vh',tt);
P=prm.read('Ph',tt);

%% calculation
K=V.sqre();
K = 0.5.*prm.value.mi.*N.value.*K.value;
U = (P.xx+P.yy+P.zz).*0.5;
TE= U + K;
T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));

%% electric field
Ez=prm.read('E',tt);
Ez=Ez.z;


%% set the white background
Ns = N.value./N.value;
N = N.value + Ns - 1;

Ns = K./K;
K = K + Ns - 1;

Ns = U./U;
U = U + Ns - 1;

Ts = TE./TE;
TE = TE + Ts - 1;

Vx=V.x;
Vs = Vx./Vx;
Vx = Vx + Vs - 1;

Vy=V.y;
Vs = Vy./Vy;
Vy = Vy + Vs - 1;

Vz=V.z;
Vs = Vz./Vz;
Vz = Vz + Vs - 1;

%% the size of the figure
f=figure('Position',[100,100,1400,580]);
ha=slj.Plot.subplot(3,3,[0.000000001,0.02],[0.11,0.05],[0.07,0.028]);

%% bulk kinetic energy
axes(ha(1));
slj.Plot.overview(K, ss, prm.value.lx, prm.value.lz, prm.value.nhm*prm.value.thm/prm.value.coeff, extra);
ylabel('Z [c/\omega_{pi}]');
ylim(yrange);
set(gca, 'XTick', 0:10:50);
set(gca,'XTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% thermal energy
axes(ha(2));
slj.Plot.overview(U, ss, prm.value.lx, prm.value.lz, prm.value.nhm*prm.value.thm/prm.value.coeff, extra);
ylim(yrange);
set(gca, 'XTick', 0:10:50);
set(gca,'XTicklabel',[], 'YTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% plot the total energy
axes(ha(3));
slj.Plot.overview(TE, ss, prm.value.lx, prm.value.lz, prm.value.nhm*prm.value.thm/prm.value.coeff, extra);
ylim(yrange);
set(gca, 'XTick', 0:10:50);
set(gca,'XTicklabel',[], 'YTicklabel',[]);
set(gca, 'FontSize', fontsize);


%% plot the density
axes(ha(4));
h4=slj.Plot.overview(N,ss,prm.value.lx,prm.value.lz,prm.value.nhm,extra);
ylabel('Z [c/\omega_{pi}]');
ylim(yrange);
set(gca,'XTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% plot the temperature
axes(ha(5));
h5=slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, prm.value.thm/prm.value.coeff, extra);
ylim(yrange);
set(gca,'XTicklabel',[], 'YTicklabel',[]);
set(gca, 'FontSize', fontsize);

%% electric field Ez
axes(ha(6));
h6=slj.Plot.overview(Ez, ss, prm.value.lx, prm.value.lz, prm.value.vA, extra);
caxis([-3,3]);
colormap(gca, slj.Plot.mycolormap(0));
ylim(yrange);
set(gca,'XTicklabel',[], 'YTicklabel',[]);
set(gca, 'FontSize', fontsize);


%% plot Vx
axes(ha(7));
h=slj.Plot.overview(Vx,ss,prm.value.lx,prm.value.lz,prm.value.bm*prm.value.c./sqrt(prm.value.mi*prm.value.nhm),extra);
caxis([-0.5, 0.5]);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
ylim(yrange);
set(gca, 'XTick', 0:10:50);
set(gca, 'FontSize', fontsize);
pos1 = get(ha(4),'Position');
pos0 = get(gca, 'Position');
pos0(3) = pos1(3);
set(gca, 'Position', pos0);
pos1 = get(h4, 'Position');
pos0 = get(h,'Position');
pos0(1) = pos1(1);
set(h, 'Position', pos0);

%% plot Vy
axes(ha(8));
h=slj.Plot.overview(Vy,ss,prm.value.lx,prm.value.lz,prm.value.bm*prm.value.c./sqrt(prm.value.mi*prm.value.nhm),extra);
xlabel('X [c/\omega_{pi}]');
ylim(yrange);
set(gca, 'XTick', 0:10:50);
set(gca, 'YTicklabel',[]);
set(gca, 'FontSize', fontsize);
pos1 = get(ha(5),'Position');
pos0 = get(gca, 'Position');
pos0(3) = pos1(3);
set(gca, 'Position', pos0);
pos1 = get(h5, 'Position');
pos0 = get(h,'Position');
pos0(1) = pos1(1);
set(h, 'Position', pos0);

%% plot Vz
axes(ha(9));
h=slj.Plot.overview(Vz,ss,prm.value.lx,prm.value.lz,prm.value.bm*prm.value.c./sqrt(prm.value.mi*prm.value.nhm),extra);
xlabel('X [c/\omega_{pi}]');
ylim(yrange);
set(gca, 'XTick', 0:10:50);
set(gca, 'YTicklabel',[]);
set(gca, 'FontSize', fontsize);
pos1 = get(ha(6),'Position');
pos0 = get(gca, 'Position');
pos0(3) = pos1(3);
set(gca, 'Position', pos0);
pos1 = get(h6, 'Position');
pos0 = get(h,'Position');
pos0(1) = pos1(1);
set(h, 'Position', pos0);


%% panel label
annotation(f,'textbox',...
    [0.0728571428571429 0.697275863353547 0.0271428571428571 0.0603448263016241],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.379285714285714 0.697275863353547 0.0271428571428571 0.0603448263016241],...
    'String','(b)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.687857142857143 0.697275863353547 0.0271428571428571 0.0603448263016241],...
    'String','(c)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.0728571428571428 0.417965518525961 0.0271428571428571 0.060344826301624],...
    'String','(d)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.379285714285714 0.416241380594926 0.0271428571428571 0.060344826301624],...
    'String','(e)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.687142857142857 0.419689656456995 0.027142857142857 0.0603448263016239],...
    'String','(f)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.0721428571428571 0.138655173698374 0.0271428571428571 0.0603448263016239],...
    'String','(g)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.379285714285714 0.13693103576734 0.0271428571428571 0.0603448263016239],...
    'String','(h)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.687142857142857 0.13693103576734 0.027142857142857 0.0603448263016239],...
    'String','(i)',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

annotation(f,'textbox',...
    [0.177857142857143 0.697275863199398 0.0292857142857143 0.0551724126626706],...
    'String','K_{ic}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.485714285714286 0.697275863199398 0.0292857142857143 0.0551724126626706],...
    'String','U_{ic}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.782142857142857 0.697275863199398 0.0507142857142857 0.0551724126626706],...
    'String','K_{ic}+U_{ic}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.177857142857143 0.416241380440777 0.0292857142857143 0.0551724126626707],...
    'String','N_{ic}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.485714285714286 0.416241380440777 0.0292857142857143 0.0551724126626707],...
    'String','T_{ic}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.792857142857143 0.417965518371812 0.0292857142857142 0.0551724126626708],...
    'String','Ez',...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.177142857142857 0.136931035613191 0.0307142857142856 0.0551724126626707],...
    'String','V_{icx}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.484285714285714 0.136931035613191 0.0307142857142855 0.0551724126626707],...
    'String','V_{icy}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.792142857142857 0.136931035613191 0.0307142857142856 0.0551724126626707],...
    'String','V_{icz}',...
    'LineStyle','none',...
    'FontSize',14,...
    'FontName','Times New Roman',...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);


%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure2.png');
% print(f,'-depsc','-painters','figure2.eps');