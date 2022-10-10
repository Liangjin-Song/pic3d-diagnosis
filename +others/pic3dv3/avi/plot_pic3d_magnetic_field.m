%% plot magnetic field
% writen by Liangjin Song on 20200221
%%
clear;
indir='E:\PIC\Current\thermal\data';
outdir='E:\PIC\Current\thermal\out';
aviname=[outdir,'\magnetic.avi'];

tt=0:500;

nx=300;
ny=1;
nz=1;

xrange=[1,nx];
yrange=[-2.5,2.5];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);

for t=1:nt
    cd(indir)
    b=pic3d_read_data('B',tt(t),nx,ny,nz);
    plot(1:nx,b.x,'r'); hold on
    plot(1:nx,b.y,'g');
    plot(1:nx,b.z,'b'); hold off
    xlabel('X');
    ylabel('B');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),'    Bx:red,  By:green,  Bz:blue']);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);