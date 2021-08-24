% function plot_electric_fft2()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the 2d Fourier Transform of electric field
%%
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\thermal\data';
outdir='E:\PIC\wave-particle\thermal\out';
prm=slj.Parameters(indir, outdir);
% time
tt=0.05:0.05:50;
%% figure style
extra=[];
%% the electric field as the function of the position and the time
nt=length(tt);
Ex=zeros(nt,prm.value.nx);
for t=1:nt
    %% read data
    E=prm.read('B',tt(t));
    Ex(t,:)=E.x;
end

%% the 2d fast Fourier Transform



% fft for both time and position
fw=1/0.05;
fk=prm.value.debye;
wk=slj.Wave(Ex,fk,fw);

[kk,ff]=meshgrid(wk.k,wk.w);
figure;
p=pcolor(kk,ff,wk.wk);
colorbar;
shading flat;
axis on;
p.FaceColor = 'interp';
colormap('jet');
xlabel('k [\lambda_D^{-1}]');
ylabel('\omega [\omega_{pe}]');
xlim([-0.02,0.02]);
ylim([0,0.0001]);
set(gca,'FontSize',14);

% w=0:0.00001:0.0001;
% k=w.^2/(prm.value.c*prm.value.c)-(prm.value.fpe.*prm.value.fpe.*w)./((w-prm.value.fce).*prm.value.c.*prm.value.c);
% k=sqrt(k);
% hold on
% plot(k,w,'--r');
cd(outdir);
print('-r300','-dpng','wk2.png');