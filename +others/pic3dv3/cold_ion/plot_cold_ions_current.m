%% plot the J dot E
% writen by Liangjin Song on 20210318
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out\Overview\J';
nx=1200;
ny=800;
nz=1;
di=20;

tt=0:50;

qi=0.000337;
n0=1481.487305;
vA=0.025;
norm=n0*vA;

%%
Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
nt=length(tt);

for t=1:nt
    %% read data
    cd(indir);
    Ni=pic3d_read_data('Nl',tt(t),nx,ny,nz);
    Nic=pic3d_read_data('Nh',tt(t),nx,ny,nz);
    Ne=pic3d_read_data('Ne',tt(t),nx,ny,nz);
    Nice=pic3d_read_data('Nhe',tt(t),nx,ny,nz);
    Vi=pic3d_read_data('Vl',tt(t),nx,ny,nz);
    Vic=pic3d_read_data('Vh',tt(t),nx,ny,nz);
    Ve=pic3d_read_data('Ve',tt(t),nx,ny,nz);
    Vice=pic3d_read_data('Vhe',tt(t),nx,ny,nz);
    ss=pic3d_read_data('stream',tt(t),nx,ny,nz);
    E=pic3d_read_data('E',tt(t),nx,ny,nz);
    J=pic3d_read_data('J',tt(t),nx,ny,nz);
    %% current density
    Ji.x=Ni.*Vi.x;
    Ji.y=Ni.*Vi.y;
    Ji.z=Ni.*Vi.z;
    Je.x=-Ne.*Ve.x;
    Je.y=-Ne.*Ve.y;
    Je.z=-Ne.*Ve.z;
    Jic.x=Nic.*Vic.x;
    Jic.y=Nic.*Vic.y;
    Jic.z=Nic.*Vic.z;
    Jice.x=-Nice.*Vice.x;
    Jice.y=-Nice.*Vice.y;
    Jice.z=-Nice.*Vice.z;
    %% plot figure
    cd(outdir);
    name='Ji';
    h1=plot_overview(Ji.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
    h2=plot_overview(Ji.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
    h3=plot_overview(Ji.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
    print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h1);
    close(h2);
    close(h3);
    name='Je';
    h1=plot_overview(Je.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
    h2=plot_overview(Je.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
    h3=plot_overview(Je.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
    print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h1);
    close(h2);
    close(h3);
    name='Jic';
    h1=plot_overview(Jic.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
    h2=plot_overview(Jic.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
    h3=plot_overview(Jic.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
    print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h1);
    close(h2);
    close(h3);
    name='Jice';
    h1=plot_overview(Jice.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
    h2=plot_overview(Jice.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
    h3=plot_overview(Jice.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
    print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
    print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h1);
    close(h2);
    close(h3);
end

%% plot figure
function h=plot_overview(fd,ss,Lx,Ly,norm,name,time,xrange,yrange)
    h=figure;
    pic3d_plot_2D_base_field(fd,Lx,Ly,norm); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title([name,', \Omega_{ci}t =',num2str(time)]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
end