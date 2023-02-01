%%
% plot figure1
% (a) reconnection rate, (b) the energy change, (c) the thermal and bulk kinetic energy of cold ions
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

%% reconnection rate
cd(datdir);
MR_rate = load('MR_rate.mat');

%% energy change
en=load([indir,'\energy.dat']);
de4=(en(:,:)-en(1,:))./en(1,2);
tt4=0.1*(0:size(en,1)-1);

en=load('E:\Asym\cold4_ds1\data\energy.dat');
de3=(en(:,:)-en(1,:))./en(1,2);
tt3=0.1*(0:size(en,1)-1);

en=load('E:\Asym\cold3_ds1\data\energy.dat');
de2=(en(:,:)-en(1,:))./en(1,2);
tt2=0.1*(0:size(en,1)-1);

en=load('E:\Asym\cold1_ds1\data\energy.dat');
de1=(en(:,:)-en(1,:))./en(1,2);
tt1=0.1*(0:size(en,1)-1);



%% bulk kinetic energy and thermal energy of cold ions
cd(datdir);
KU = load('KUic.mat');

%% the size of the figure
f=figure('Position',[300,100,1200,650]);
ha=slj.Plot.subplot(2,3,[0.03,0.085],[0.13,0.07],[0.07,0.02]);

%% panel (a)
axes(ha(1));
plot(MR_rate.tt,-MR_rate.rate,'-k','LineWidth',2);
hold on
plot(MR_rate.tt(1:end-1),MR_rate.nrate,'-r','LineWidth',2);
hold off
ylabel('E_R');
set(gca, 'xtick', 0:10:60);
xlim(xrange);
set(gca,'XTicklabel',[]);
ylim([0, 0.12]);
legend('Ey', 'd\phi/dt', 'Box', 'off', 'Position', [0.144536083442802 0.262380939608528 0.0749999990314245 0.132857139280864]);
set(gca,'FontSize',fontsize);

%% panel (b)
E = KU.rate(1,:)+KU.rate(2,:);
dE = E(2:end)-E(1);
dKE = (KU.rate(1,2:end)-KU.rate(1,1))./dE;
dUE = (KU.rate(2,2:end)-KU.rate(2,1))./dE;
axes(ha(2));
plot(KU.tt(2:end), dKE, '-b', 'LineWidth', 2);
hold on
plot(KU.tt(2:end), dUE, '-r', 'LineWidth', 2);
legend('\DeltaK_{ic}/\DeltaE_{ic}', '\DeltaU_{ic}/\DeltaE_{ic}', 'Location', 'Best','Box','off', 'Location', 'Best');
set(gca, 'xtick', 0:10:60);
xlim(xrange);
set(gca,'XTicklabel',[]);
% ylabel(['E_{', KU.sfx,'}']);
set(gca,'FontSize',fontsize);


%% panel (c)
axes(ha(3));
plot(tt4,de4(:,2),'-k','LineWidth',2); hold on
plot(tt4,de4(:,3),'-b','LineWidth',2);
plot(tt4,de4(:,4),'-m','LineWidth',2);
plot(tt4,de4(:,5),'-r','LineWidth',2); hold off
legend('B','Electron','Hot Ion','Cold Ion','Location','Best', 'Box', 'off', 'Location', 'Best');
ylabel('\Delta E');
set(gca, 'xtick', 0:10:60);
xlim(xrange);
set(gca,'XTicklabel',[]);
set(gca,'FontSize',fontsize);

%%
axes(ha(4));
plot(tt3,de3(:,2),'-k','LineWidth',2); hold on
plot(tt3,de3(:,3),'-b','LineWidth',2);
plot(tt3,de3(:,4),'-m','LineWidth',2);
plot(tt3,de3(:,5),'-r','LineWidth',2); hold off
legend('B','Electron','Hot Ion','Cold Ion','Location','Best', 'Box', 'off', 'Location', 'Best');
xlabel('\Omega_{ci}t');
ylabel('\Delta E');
set(gca, 'xtick', 0:10:60);
xlim(xrange);
set(gca,'FontSize',fontsize);

%%
axes(ha(5));
plot(tt2,de2(:,2),'-k','LineWidth',2); hold on
plot(tt2,de2(:,3),'-b','LineWidth',2);
plot(tt2,de2(:,4),'-m','LineWidth',2);
plot(tt2,de2(:,5),'-r','LineWidth',2); hold off
legend('B','Electron','Hot Ion','Cold Ion','Location','Best', 'Box', 'off', 'Location', 'Best');
xlabel('\Omega_{ci}t');
ylabel('\Delta E');
set(gca, 'xtick', 0:10:60);
xlim(xrange);
set(gca,'FontSize',fontsize);


%%
axes(ha(6));
plot(tt1,de1(:,2),'-k','LineWidth',2); hold on
plot(tt1,de1(:,3),'-b','LineWidth',2);
plot(tt1,de1(:,4),'-m','LineWidth',2);
plot(tt1,de1(:,5),'-r','LineWidth',2); hold off
legend('B','Electron','Hot Ion','Cold Ion','Location','Best', 'Box', 'off', 'Location', 'Best');
xlabel('\Omega_{ci}t');
ylabel('\Delta E');
set(gca, 'xtick', 0:10:60);
xlim(xrange);
set(gca,'FontSize',fontsize);


%% panel label
fontsize=fontsize + 2;
annotation(f,'textbox',...
    [0.0675000000000001 0.882076924223165 0.042916665636003 0.0538461526999107],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.417500000000001 0.880538462684703 0.0437499989445011 0.0538461526999107],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.730833333333334 0.880538462684703 0.042916665636003 0.0538461526999107],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0675000000000002 0.465153847300088 0.0437499989445011 0.0538461526999107],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.399166666666668 0.465153847300088 0.042916665636003 0.0538461526999107],...
    'String',{'(e)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.730833333333335 0.465153847300088 0.0412499990190069 0.0538461526999107],...
    'String',{'(f)'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');


annotation(f,'textbox',...
    [0.135 0.56823077078966 0.118749996709327 0.067692306133417],...
    'String',{'N_{ic0}/N_{ih0}=10'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.476666666666667 0.572846155405045 0.118749996709327 0.067692306133417],...
    'String',{'N_{ic0}/N_{ih0}=10'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.795833333333337 0.855923078481963 0.118749996709327 0.067692306133417],...
    'String',{'N_{ic0}/N_{ih0}=10'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.128333333333334 0.429769232328123 0.109583330315848 0.067692306133417],...
    'String',{'N_{ic0}/N_{ih0}=6'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.462500000000001 0.432846155405045 0.109583330315848 0.067692306133417],...
    'String',{'N_{ic0}/N_{ih0}=3'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.795000000000002 0.43746154002043 0.109583330315848 0.067692306133417],...
    'String',{'N_{ic0}/N_{ih0}=1'},...
    'LineStyle','none',...
    'FontSize',fontsize,...
    'FontName','Times New Roman');


%% save figure
cd(outdir);
% print(f,'-dpng','-r300','figure1.png');
% print(f,'-depsc','-painters','figure1.eps');