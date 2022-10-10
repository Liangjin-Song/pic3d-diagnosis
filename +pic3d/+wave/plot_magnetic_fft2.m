% function plot_electric_fft2()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the 2d Fourier Transform of electric field
%%
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\whistler\data5';
outdir='E:\PIC\wave-particle\whistler\out5';
prm=slj.Parameters(indir, outdir);
% time
% tt=[51:157,158.01:280.01,281:321,322.04:362.04,363.03:403.03,404.02:444.02,445.01:485.01,486:500];
% tt=[0:232,233.01:396.01,397.02:499.02];
tt=121:150;
%% figure style
extra=[];
%% the electric field as the function of the position and the time
nt=length(tt);
Bx=zeros(nt,prm.value.nx);
for t=1:nt
    %% read data
    B=prm.read('B',tt(t));
    Bx(t,:)=B.z;
end

%% the 2d fast Fourier Transform fft for both time and position
fw=prm.value.fce;
fk=prm.value.debye;
wk=slj.Wave(Bx,fk,fw);

[kk,ff]=meshgrid(wk.k,wk.w);

figure;
p=pcolor(kk,ff,wk.wk);
colorbar;
shading flat;
axis on;
p.FaceColor = 'interp';
colormap('jet');
xlabel('k [\lambda_D^{-1}]');
ylabel('\omega [\omega_{ce}]');
xlim([-400,400]);
ylim([0,1]);
set(gca,'FontSize',14);

% f=0:0.001:prm.value.fce;
% k=sqrt(f./(prm.value.fce-f))/prm.value.de;
% hold on
% plot(k/fk, f/fw,'-r','LineWidth',2);

cd(outdir);
print('-r300','-dpng','Bz_fft2.png');