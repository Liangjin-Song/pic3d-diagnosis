%% writen by Liangjin on 20210112
% plot particles trajectory
%%
clear;
%% parameter
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out\trajectory\path';
nx=1200;
ny=800;
nz=1;
di=20;
tt=29;
name='cold_ions_id.txt';
Lx=nx/di;
Ly=ny/di;
%% particles
cd(indir);
prt=textread(name,'%s');
np=length(prt);
%% trajectory
for i=1:1
    cd(indir);
    % name=char(prt(i));
    name='trajh_id289762885.dat';
    tj=load(name);
    fd=pic3d_read_data('B',tt,nx,ny,nz);
    fd=fd.x;
    ss=pic3d_read_data('stream',tt,nx,ny,nz);
    %% overview
    h=figure;
    pic3d_plot_2D_base_field(fd,Lx,Ly,1); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold on
    caxis(cr);
    %% trajectory
    xx=0:Lx/nx:Lx-Lx/nx;
    yy=-Ly/2:Ly/ny:Ly/2-Ly/ny;
    px=xx(floor(tj(:,2)+1));
    py=yy(floor(tj(:,3)+1));
%     arrowPlot(px,py);
    arrowPlot(px(1:216),py(1:216),'number',3); hold on
    arrowPlot(px(217:end),py(217:end),'number',3); hold on
    %%
    cd(outdir)
    print(h,'-r300','-dpng',[name(1:end-4),'_Bx_t',num2str(tt,'%06.2f'),'_path.png']);
    close(h);
end
