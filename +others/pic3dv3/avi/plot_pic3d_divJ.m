%% plot the current continuity equation
% writen by Liangjin Song on 20201103
%%
clear;
indir='E:\PIC\Current\two-stream\data';
outdir='E:\PIC\Current\two-stream\out';
aviname=[outdir,'\divJ.avi'];

tt=0:500;

nx=64;
ny=1;
nz=1;

xrange=[1,nx];
yrange=[-1e-6,1e-6];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);

for t=1:nt
    cd(indir)
    divj=pic3d_read_data('divJ',tt(t),nx,ny,nz);
    plot(1:nx,divj,'r');
    xlabel('X');
    ylabel('\nabla \cdot J + \partial \rho/\partial t');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),'     \nabla \cdot J + \partial \rho/\partial t']);
    set(gca,'FontSize',16);
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);