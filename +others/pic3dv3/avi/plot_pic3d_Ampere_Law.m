%% plot magnetic field
% writen by Liangjin Song on 20200221
%%
clear;
indir='E:\PIC\Current\two-stream\data';
outdir='E:\PIC\Current\two-stream\out';
aviname=[outdir,'\ampere.avi'];

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
    amp=pic3d_read_data('Amp',tt(t),nx,ny,nz);
    plot(1:nx,amp.x,'r'); hold on
    plot(1:nx,amp.y,'g');
    plot(1:nx,amp.z,'b'); hold off
    xlabel('X');
    ylabel('\partial E/\partial t + J -c^2(\nabla \times B)');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),'    x:red,  y:green,  z:blue']);
    set(gca,'FontSize',14);
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);