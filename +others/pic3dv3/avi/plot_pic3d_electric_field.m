%% plot electric field
% writen by Liangjin Song on 20200221
%%
clear;
indir='E:\PIC\wave-particle\data';
outdir='E:\PIC\wave-particle\out';
aviname=[outdir,'\electric.avi'];

tt=0:0.05:150;

nx=1800;
ny=1;
nz=1;
debye=1.589005;
ll=linspace(0,nx/debye,nx);

xrange=[0,nx/debye];
% yrange=[-2e-2,2e-2];
yrange=[-30,30];
vA=0.00625;
nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);
lw=1.5;

for t=1:nt
    cd(indir)
    e=pic3d_read_data('E',tt(t),nx,ny,nz);
    plot(ll,e.x/vA,'r','LineWidth',lw); hold on
    plot(ll,e.y/vA,'g','LineWidth',lw);
    plot(ll,e.z/vA,'b','LineWidth',lw); hold off
    xlabel('X [\lambda_D]');
    ylabel('E [v_AB_0]');
    xlim(xrange);
    ylim(yrange);
    title(['\Omega_{ce}t = ',num2str(tt(t),'%06.2f'),'    Ex:red,  Ey:green,  Ez:blue']);
    set(gca,'FontSize',14);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);