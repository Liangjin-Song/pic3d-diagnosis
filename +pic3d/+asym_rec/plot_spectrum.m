% function plot_energy_spectrum()
clear;
%% parameters
indir='E:\Asym\case1\data';
outdir='C:\Users\Liangjin\Pictures\Asym\case1\Test';
prm=slj.Parameters(indir,outdir);
%% the time of the energy spectrum
tt1=0;
tt2=10;
tt3=20;
tt4=28;
tt5=50;

%% species
spc='spctrme';
sp='e';

%% transformation from mc^2 to mvA^2
c=prm.value.c;
vA=prm.value.vA;
cva=c/vA;
cva=cva*cva;

%% read data
sm1=reset_spectrum(prm.read(spc,tt1),cva);
sm2=reset_spectrum(prm.read(spc,tt2),cva);
sm3=reset_spectrum(prm.read(spc,tt3),cva);
sm4=reset_spectrum(prm.read(spc,tt4),cva);
sm5=reset_spectrum(prm.read(spc,tt5),cva);
xx=-4:0.1:4;

%% figure
f=figure;
plot(xx, log10(fliplr(sm1)),'-k','LineWidth',2); hold on
plot(xx,log10(fliplr(sm2)),'-r','LineWidth',2);
plot(xx,log10(fliplr(sm3)),'-g','LineWidth',2);
plot(xx,log10(fliplr(sm4)),'-b','LineWidth',2);
plot(xx,log10(fliplr(sm5)),'-m','LineWidth',2); hold off
legend({['\Omega_{ci} t=',num2str(tt1)],['\Omega_{ci} t=',num2str(tt2)],['\Omega_{ci} t=',num2str(tt3)],['\Omega_{ci} t=',num2str(tt4)],['\Omega_{ci} t=',num2str(tt5)]});
% xlim([-4,2]);
% ylim([0,10]);
yticks(0:1:10);
yticklabels({'0','10^{1}','10^{2}','10^{3}','10^{4}','10^{5}','10^{6}','10^{7}','10^{8}','10^{9}','10^{10}'});
xlabel(['E_{',sp,'} [m_iv_{A}^2]']);
ylabel(['f_{',sp,'}']);
xticks(-4:1:8);
xticklabels({'10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}','10^{3}','10^{4}','10^{5}','10^{6}','10^{7}','10^{8}'});
set(gca,'FontSize',14);

%% save the figures
cd(outdir);
% print(f,'-dpng','-r300',['energy_spctrum_',sp,'.png']);



function sm=reset_spectrum(sp,cva2)
ns=length(sp);
min=-4;
max=4;
xx=min:0.1:max;
nx=length(xx);
sm=zeros(1,nx);
for i=1:ns
    k=log10(i/ns*cva2);
    if k<=min
        k=1;
    elseif k>=max
        k=nx;
    else
        k=round((nx-1)*(k-max)/(max-min)+nx);
    end
    sm(k)=sm(k)+sp(i);
end
% sm=filter1d(sm);
end

function sp=filter1d(sm)
n=1;
ns=length(sm);
sp=zeros(1,ns);
sp(1)=sm(1);
sp(ns)=sm(ns);
for i=1:n
    for j=2:ns-1
        sp(j)=sm(j-1)*0.25+sm(j)*0.6+sm(j+1)*0.25;
    end
end
end