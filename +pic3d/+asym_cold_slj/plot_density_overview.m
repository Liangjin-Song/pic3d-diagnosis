% function plot_density_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

%% variable information
name='Nh';
tt=40;
norm=prm.value.nhm;

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
% extra.title=['Nic, \Omega_{ci}t=',num2str(tt)];
% extra.xrange=[40,52];
% extra.yrange=[-5,5];
% extra.caxis=[0,1.5];

nt=length(tt);
for t = 1:nt
    %% read data
    N=prm.read(name,tt(t));
    ss=prm.read('stream',tt(t));
    Ns = N.value./N.value;
    N = N.value + Ns - 1;
    %% figure
    figure;
    slj.Plot.overview(N,ss,prm.value.lx,prm.value.lz,norm,extra);
    title(['Nic, \Omega_{ci}t = ',num2str(tt(t))]);
    % f.png(prm,[name,'_t',num2str(tt),'_range'])
    cd(outdir);
%     print('-dpng','-r300',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(gcf);
end