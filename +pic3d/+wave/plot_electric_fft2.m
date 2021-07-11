% function plot_electric_fft2()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the 2d Fourier Transform of electric field
%%
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\bistream\data5';
outdir='E:\PIC\wave-particle\bistream\out5';
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

%% the 2d fast Fourier Transform

%% method 2
% EF = fft2(Ex);
% EF=abs(EF);
% contourf(EF(1:round(nt/2),1:round(prm.value.nx/2)));

% %% method 3
% % fft for time
% % Sampling frequency
% Fs=1/0.05;
% % Sampling period
% T=1/Fs;
% % signal
% ex=Ex(:,100);
% % Length of signal
% L=length(ex);
% % fft
% Y=fft(ex);
% P2=abs(Y/L);
% P1=P2(1:round(L/2)+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:round(L/2))/L;
% figure;
% plot(f,P1,'k','LineWidth',2);
% xlabel('\omega [\omega_{ce}]');
% ylabel('|E|');
% set(gca,'FontSize',14);
% xlim([0,2]);
% cd(outdir);
% print('-dpng','-r300','fft_ex_time.png');
% 
% % fft for position
% % Sampling frequency
% Fs=1.324171;
% % Sampling period
% T=1/Fs;
% % signal
% ex=Ex(10,:);
% % Length of signal
% L=length(ex);
% % fft
% Y=fft(ex);
% P2=abs(Y/L);
% P1=P2(1:round(L/2)+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:round(L/2))/L;
% figure;
% plot(f,P1,'k','LineWidth',2);
% xlabel('k [\lambda_D^{-1}]');
% ylabel('|E|');
% set(gca,'FontSize',14);
% xlim([0,0.2]);
% cd(outdir);
% print('-dpng','-r300','fft_ex_position.png');

% fft for both time and position
fw=1/0.05;
fk=prm.value.debye;
wk=slj.Wave(Ex,fk,fw);

% Ex=Ex(2:end,:)';
% nt=size(Ex,2);
% nx=size(Ex,1);
% % EF = fft2(Ex)/(nx*nt);
% 
% % nplot=nx;
% % nx=nt;
% wk  = wkfft(Ex,nx,nt,nx,nt,0);
% wk  = [fliplr(wk(4:2:end,1:2:(end-1))'),wk(1:2:end,1:2:(end-1))'];
% wk=wk/prm.value.vA;
% 
% % wk = log10(wk);
% 
% 
% kmin = 2*pi/(nx*fk);
% kmax = kmin*(nx/2-1);
% k = [-kmax:kmin:-kmin,0,kmin:kmin:kmax];
% f = fw*(0:round(nt/2)-1)/nt;
[kk,ff]=meshgrid(wk.k,wk.w);

p=pcolor(kk,ff,wk.wk);
colorbar;
shading flat;
axis on;
p.FaceColor = 'interp';
colormap('jet');
xlabel('k [\lambda_D^{-1}]');
ylabel('\omega [\omega_{pe}]');
xlim([-0.05,0.05]);
ylim([0,0.001]);
set(gca,'FontSize',14);

ts=(prm.value.fpe*prm.value.debye)/prm.value.c;
k=0.25*ts;
mx=0:0.1:10;
my=k*mx;
hold on
plot(mx,my,'--r','LineWidth',2);
% cd(outdir);
% % hold on
% % plot([-kmax,kmax],[prm.value.fpi/prm.value.fpe,prm.value.fpi/prm.value.fpe],'-m','LineWidth',2);
% print('-dpng','-r300','fft2_ex_time_position.png');

%{
P2=abs(EF);
P1=P2(1:round(nt/2)+1,1:round(nx/2)+1);
P1(2:end-1,2:end-1)=2*P1(2:end-1,2:end-1)/prm.value.vA;
f = fw*(0:round(nt/2))/nt;
k = fk*(0:round(nx/2))/nx;
[ff,kk]=meshgrid(f,k);
figure;
contourf(kk,ff,P1','k');
p=pcolor(kk,ff,P1');
colorbar;
shading flat;
% axis on;
p.FaceColor = 'interp';
% colormap(slj.Plot.mycolormap(1));
colormap('jet');
caxis([0,1]);
xlim([0,0.04]);
ylim([0,1]);
xlabel('k [\lambda_D^{-1}]');
ylabel('\omega [\omega_{ce}]');
set(gca,'FontSize',14);
cd(outdir);

%% line fit
wk=load('kw.txt');
x=wk(:,1);
y=wk(:,2);
p=polyfit(x,y,1);
x1=[0;x;0.03];
y1=polyval(p,x1);
hold on
p0=plot(x1,y1,'-m','LineWidth',2);
m=prm.value.fpi/prm.value.fce;
p1=plot([0,1],[m,m],'--r','LineWidth',2);
m=prm.value.wci/prm.value.fce;
p2=plot([0,1],[m,m],'--g','LineWidth',2);
legend([p0,p1,p2],['k=',num2str(p(1))],'\omega_{pi}','\omega_{ci}');

%% 
print('-dpng','-r300','fft2_ex_time_position.png');

%% method 1
% wk=wk2d(Ex,1,1,prm.value.nx,1,nt-1,0);
  %}