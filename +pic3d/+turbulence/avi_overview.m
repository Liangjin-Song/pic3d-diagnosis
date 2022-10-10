% function avi_overview
%%
% @info: writen by Liangjin Song on 20210926
% @brief: plot the avi overview
%%
clear;
%% parameters
% input/output directory
indir='E:\PIC\Turbulence\data';
outdir='E:\PIC\Turbulence\out\avi';
prm=slj.Parameters(indir,outdir);

tt=0:150;
name='Ne';
norm=prm.value.n0;
extra.caxis=[0,1.5];
aviname=[outdir,'\',name,'.avi'];

%%
extra.xrange=[prm.value.lx(1),prm.value.lx(end)];
extra.yrange=[prm.value.lz(1),prm.value.lz(end)];
extra.xlabel='X [c/\omega_{pe}]';
extra.ylabel='Z [c/\omega_{pe}]';
lx=prm.value.lx;
ly=prm.value.lz;
aviobj=VideoWriter(aviname);
open(aviobj);
nt=length(tt);
figure;
for t=1:nt
    cd(indir);
    fd=prm.read(name,tt(t));
    fd=fd.value;
    slj.Plot.field2d(fd/norm, lx, ly, extra);
    title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);