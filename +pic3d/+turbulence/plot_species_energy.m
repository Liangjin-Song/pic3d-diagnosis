clear;
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\global';

xrange = [0, 180];
en=load([indir,'\energy.dat']);
tt=0.5*(0:size(en,1)-1);
%% plot energy
h1=figure;
plot(tt,en(:,1),'y','LineWidth',2); hold on
plot(tt,en(:,2),'g','LineWidth',2);
plot(tt,en(:,3),'b','LineWidth',2);
plot(tt,en(:,4),'r','LineWidth',2);
plot(tt,en(:,5),'m','LineWidth',2);
hold off
% plot([9333,9333],[0,5e4],'--r','LineWidth',1); hold off
% xlim([0,tt(end)]);
xlim(xrange);
% legend('Electric Field Energy','Magnetic Field Energy','Electron Energy','Ions Energy','Electrons Energy(c)','Cold Ions Energy','Total Energy');
legend('Electric Field Energy','Magnetic Field Energy','Electron Energy','Ion Energy','Total Energy','Box', 'off');
xlabel('\Omega_{ci}t');
ylabel('Energy');
set(gca,'FontSize',14);
cd(outdir);


de = en;
for i=1:5
    de(:,i)=de(:,i)-de(1,i);
    de(:,i)=de(:,i)./en(1, 2);
end

h4 = figure;
plot(tt,de(:,2), 'g','LineWidth',2); hold on
plot(tt,de(:,3), 'b','LineWidth',2);
plot(tt,de(:,4), 'r','LineWidth',2);
legend('Magnetic  Energy','Electron Energy','Ion Energy', 'Box', 'off');
xlabel('\Omega_{ci}t');
ylabel('\Delta E');
xlim(xrange);
set(gca,'FontSize',14);

%% plot energy rate
h2=figure;
tot=en(:,5);
nt=length(tot);
rate=zeros(1,nt);

for t=1:nt
    rate(t)=(tot(t)-tot(1))/tot(1);
end

plot(tt,rate,'k','LineWidth',2);
% plot([9333,9333],[-0.02,0.18],'--r','LineWidth',1); hold off
xlabel('\Omega_{ci}t');
ylabel('(E(t)-E(1))/E(1)');
xlim([0,tt(end)]);
xlim(xrange);
set(gca,'FontSize',14);

h3=figure;
% the number of ions
en=load([indir,'\energy.dat']);
tt=0.5*(0:size(en,1)-1);
aEe=en(:,3);
aEi=en(:,4);
plot(tt,aEe,'b','LineWidth',2); hold on
plot(tt,aEi,'r','LineWidth',2);
% plot(tt,en(:,5),'m','LineWidth',2);
% plot([9333,9333],[0,5e4],'--r','LineWidth',1); hold off
xlim([0,tt(end)]);
legend('Electron Energy','Ion Energy');
xlabel('\Omega_{ci}t');
ylabel('Average Energy');
xlim(xrange);
set(gca,'FontSize',14);

cd(outdir);
print(h1,'-dpng','-r300','energy.png');
print(h2, '-dpng','-r300','energy_rate.png');
print(h4, '-dpng','-r300','delta_E.png');