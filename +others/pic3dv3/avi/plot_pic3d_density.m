%% plot density
%%
clear;
indir='E:\PIC\Current\two-stream\data';
outdir='E:\PIC\Current\two-stream\out';
aviname=[outdir,'\density.avi'];

tt=0:500;

nx=64;
ny=1;
nz=1;

xrange=[1,nx];
yrange=[0,200];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);

for t=1:nt
    cd(indir)
    ni=pic3d_read_data('Ni',tt(t),nx,ny,nz);
    ne=pic3d_read_data('Ne',tt(t),nx,ny,nz);
    plot(1:64,ni,'k'); hold on
    plot(1:64,ne,'r'); hold off
    xlabel('X');
    ylabel('Density');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),'    Ni: black,  Ne: red']);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);