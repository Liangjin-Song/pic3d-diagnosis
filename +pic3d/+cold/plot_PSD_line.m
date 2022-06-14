% function plot_power_law
%%
clear;
%%
indir='E:\Simulation\Cold\Data';
outdir='E:\Simulation\Cold\Out\Line';
prm=slj.Parameters(indir,outdir);

tt=16;
name='E';
norm=1;

xrange=[-2,0.5];

dir=1;
x0=50;

%% read data
fd=prm.read(name,tt);
fd=slj.Scalar(fd.y);
S=fd.get_line2d(x0,dir,prm,norm);
S=S(4:end-3);
nn = 10;
S=smoothdata(S,'gaussian',nn);

fs=0.288675;
n=length(S);
X=fft(S);
power = abs(X).^2/n;
f = (0:n-1)*(fs/n);
% figure;
% plot(f,power);

Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs/n);
powershift = abs(Y).^2/n;
figure;
loglog(fshift(floor(n/2+1):end), powershift(floor(n/2+1):end), '-k');
xlabel('k [\lambda_D^{-1}]');
ylabel('PSD');
title(['\Omega_{ci}t=',num2str(tt)])
set(gca,'FontSize', 12);

% xticks([-2 -1 0 1 2])
% xticklabels({'10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% 
% yticks(-20:2);
% yticklabels({'10^{-20}','10^{-19}','10^{-18}','10^{-17}','10^{-16}','10^{-15}','10^{-14}','10^{-13}','10^{-12}','10^{-11}','10^{-10}',...
%     '10^{-9}','10^{-8}','10^{-7}','10^{-6}','10^{-5}','10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});

% xlim(xrange);
cd(outdir);
% print('-dpng','-r300',['Ey_t',num2str(tt,'%06.2f'),'_x',num2str(x0),'_PSD.png']);