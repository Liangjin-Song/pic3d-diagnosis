%%
% figure6
% (a) the thermal energy change, (b) the components of pressure work, (c) the time integral of pressure work and its components
%%
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper4';
prm=slj.Parameters(indir,outdir);
datdir = 'E:\Asym\cold2_ds1\out\Article\Paper4\data';

%% figure proterties
xrange = [0, 60];
fontsize = 14;

%% thermal energy conversion
cd(datdir);
tec = load('thermal_energy_conversion.mat');

%% the components of pressure work
cpw = load('pressure_work.mat');

%% the integral of components of pressure work
icpw = load('pressure_work_integral.mat');

%% figure size
f=figure('Position',[300,500,1200,350]);
ha=slj.Plot.subplot(1,3,[0.0001,0.07],[0.2,0.07],[0.07,0.02]);

%% thermal energy conversion
axes(ha(1));
plot(tec.tt, tec.rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tec.tt, -tec.rate(3,:), '-r', 'LineWidth', 2);
legend('\partial U/\partial t', '-(P\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial U_{ic}/\partial t']);
set(gca,'FontSize', fontsize);

%% components of pressure work
axes(ha(2));
plot(cpw.tt, -cpw.rate(1, :), '-k', 'LineWidth', 2); hold on
plot(cpw.tt, -cpw.rate(3, :), '-b', 'LineWidth', 2);
plot(cpw.tt, -cpw.rate(4, :), '-m', 'LineWidth', 2);
plot(cpw.tt, -cpw.rate(5, :), '-r', 'LineWidth', 2);
legend('-(P\cdot\nabla)\cdot V', '-p\nabla\cdot V', '-(P''_{g}\cdot\nabla)\cdot V', '-(P''_{ng}\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('-(P_{ic}\cdot\nabla)\cdot V_{ic}');
set(gca,'FontSize',fontsize);

%% integral of components of pressure work
axes(ha(3));
plot(icpw.tt, -icpw.rate(1, :), '-k', 'LineWidth', 2); hold on
plot(icpw.tt, -icpw.rate(3, :), '-b', 'LineWidth', 2);
plot(icpw.tt, -icpw.rate(4, :), '-m', 'LineWidth', 2);
plot(icpw.tt, -icpw.rate(5, :), '-r', 'LineWidth', 2);
legend('-\int_0^t (P\cdot\nabla)\cdot V dt', '-\int_0^t p\nabla\cdot V dt', '-\int_0^t (P''_{g}\cdot\nabla)\cdot V dt', '-\int_0^t (P''_{ng}\cdot\nabla)\cdot V dt', ...
    'Location', 'Best','Box','off', 'Position',[0.703319696969697 0.631907154096875 0.184545450427316 0.392857131617411]);
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('\DeltaU_{ic}');
set(gca,'FontSize',fontsize);

%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.0125 0.864714287757873 0.0412499990190069 0.0971428550992693],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.339166666666667 0.864714287757873 0.0412499990190069 0.0971428550992693],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.666666666666669 0.86185714490073 0.0404166657105088 0.0971428550992693],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);


%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure6.png');
print(f,'-depsc','-painters','figure6.eps');
