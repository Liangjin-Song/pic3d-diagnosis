% function plot_electric_fft2()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the 2d Fourier Transform of electric field
%%
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\bistream\data2';
outdir='E:\PIC\wave-particle\bistream\out2';
prm=slj.Parameters(indir, outdir);
% time
tt=50.05:0.05:100;
%% figure style
extra=[];
%% the electric field as the function of the position and the time
nt=length(tt);
Ex=zeros(nt,prm.value.nx);
for t=1:nt
    %% read data
    E=prm.read('E',tt(t));
    Ex(t,:)=E.x;
end

%% the 2d fast Fourier Transform fft for both time and position
fw=0.05*prm.value.fce;
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
xlim([-40,40]);
ylim([0,0.1]);
set(gca,'FontSize',14);

ts=(prm.value.fpe*prm.value.debye)/prm.value.c;
k=0.2*ts;
mx=0:0.1:100;
my=k*mx;
hold on
plot(mx,my,'--r','LineWidth',2);
