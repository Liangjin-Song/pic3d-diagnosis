%% plot divergence of magnetic field
% writen by Liangjin Song on 20201103
%%
clear;
indir='E:\PIC\Current\two-stream\data';
outdir='E:\PIC\Current\two-stream\out';
aviname=[outdir,'\divB.avi'];

tt=0:500;

nx=64;
ny=1;
nz=1;

xrange=[1,nx];
yrange=[-1e-5,1e-5];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);

for t=1:nt
    cd(indir)
    divb=pic3d_read_data('divB',tt(t),nx,ny,nz);
    plot(1:nx,divb,'r');
    xlabel('X');
    ylabel('\nabla \cdot B');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),' \nabla \cdot B']);
    set(gca,'FontSize',16);
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);