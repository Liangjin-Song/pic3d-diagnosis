%% test the energy conversion
% writen by Liangjin Song on 20190910
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/MR/';
% indir='/home/liangjin/';
% outdir='/home/liangjin/';

cd(indir);
en=load('energy_half.dat');
nt=length(en(:,1));
utot=en(1:nt,10);
ltot=en(1:nt,5);
rate=zeros(1,nt);
for t=1:nt
    rate(t)=(utot(t)-utot(1)+ltot(t)-ltot(1))/(utot(1)+ltot(1));
    % rate(t)=(utot(t)-utot(1))/utot(1);
    % rate(t)=(ltot(t)-ltot(1))/ltot(1);
end
figure;
plot(rate,'k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('(E(t)-E(0))/E(0)');
xlim([0,100]);
cd(outdir);
