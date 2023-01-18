%% plot figure 1, electric field and temperature
% written by Liangjin Song on 20221212 at NCU
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper5';
prm = slj.Parameters(indir, outdir);

%% time
tt1 = 30;
tt2 = 50;

%% normalization
normE = prm.value.vA;
normT = prm.value.thm/prm.value.coeff;

%% the figure proterties
extra.yrange=[-10, 10];

%% the size of the figure
f=figure('Position',[500,100,1000,500]);
ha=slj.Plot.subplot(2,2,[0.01,0.13],[0.13,0.07],[0.1,0.02]);

%% Panel (a), Ez at tt1
dy = 0.11;
dx = 0.065;
axes(ha(1));
E = prm.read('E', tt1);
ss = prm.read('stream', tt1);
h = slj.Plot.overview(E.z,ss,prm.value.lx,prm.value.lz,normE,extra);
colormap(ha(1), slj.Plot.mycolormap(0));
caxis([-3,3]);
set(ha(1),'XTicklabel',[]);
ylabel('Z [c/\omega_{pi}]');
pos0 = get(ha(1), 'Position');
pos0(2) = pos0(2) - dy;
pos0(1) = pos0(1) + dx;
set(ha(1), 'Position', pos0);
title(['t = ', num2str(tt1)]);
delete(h);


%% Panel (b), Ez at tt2
axes(ha(2));
E = prm.read('E', tt2);
ss = prm.read('stream', tt2);
slj.Plot.overview(E.z,ss,prm.value.lx,prm.value.lz,normE,extra);
colormap(ha(2), slj.Plot.mycolormap(0));
caxis([-3,3]);
set(ha(2),'XTicklabel',[]);
set(ha(2),'YTicklabel',[]);
pos = get(ha(2), 'Position');
pos(2) = pos(2) - dy;
pos(3) = pos0(3);
pos(1) = pos(1) - dx;
set(ha(2), 'Position', pos);
title(['t = ', num2str(tt2)]);

%% Panel (c), Tic at tt1
axes(ha(3));
P = prm.read('Ph', tt1);
N = prm.read('Nh', tt1);
ss = prm.read('stream', tt1);
T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));
h = slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, normT, extra);
caxis([0, 30]);
colormap(ha(3), 'default');
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
pos = get(ha(3), 'Position');
pos(3) = pos0(3);
pos(1) = pos(1) + dx;
set(ha(3), 'Position', pos);
delete(h);

%% plot the selected distribution function region
hold on
xx = [41,42];
zz = [2.5,4];
cr = '-m';
plot_rectangle(xx, zz, cr);
zz = [1, 2.5];
cr = '-k';
plot_rectangle(xx, zz, cr);
zz = [0, 1];
cr = '-w';
plot_rectangle(xx, zz, cr);
zz = [-1, 0];
cr = '-r';
plot_rectangle(xx, zz, cr);

xx = [28,29];
zz = [2.5,4];
cr = '-m';
plot_rectangle(xx, zz, cr);
zz = [1, 2.5];
cr = '-k';
plot_rectangle(xx, zz, cr);
zz = [0, 1];
cr = '-w';
plot_rectangle(xx, zz, cr);
zz = [-1, 0];
cr = '-r';
plot_rectangle(xx, zz, cr);

xx = [24.5,25.5];
zz = [2.5,4];
cr = '-m';
plot_rectangle(xx, zz, cr);
zz = [1, 2.5];
cr = '-k';
plot_rectangle(xx, zz, cr);
zz = [0, 1];
cr = '-w';
plot_rectangle(xx, zz, cr);
zz = [-1, 0];
cr = '-r';
plot_rectangle(xx, zz, cr);



%% Panel (d), Tic at tt2
axes(ha(4));
P = prm.read('Ph', tt2);
N = prm.read('Nh', tt2);
ss = prm.read('stream', tt2);
T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));
h = slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, normT, extra);
caxis([0, 30]);
colormap(ha(4), 'default');
xlabel('X [c/\omega_{pi}]');
set(ha(4),'YTicklabel',[]);
pos = get(ha(4), 'Position');
pos(3) = pos0(3);
pos(1) = pos(1) - dx;
set(ha(4), 'Position', pos);
pos = get(h, 'Position');
pos(1) = pos(1) - 0.01;
set(h, 'Position', pos);

%% label
annotation(f,'textbox',...
    [0.306 0.497000001609325 0.0354999986439944 0.0739999983906746],...
    'String',{'Ez'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.683 0.499000001609325 0.0354999986439944 0.0739999983906746],...
    'String',{'Ez'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.303 0.202000001609326 0.0414999984651804 0.0739999983906746],...
    'String',{'Tic'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.677 0.202000001609326 0.0414999984651804 0.0739999983906746],...
    'String',{'Tic'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman',...
    'BackgroundColor',[1 1 1]);
annotation(f,'textbox',...
    [0.1 0.703000001490117 0.0514999987632037 0.0699999985098839],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.502 0.687000001490117 0.0524999987334014 0.0699999985098839],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.099 0.407000001490117 0.0514999987632037 0.0699999985098839],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.503 0.391000001490117 0.0524999987334013 0.0699999985098839],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',16,...
    'FontName','Times New Roman');


%% save
cd(outdir);
% print('-dpng', '-r300', 'figure1.png');

function plot_rectangle(xx, zz, cr)
plot([xx(1),xx(2)],[zz(1), zz(1)], cr, 'LineWidth', 2);
plot([xx(1),xx(2)],[zz(2), zz(2)], cr, 'LineWidth', 2);
plot([xx(1),xx(1)],[zz(1), zz(2)], cr, 'LineWidth', 2);
plot([xx(2),xx(2)],[zz(1), zz(2)], cr, 'LineWidth', 2);
end