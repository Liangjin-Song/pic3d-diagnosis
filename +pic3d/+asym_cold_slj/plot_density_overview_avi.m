% function plot_density_overview()
%%
% plot the cold ions density overview
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Test';
prm=slj.Parameters(indir,outdir);

%% variable information
name='Nh';
sname='Nic';
tt=0:100;
norm=prm.value.nhm;

%% figure properties
extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.caxis=[0,1.5];
aviname=[outdir,'\',sname,'.avi'];
% extra.title=['Nic, \Omega_{ci}t=',num2str(tt)];
% extra.xrange=[40,52];
% extra.yrange=[-5,5];
% extra.caxis=[0,1.5];

aviobj=VideoWriter(aviname);
aviobj.FrameRate=5;
open(aviobj);

f=figure;

nt=length(tt);
for t = 1:nt
    %% read data
    N=prm.read(name,tt(t));
    ss=prm.read('stream',tt(t));
    Ns = N.value./N.value;
    N = N.value + Ns - 1;
    %% figure
    slj.Plot.overview(N,ss,prm.value.lx,prm.value.lz,norm,extra);
    title([sname,', \Omega_{ci}t = ',num2str(tt(t))]);
    hold off;
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);