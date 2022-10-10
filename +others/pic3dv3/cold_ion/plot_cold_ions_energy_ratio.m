%% the ratio of the total conversion energy of the increased energy points of various ions
% writen by Liangjin Song on 20210320
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Poster';

%% read data
cd(indir);
en=load([indir,'\energy.dat']);
nt=size(en,1);
tt=0.1*(0:size(en,1)-1);
%% the energy change
dB=zeros(1,nt);
di=zeros(1,nt);
de=zeros(1,nt);
dic=zeros(1,nt);
dice=zeros(1,nt);
rdi=zeros(1,nt);
rde=zeros(1,nt);
rdic=zeros(1,nt);
rdice=zeros(1,nt);

for t=2:nt
    dB(t)=en(t,2)-en(1,2);
    de(t)=en(t,3)-en(1,3);
    di(t)=en(t,4)-en(1,4);
    dice(t)=en(t,5)-en(1,5);
    dic(t)=en(t,6)-en(1,6);
end
sum=-(di+de+dic+dice);

%% the energy change ratio
dB=abs(dB);
for t=2:nt
    rdi(t)=di(t)/dB(t);
    rde(t)=de(t)/dB(t);
    rdic(t)=dic(t)/dB(t);
    rdice(t)=dice(t)/dB(t);
end

%% figure
cd(outdir);
f1=figure;
plot(tt,dB,'-k','LineWidth',1.5); hold on
plot(tt,de+dice,'-m','LineWidth',1.5);
plot(tt,di,'-b','LineWidth',1.5);
% plot(tt,dice,'-m','LineWidth',1.5);
plot(tt,dic,'-r','LineWidth',1.5); hold off
legend('Magnetic Energy','Electron Energy','Ion Energy','Cold Ion Energy','Location','Best');
% legend('Magnetic Field Energy','Electron Energy','Ions Energy','Electrons Energy(c)','Cold Ions Energy');
xlabel('\omega_{cl}t');
ylabel('Energy change');
set(gca,'FontSize',14);
print(f1,'-dpng','-r300','energy_change.png');

f2=figure;
plot(tt,rde+rdice,'-b','LineWidth',1.5); hold on
plot(tt,rdi,'-k','LineWidth',1.5);
% plot(tt,rdice,'-m','LineWidth',1.5);
plot(tt,rdic,'-r','LineWidth',1.5); hold off
xlabel('\omega_{cl}t');
ylabel('Energy change ratio');
legend('Electron','Ion','Cold Ion','Location','Best');
% legend('Electron Energy','Ions Energy','Electrons Energy(c)','Cold Ions Energy');
xlim([15,tt(end)]);
set(gca,'FontSize',14);
print(f2,'-dpng','-r300','energy_change_ratio.png');

%% average energy per particle gains
% the number of ions
Ni=3.6929e+08;
% the number of cold ions
Nic=1.2307e+09;
%% average
% ions
adi=di/Ni;
% electrons
ade=(de+dice)/(Ni+Nic);
% cold ions
adic=dic/Nic;
% normalization
norm=0.5*0.269999*0.025*0.025;
%% figure
f3=figure;
plot(tt, adi/norm, '-r', 'LineWidth', 1.5); hold on
plot(tt, ade/norm, '-b', 'LineWidth', 1.5);
plot(tt, adic/norm, '-k', 'LineWidth', 1.5); hold off
legend('Ion', 'Electron', 'Cold Ion','Location','Best');
xlabel('\Omega_{cl}t');
ylabel('average energy gained by per particle');
set(gca,'FontSize',14);
xlim([0,50]);
print(f3,'-dpng','-r300','average_energy_per_particle.png');