%%
% figure7
% the components of pressure work and their integral
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper4';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\Paper4\data';

%% figure proterties
xrange = [0, 60];
fontsize = 12;

%% pressure work components
cd(datdir);
pwc = load('pressure_work_components.mat');

%% integral pressuer work components
ipwc = load('pressure_work_components_integral.mat');

%% figure size
f=figure('Position',[500,500,1000,400]);
ha=slj.Plot.subplot(1,2,[0.0001,0.1],[0.2,0.07],[0.1,0.025]);

%% pressure work componetns
axes(ha(1));
p1 = plot(pwc.tt, pwc.rate(1,:), '--r', 'LineWidth', 2);
hold on
p2 = plot(pwc.tt, pwc.rate(2,:), '-r', 'LineWidth', 2);
p3 = plot(pwc.tt, pwc.rate(3,:), '--g', 'LineWidth', 2);
p4 = plot(pwc.tt, pwc.rate(4,:), '-g', 'LineWidth', 2);
p5 = plot(pwc.tt, pwc.rate(5,:), '--b', 'LineWidth', 2);
p6 = plot(pwc.tt, pwc.rate(6,:), '-b', 'LineWidth', 2);
p7 = plot(pwc.tt, pwc.rate(7,:), '-k', 'LineWidth', 2);
xlim(xrange);
hold off
xlabel('\Omega_{ci} t');
ylabel('-(P_{ic}\cdot\nabla)\cdot V_{ic}');
set(gca,'FontSize',fontsize);
lgd = legend([p1, p2, p3, p4], '-P_{xx}\partial V_x/\partial x', '-P_{xz}\partial V_x/\partial z',...
    '-P_{xy}\partial V_y/\partial x', '-P_{yz} \partial V_y/\partial z','Box', 'off');
as = axes('position',get(gca,'position'),'visible','off','FontSize', fontsize, 'Position',[0.345333335806926 0.64708335818847 0.133999997526407 0.26374999254942]);
legend(as, [p5, p6, p7],'-P_{xz}\partial V_z/\partial x', '-P_{zz} \partial V_z/\partial z',...
    '-(P\cdot\nabla)\cdot V', 'Box', 'off','FontSize', fontsize, 'Position',[0.190333336104949 0.70833333907028 0.143999997228384 0.204999994263053]);


%% integral of pressure work componetns
axes(ha(2));
p1 = plot(ipwc.tt, ipwc.rate(1,:), '--r', 'LineWidth', 2);
hold on
p2 = plot(ipwc.tt, ipwc.rate(2,:), '-r', 'LineWidth', 2);
p3 = plot(ipwc.tt, ipwc.rate(3,:), '--g', 'LineWidth', 2);
p4 = plot(ipwc.tt, ipwc.rate(4,:), '-g', 'LineWidth', 2);
p5 = plot(ipwc.tt, ipwc.rate(5,:), '--b', 'LineWidth', 2);
p6 = plot(ipwc.tt, ipwc.rate(6,:), '-b', 'LineWidth', 2);
p7 = plot(ipwc.tt, ipwc.rate(7,:), '-k', 'LineWidth', 2);
hold off
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('\Delta U_{ic}');
set(gca,'FontSize',fontsize);
lgd = legend([p1, p2, p3, p4], '\int_0^t -P_{xx}\partial V_x/\partial x dt', '\int_0^t -P_{xz}\partial V_x/\partial z dt',...
    '\int_0^t -P_{xy}\partial V_y/\partial x dt', '\int_0^t -P_{yz} \partial V_y/\partial z dt',...
    'Box', 'off','FontSize', fontsize, 'Position',[0.590333337237437 0.597083367733728 0.181999996095896 0.333749990463257]);
as = axes('position',get(gca,'position'),'visible','off');
legend(as, [p5, p6, p7], '\int_0^t -P_{xz}\partial V_z/\partial x dt', '\int_0^t -P_{zz} \partial V_z/\partial z dt',...
    '\int_0^t -(P\cdot\nabla)\cdot V dt', 'Box', 'off','FontSize', fontsize, 'Position',[0.792333337237437 0.33583334048589 0.181999996095896 0.252499992847439]);
xlabel('\Omega_{ci} t');


%% panel legend
annotation(f,'textbox',...
    [0.031 0.844000001788139 0.0494999988228083 0.0849999982118607],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',14);
annotation(f,'textbox',...
    [0.52 0.844000001788139 0.0494999988228083 0.0849999982118607],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',14);

%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure7.png');
print(f,'-depsc','-painters','figure7.eps');