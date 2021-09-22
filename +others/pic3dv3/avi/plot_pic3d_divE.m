%% plot divergence of electric field
% writen by Liangjin Song on 20201103
%%
clear;
indir='E:\PIC\two-stream\data';
outdir='E:\PIC\two-stream\out';
aviname=[outdir,'\divE.avi'];
qi=0.00025;

tt=0:100;

nx=200;
ny=1;
nz=1;

xrange=[1,nx];
yrange=[-1e-6,1e-6];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);

for t=1:nt
    cd(indir)
    dive=pic3d_read_data('divE',tt(t),nx,ny,nz);
    ni=pic3d_read_data('Ni',tt(t),nx,ny,nz)*qi;
    % plot(1:nx,dive,'r');
    plot(1:nx,dive./ni,'r');
    xlabel('X');
    ylabel('(\nabla \cdot E - \rho)/(qiNi)');
    % ylabel('\nabla \cdot E');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),'    (\nabla \cdot E - \rho)/(qiNi)']);
    % title(['t = ',num2str(tt(t)),'    \nabla \cdot E']);
    set(gca,'FontSize',16);
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);