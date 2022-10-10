%%
% plot figure1
% (a) reconnection rate, (b) the energy change, (c) the thermal and bulk kinetic energy of cold ions
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

%% reconnection rate
cd(datdir);
MR_rate = load('MR_rate.mat');

%% energy change
en=load([indir,'\energy.dat']);
de=(en(:,:)-en(1,:))./en(1,2);
tt=0.1*(0:size(en,1)-1);

%% bulk kinetic energy and thermal energy of cold ions
cd(datdir);
KU = load('KUic.mat');

%% the size of the figure
f=figure('Position',[300,500,1200,350]);
ha=slj.Plot.subplot(1,3,[0.0001,0.085],[0.2,0.07],[0.07,0.02]);

%% panel (a)
axes(ha(1));
plot(MR_rate.tt,-MR_rate.rate,'-k','LineWidth',2);
hold on
plot(MR_rate.tt(1:end-1),MR_rate.nrate,'-r','LineWidth',2);
hold off
xlabel('\Omega_{ci}t');
ylabel('E_R');
xlim(xrange);
ylim([0, 0.12]);
legend('Ey', 'd\phi/dt', 'Box', 'off', 'Position', [0.144536083442802 0.262380939608528 0.0749999990314245 0.132857139280864]);
set(gca,'FontSize',fontsize);

%% panel (b)
axes(ha(2));
plot(tt,de(:,2),'-k','LineWidth',2); hold on
plot(tt,de(:,3),'-b','LineWidth',2);
plot(tt,de(:,4),'-m','LineWidth',2);
plot(tt,de(:,5),'-r','LineWidth',2); hold off
legend('B','Electron','Hot Ion','Cold Ion','Location','Best', 'Box', 'off', 'Location', 'Best');
xlabel('\Omega_{ci}t');
ylabel('\Delta E');
xlim(xrange);
set(gca,'FontSize',fontsize);

%% panel (c)
axes(ha(3));
plot(KU.tt, KU.rate(1,:), '-b', 'LineWidth', 2);
hold on
plot(KU.tt, KU.rate(2,:), '-r', 'LineWidth', 2);
plot(KU.tt, KU.rate(3,:), '-k', 'LineWidth', 2);
legend('K', 'U', 'Sum', 'Location', 'Best','Box','off', 'Location', 'Best');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel(['E_{', KU.sfx,'}']);
set(gca,'FontSize',fontsize);

%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.0733333333333335 0.824714287757873 0.0412499990190069 0.0971428550992693],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.404166666666668 0.824714287757873 0.0412499990190069 0.0971428550992693],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize);
annotation(f,'textbox',...
    [0.735833333333336 0.824714287757873 0.0404166657105088 0.0971428550992693],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize);

%% save figure
cd(outdir);
print(f,'-dpng','-r300','figure1.png');
print(f,'-depsc','-painters','figure1.eps');