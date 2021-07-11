%% check the energy of rec2d code
% writen by Liangjin Song on 20200909
indir='E:\Simulation\Test_Asy\rec2d_B1.5T06Bs6Bg00\data';
outdir='E:\Simulation\Test_Asy\rec2d_B1.5T06Bs6Bg00\out';

cd(indir);
en=load('energy_half.dat');

tot=en(:,5)+en(:,10);
nt=length(tot);
rate=zeros(1,nt);

for t=1:nt
    rate(t)=(tot(t)-tot(1))/tot(1);
end

h1=figure;
plot(rate,'k','LineWidth',2);
ylabel('(E(t)-E(1))/E(1)');
xlim([1,nt]);
set(gca,'FontSize',14);
cd(outdir)
print(h1,'-dpng','-r300','energy_rate.png');

h2=figure;
plot(en(:,1)+en(:,6),'r','LineWidth',2); hold on
plot(en(:,2)+en(:,7),'g','LineWidth',2);
plot(en(:,3)+en(:,8),'b','LineWidth',2);
plot(en(:,4)+en(:,9),'m','LineWidth',2);
plot(en(:,5)+en(:,10),'k','LineWidth',2); hold off
legend('Electric Field Energy','Magnetic Field Energy','Ion Energy','Electron Energy','Total Energy');
xlim([1,nt]);
ylabel('Energy');
set(gca,'FontSize',14);
cd(outdir);
print(h2,'-dpng','-r300','energy.png');
