%% analysis of Je dot E, plot electric overview at the DF
% writen by Liangjin Song on 20200704
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);
norm=vA;

cd(indir);
ef=read_data('Ez',tt);
ss=read_data('stream',tt);

plot_overview(ef,ss,norm,Lx,Ly);
caxis([-1.7,1.7]);
colormap(mycolormap());
xlim([90,120]);
ylim([0,30]);
set(gca,'FontSize',14);

cd(outdir);
