%% plot the J dot E
% writen by Liangjin Song on 20210318
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Poster';
nx=4000;
ny=2000;
nz=1;
di=40;

tt=31;

qi=0.0013;
n0=384.620087;
vA=0.0125;
norm=n0*vA*vA;

x0=0;
dir=0;

%%
Lx=nx/di;
Ly=ny/di;

% xrange=[0,Lx];
xrange=[30,70];
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
%     h=plot_energy_line(JiE,Lx,Ly,norm,'Ji \cdot E',tt(t),x0,dir,xrange,yrange);
%     print(h,'-r300','-dpng',['Ji_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(h);
%     h=plot_energy_line(JeE,Lx,Ly,norm,'Je \cdot E',tt(t),x0,dir,xrange,yrange);
%     print(h,'-r300','-dpng',['Je_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(h);
%     h=plot_energy_line(JicE,Lx,Ly,norm,'Jic \cdot E',tt(t),x0,dir,xrange,yrange);
%     print(h,'-r300','-dpng',['Jic_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(h);
    h=plot_energy_line(JiceE,Lx,Ly,norm,'Jice \cdot E',tt(t),x0,dir,xrange,yrange);
    print(h,'-r300','-dpng',['Jice_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(h);
%     h=plot_energy_line(JE,Lx,Ly,norm,'J \cdot E',tt(t),x0,dir,xrange,yrange);
%     print(h,'-r300','-dpng',['J_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(h)
%     h=plot_energy_line(J0E,Lx,Ly,norm*qi,'J \cdot E',tt(t),x0,dir,xrange,yrange);
%     print(h,'-r300','-dpng',['J0_dot_E_t',num2str(tt(t),'%06.2f'),'.png']);
%     close(h)
end

%% plot figure
function h=plot_energy_line(fd,Lx,Ly,norm,name,time,x0,direction,xrange,yrange)
    h=figure;
    [f,xy]=get_line_data(fd,Lx,Ly,x0,norm,direction);
    plot(xy,f,'k','LineWidth',1);
    title([name,', \Omega_{ci}t =',num2str(time)]);
    xlabel('X [c/\omega_{pi}]')
    xlim(xrange);
    % ylim(yrange);
    set(gca,'FontSize',14);
end