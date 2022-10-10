%%
% figure3
% (a) the total energy change, (b) the components of Jic.E, (c) the time integral of Jic.E and its components
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\data';

%% figure proterties
xrange = [0, 60];
fontsize = 14;

%% total energy conversion
cd(datdir);
tec = load('total_energy_conversion.mat');

%% the components of energy conversion
cec = load('electric_work.mat');

%% the integral of components of energy conversion
icec = load('electric_work_integral.mat');

%% figure size
f=figure('Position',[300,500,1200,350]);
ha=slj.Plot.subplot(1,3,[0.0001,0.085],[0.2,0.07],[0.07,0.02]);

%% total energy conversion
axes(ha(1));
plot(tec.tt, tec.rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tec.tt, tec.rate(2,:), '-r', 'LineWidth', 2);
legend('\partial (K+U)/\partial t', 'J_{ic}\cdot E', 'Location', 'Best', 'Box', 'off');
xlim(xrange);
xlabel('\Omega_{ci}t');
set(get(gca, 'YLabel'), 'String', ['\partial (K_{ic}+U_{ic})/\partial t']);
set(gca,'FontSize', fontsize);

%% components of energy conversion
axes(ha(2));
plot(cec.tt, cec.rate(1,:), '-k', 'LineWidth', 2);
hold on
plot(cec.tt, cec.rate(2,:), '-r', 'LineWidth', 2);
plot(cec.tt, cec.rate(3,:), '-g', 'LineWidth', 2);
plot(cec.tt, cec.rate(4,:), '-b', 'LineWidth', 2);
legend('qNV\cdot E', 'qNVxEx', 'qNVyEy', 'qNVzEz', 'Location', 'Best', 'Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('J_{ic}\cdot E');
set(gca,'FontSize',fontsize);

%% integral of components of energy conversion
axes(ha(3));
plot(icec.tt, icec.rate(1, :), '-r', 'LineWidth', 2); hold on
plot(icec.tt, icec.rate(2, :), '-g', 'LineWidth', 2); hold on
plot(icec.tt, icec.rate(3, :), '-b', 'LineWidth', 2);
plot(icec.tt, icec.rate(4, :), '-k', 'LineWidth', 2);
legend('\int_0^t qNVxEx dt', '\int_0^t qNVyEy dt', '\int_0^t qNVzEz dt', '\int_0^t qNV\cdot E dt', 'Location', 'Best','Box','off', ...
    'Position',[0.804533333333333 0.260478582668304 0.124999997541309 0.39285713161741]);
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('\Delta E_{ic}');
set(gca,'FontSize',fontsize);

%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.0258333333333333 0.873285716329302 0.0412499990190069 0.0971428550992693],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.357500000000001 0.873285716329302 0.0412499990190069 0.0971428550992693],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.690000000000002 0.873285716329302 0.0404166657105088 0.0971428550992693],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);

%% save figure
cd(outdir);
print(f,'-dpng','-r300','figure3.png');
print(f,'-depsc','-painters','figure3.eps');