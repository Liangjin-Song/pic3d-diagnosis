% function plot_species_energy()
clear;
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out';
prm=slj.Parameters(indir,outdir);
xrange=[0 90];
t0=1;
%% plot energy
h1=figure;
en=load([indir,'\energy.dat']);
tt=0.1*(0:size(en,1)-1);
plot(tt,en(:,1),'y','LineWidth',2); hold on
plot(tt,en(:,2),'g','LineWidth',2);
plot(tt,en(:,3),'b','LineWidth',2);
plot(tt,en(:,4),'m','LineWidth',2);
plot(tt,en(:,5),'r','LineWidth',2);
plot(tt,en(:,6),'k','LineWidth',2); hold off
xlim(xrange);
legend('E','B','Electron','Hot Ion','Cold Ion','Total Energy', 'Box', 'off');
xlabel('\Omega_{ci}t');
ylabel('Energy');
set(gca,'FontSize',14);
cd(outdir);
print(h1,'-dpng','-r300','energy.png');

%% plot energy rate
h2=figure;
tot=en(:,6);
nt=length(tot);
rate=zeros(1,nt);

for t=1:nt
    rate(t)=(tot(t)-tot(t0))/tot(t0);
end

plot(tt,rate,'k','LineWidth',2);
% plot([9333,9333],[-0.02,0.18],'--r','LineWidth',1); hold off
xlabel('\Omega_{ci}t');
ylabel('(E(t)-E(0))/E(0)');
xlim(xrange);
set(gca,'FontSize',14);
cd(outdir)
print(h2, '-dpng','-r300','energy_rate.png');

%% the energy change
de=en(:,:)-en(t0,:);
h3=figure;
norm = en(1,2);
plot(tt,de(:,2)/norm,'k','LineWidth',2); hold on
plot(tt,de(:,3)/norm,'b','LineWidth',2);
plot(tt,de(:,4)/norm,'m','LineWidth',2);
plot(tt,de(:,5)/norm,'r','LineWidth',2); hold off
xlim([0,tt(end)]);
legend('B','Electron','Hot Ion','Cold Ion','Location','Best', 'Box', 'off');
xlabel('\Omega_{ci}t');
ylabel('\Delta E');
xlim(xrange);
set(gca,'FontSize',14);
cd(outdir)
print(h3, '-dpng','-r300','energy_change.png');

h5 = figure;
rde = zeros(size(de,1),3);
rde(:,1) = de(:,3)./abs(de(:,2));
rde(:,2) = de(:,4)./abs(de(:,2));
rde(:,3) = de(:,5)./abs(de(:,2));
plot(tt, rde(:,1), 'b', 'LineWidth', 2); hold on
plot(tt, rde(:,2), 'm', 'LineWidth', 2);
plot(tt, rde(:,3), 'r', 'LineWidth', 2);
hold off;
legend('Electron', 'Hot Ion', 'Cold Ion', 'Location', 'Best', 'Box', 'off');
xlabel('\Omega_{ci}t');
ylabel('\Delta E/\Delta E_B');
xlim(xrange);
set(gca,'FontSize',14);
cd(outdir)
print(h5, '-dpng','-r300','energy_change_ratio.png');



%% the average energy change
Ni=prm.read('Nl',0);
Ni=sum(sum(Ni.value));
Ne=prm.read('Ne',0);
Ne=sum(sum(Ne.value));
Nh=prm.read('Nh',0);
Nh=sum(sum(Nh.value));
aEe=de(:,3)/Ne;
aEi=de(:,4)/Ni;
aEh=de(:,5)/Nh;

h4=figure;
plot(tt,aEe,'b','LineWidth',2); hold on
plot(tt,aEi,'m','LineWidth',2);
plot(tt,aEh,'r','LineWidth',2);hold off
xlim([0,tt(end)]);
legend('Electron','Hot Ion','Cold Ion','Location','Best', 'Box', 'off');
xlabel('\Omega_{ci}t');
ylabel('dE_{aver}');
xlim(xrange);
set(gca,'FontSize',14);
cd(outdir)
print(h4, '-dpng','-r300','average_energy_change.png');

figure;
dEb = (en(:,2)-en(1,2))/en(1,2);
plot(tt, dEb, '-k','LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('\Delta B/B_0');
xlim(xrange);
set(gca,'FontSize',14);