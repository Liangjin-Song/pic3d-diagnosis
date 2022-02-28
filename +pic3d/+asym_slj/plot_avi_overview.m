% function avi_overview
%%
% @info: writen by Liangjin Song on 20210926
% @brief: plot the avi overview
%%
clear;
%% parameters
% input/output directory
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Overview\avi';
prm=slj.Parameters(indir,outdir);

tt=0:100;
name='Vh';
sname='Vicx';
norm=prm.value.vA;
extra.caxis=[-0.8,0.8];
aviname=[outdir,'\',sname,'.avi'];

%%
extra.xrange=[prm.value.lx(1),prm.value.lx(end)];
extra.yrange=[prm.value.lz(1),prm.value.lz(end)];
extra.xlabel='X [c/\omega_{pe}]';
extra.ylabel='Z [c/\omega_{pe}]';
lx=prm.value.lx;
ly=prm.value.lz;
aviobj=VideoWriter(aviname);
aviobj.FrameRate=10;
open(aviobj);
nt=length(tt);
figure;
for t=1:nt
    cd(indir);
    ss=prm.read('stream',tt(t));
    fd=prm.read(name,tt(t));
    fd=fd.x;
    slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
    title([sname,'   \Omega_{ci}t=',num2str(tt(t))]);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);