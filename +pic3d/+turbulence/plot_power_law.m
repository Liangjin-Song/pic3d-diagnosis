% function plot_power_law
%%
clear;
%%
indir='E:\Turbulence\9.2\data';
outdir='E:\Turbulence\9.2\out\power';
prm=slj.Parameters(indir,outdir);

tt=135;
name='B';
norm=1;

xrange=[-2,0.5];

dir=1;
x0=50;

%% video
cd(outdir);
v = VideoWriter("powerlaw_Bx.avi");
v.FrameRate = 10;
open(v);

%%
nt = length(tt);
for t = 1:nt
cd(indir);
%% read data
fd=prm.read(name,tt(t));
fd=slj.Scalar(fd.x);
S=fd.get_line2d(x0,dir,prm,norm);

fs=4;
n=length(S);
X=fft(S);
power = abs(X).^2/n;
f = (0:n-1)*(fs/n);
% figure;
% plot(f,power);

Y = fftshift(X);
fshift = (-n/2:n/2-1)*(fs/n);
powershift = abs(Y).^2/n;

% plot(log10(fshift),log10(abs(powershift).^2));
loglog(fshift, powershift, '-k', 'LineWidth', 1.5);
xlabel('k [de^{-1}]');
ylabel('PSD');

title(['\Omega_{ci}t=',num2str(tt(t), '%06.2f')]);
set(gca, 'FontSize', 14);
% xticks([-2 -1 0 1 2])
% xticklabels({'10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});
% 
% yticks(-20:2);
% yticklabels({'10^{-20}','10^{-19}','10^{-18}','10^{-17}','10^{-16}','10^{-15}','10^{-14}','10^{-13}','10^{-12}','10^{-11}','10^{-10}',...
%     '10^{-9}','10^{-8}','10^{-7}','10^{-6}','10^{-5}','10^{-4}','10^{-3}','10^{-2}','10^{-1}','10^{0}','10^{1}','10^{2}'});

%%
frame = getframe(gcf);
writeVideo(v,frame);

end
close(v);
% xlim(xrange);
cd(outdir);
% print('-dpng','-r300',['Bz_t',num2str(tt),'_z',num2str(x0),'.png']);