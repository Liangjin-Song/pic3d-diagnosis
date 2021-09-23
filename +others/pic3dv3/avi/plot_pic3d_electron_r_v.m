%% plot the relationship between position rx and velocity vx
% writen by Liangjin Song on 20200203
%%
clear;
indir='E:\PIC\wave-particle';
outdir='E:\PIC\wave-particle';
aviname=[outdir,'\electron_velocity.avi'];

tt=0:50;

nx=200;
ny=1;
nz=1;

xrange=[0,nx];
yrange=[-0.5,0.5];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);
for t=1:nt
    cd(indir)
    % rx=read_pic(['position_e_t',num2str(tt(t),'%06.2f'),'.bsd']);
    % vx=read_pic(['velocity_e_t',num2str(tt(t),'%06.2f'),'.bsd']);
    % r=load(['position_e_t',num2str(tt(t),'%06.2f'),'.txt']);
    % v=load(['velocity_e_t',num2str(tt(t),'%06.2f'),'.txt']);
    prt=pic3d_read_data('Prte',t);
    % plot(rx(1:3200),vx(1:3200),'*r'); hold on
    % plot(rx(3201:6400),vx(3201:6400),'*g'); hold off
    plot(prt.rx,prt.vx,"*k");
    xlabel('X');
    ylabel('Vex');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t))]);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);