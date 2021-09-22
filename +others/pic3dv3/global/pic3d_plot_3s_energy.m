clear;
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Global';
%% plot energy
h1=figure;
en=load([indir,'\energy.dat']);
tt=0.1*(0:size(en,1)-1);
plot(tt,en(:,1),'y','LineWidth',2); hold on
plot(tt,en(:,2),'g','LineWidth',2);
plot(tt,en(:,3)+en(:,5),'b','LineWidth',2);
plot(tt,en(:,4),'r','LineWidth',2);
% plot(tt,en(:,5),'m','LineWidth',2);
plot(tt,en(:,6),'m','LineWidth',2);
plot(tt,en(:,7),'k','LineWidth',2); hold off
% plot([9333,9333],[0,5e4],'--r','LineWidth',1); hold off
xlim([0,tt(end)]);
% legend('Electric Field Energy','Magnetic Field Energy','Electron Energy','Ions Energy','Electrons Energy(c)','Cold Ions Energy','Total Energy');
legend('Electric Field Energy','Magnetic Field Energy','Electron Energy','Ion Energy','Cold Ion Energy','Total Energy');
xlabel('\omega_{cl}t');
ylabel('Energy');
set(gca,'FontSize',14);
cd(outdir);
print(h1,'-dpng','-r300','energy.png');

%% plot energy rate
h2=figure;
tot=en(:,7);
nt=length(tot);
rate=zeros(1,nt);

for t=1:nt
    rate(t)=(tot(t)-tot(1))/tot(1);
end

plot(tt,rate,'k','LineWidth',2);
% plot([9333,9333],[-0.02,0.18],'--r','LineWidth',1); hold off
xlabel('\omega_{cl}t');
ylabel('(E(t)-E(1))/E(1)');
xlim([0,tt(end)]);
set(gca,'FontSize',14);
cd(outdir)
print(h2, '-dpng','-r300','energy_rate.png');