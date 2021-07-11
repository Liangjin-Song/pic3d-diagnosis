% function plot_distribution_function_as_vx_rx_avi()
%%
% @info: writen by Liangjin Song on 20210607 
% @brief: plot the distribution function as the function of vx and rx
%%
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\data';
outdir='E:\PIC\wave-particle\out';
prm=slj.Parameters(indir, outdir);

% the distribution function data
cd(indir);
ndst=load('distribution_function.txt');

% the figure properties
extra.colormap='moon';
extra.xlabel='X [\lambda_D]';
extra.ylabel='Ve_x [V_A]';
extra.yrange=[-40,40];

% avi
aviname=[outdir,'\distribution.avi'];
aviobj=VideoWriter(aviname);
aviobj.FrameRate=5;
open(aviobj);
%%
nt=size(ndst,1);
for i=1:151
    tt=ndst(i,1);
    name=['PVe_ts',num2str(tt),'_x0-1800_y0-1_z0-1'];
    spc=prm.read(name);
    dst=spc.dstrv(1,1,prm.value.vA,prm.value.nx);
    slj.Plot.field2d(dst.value, dst.ll.lr, dst.ll.lv,extra);
    title(['\Omega_{ce}t=',num2str(round(tt*prm.value.w))]);
    set(gca,'FontSize',16);
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);