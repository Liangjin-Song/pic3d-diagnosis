%% plot the J dot E
% writen by Liangjin Song on 20210318
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\Energy\';
nx=4000;
ny=2000;
nz=1;
di=40;

tt=27;

qi=0.0013;
n0=384.620087;
vA=0.0125;
norm=n0*vA*vA;

%%
Lx=nx/di;
Ly=ny/di;

xrange=[30,70];
yrange=[-10,10];
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
    %% energy conversion
    JiE=Ni.*(Vi.x.*E.x+Vi.y.*E.y+Vi.z.*E.z);
    JeE=-Ne.*(Ve.x.*E.x+Ve.y.*E.y+Ve.z.*E.z);
    JicE=Nic.*(Vic.x.*E.x+Vic.y.*E.y+Vic.z.*E.z);
    JiceE=-Nice.*(Vice.x.*E.x+Vice.y.*E.y+Vice.z.*E.z);
    JE=JiE+JeE+JicE+JiceE;
    J0E=J.x.*E.x+J.y.*E.y+J.z.*E.z;
    %% plot figure
    cd(outdir);
    h=plot_overview(JiE,ss,Lx,Ly,norm,'Ji \cdot E',tt(t),xrange,yrange);
    print(h,'-r300','-dpng',['Ji_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h);
    h=plot_overview(JeE,ss,Lx,Ly,norm,'Je \cdot E',tt(t),xrange,yrange);
    print(h,'-r300','-dpng',['Je_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h);
    h=plot_overview(JicE,ss,Lx,Ly,norm,'Jic \cdot E',tt(t),xrange,yrange);
    print(h,'-r300','-dpng',['Jic_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h);
    h=plot_overview(JiceE,ss,Lx,Ly,norm,'Jice \cdot E',tt(t),xrange,yrange);
    print(h,'-r300','-dpng',['Jice_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h);
    h=plot_overview(JE,ss,Lx,Ly,norm,'J \cdot E',tt(t),xrange,yrange);
    print(h,'-r300','-dpng',['J_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h)
    h=plot_overview(J0E,ss,Lx,Ly,norm*qi,'J \cdot E',tt(t),xrange,yrange);
    print(h,'-r300','-dpng',['J0_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
    close(h)
end

%% plot figure
function h=plot_overview(fd,ss,Lx,Ly,norm,name,time,xrange,yrange)
    h=figure;
    set(h,'Visible','off');
    pic3d_plot_2D_base_field(fd,Lx,Ly,norm); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title([name,', \Omega_{ci}t =',num2str(time)]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
end