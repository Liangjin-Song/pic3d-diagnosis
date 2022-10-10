% function plot_electric_fft2()
%%
% @info: writen by Liangjin Song on 20210607
% @brief: plot the 2d Fourier Transform of electric field
%%
clear;
%% parameters
% directory
indir='E:\Simulation\Cold\Data';
outdir='E:\Simulation\Cold\Out\Line';
prm=slj.Parameters(indir, outdir);
% time
tt=0:0.1:40;
%% figure style
extra=[];
%% data smooth
nn = 10;
%% line
dir=1;
x0=50;
norm=prm.value.vA;
%% the electric field as the function of the position and the time
nt=length(tt);
EE=zeros(nt,prm.value.nz-6);
for t=1:nt
    %% read data
    fd=prm.read('E',tt(t));
    fd=slj.Scalar(fd.y);
    fd=fd.get_line2d(x0,dir,prm,norm);
    fd=fd(4:end-3);
%     fd=smoothdata(fd,'gaussian',nn);
    EE(t, :) = fd;
end

%% the 2d fast Fourier Transform fft for both time and position
F=fftshift(fft2(EE));
F = abs(F).^2/(size(F,1)*size(F,2));

% wave vector
ks=0.288675;
n=length(fd);
ks=linspace(-ks/2,ks/2, n);

% frequency
fs=prm.value.fpe/prm.value.wci;
fs=10*fs*prm.value.fpe;
fs=linspace(-fs/2, fs/2, nt)/(2*pi);

% figure
figure;
[X, Y] = meshgrid(ks, fs);
p = pcolor(X, Y, F);
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('k [\lambda_D^{-1}]');
ylabel('f [f_{pe}]');
% ylim([0,0.7]);
% xlim([-0.001, 0.001]);

% fw=0.05*prm.value.fce;
% fk=prm.value.debye;
% wk=slj.Wave(Ex,fk,fw);
% 
% [kk,ff]=meshgrid(wk.k,wk.w);
% figure;
% p=pcolor(kk,ff,wk.wk);
% colorbar;
% shading flat;
% axis on;
% p.FaceColor = 'interp';
% colormap('jet');
% xlabel('k [\lambda_D^{-1}]');
% ylabel('\omega [\omega_{pe}]');
% xlim([-40,40]);
% ylim([0,0.1]);
% set(gca,'FontSize',14);
% 
% ts=(prm.value.fpe*prm.value.debye)/prm.value.c;
% k=0.2*ts;
% mx=0:0.1:100;
% my=k*mx;
% hold on
% plot(mx,my,'--r','LineWidth',2);
