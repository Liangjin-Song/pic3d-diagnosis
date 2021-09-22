%% the overview of cold ions bulk kinetic energy
% writen by Liangjin Song on 20210319
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie25\data';
outdir='E:\PIC\Cold-Ions\mie25\out\Overview\Energy\bulk';
nx=1200;
ny=800;
nz=1;
di=20;

tt=0:50;

n0=1481.487305;
vA=0.025;
norm=n0*vA*vA;

Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];

%% loop
nt=length(tt);
for t=1:nt
    %% read data
    cd(indir);
    ss=pic3d_read_data('stream',tt(t),nx,ny,nz);
    % for ions
    Ni=pic3d_read_data('Nl',tt(t),nx,ny,nz);
    Vi=pic3d_read_data('Vl',tt(t),nx,ny,nz);
    % for electrons
    Ne=pic3d_read_data('Ne',tt(t),nx,ny,nz);
    Ve=pic3d_read_data('Ve',tt(t),nx,ny,nz);
    % for cold ions
    Nic=pic3d_read_data('Nh',tt(t),nx,ny,nz);
    Vic=pic3d_read_data('Vh',tt(t),nx,ny,nz);
    % for electrons associated with cold ions
    Nice=pic3d_read_data('Nhe',tt(t),nx,ny,nz);
    Vice=pic3d_read_data('Vhe',tt(t),nx,ny,nz);
    %% calculation of bulk kinetic energy
    Ki=Ni.*(Vi.x.^2+Vi.y.^2+Vi.z.^2);
    Ke=Ne.*(Ve.x.^2+Ve.y.^2+Ve.z.^2);
    Kic=Nic.*(Vic.x.^2+Vic.y.^2+Vic.z.^2);
    Kice=Nice.*(Vice.x.^2+Vice.y.^2+Vice.z.^2);
    %% figure
    cd(outdir);
    % ions
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Ki,Lx,Ly,norm); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Ki, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Ki_t',num2str(tt(t)),'.png']);
    close(gcf);
    % electrons
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Ke,Lx,Ly,norm); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Ke, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Ke_t',num2str(tt(t)),'.png']);
    close(gcf);
    % cold ions
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Kic,Lx,Ly,norm); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Kic, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Kic_t',num2str(tt(t)),'.png']);
    close(gcf);
    % electrons associated with cold ions
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Kice,Lx,Ly,norm); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Kice, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Kice_t',num2str(tt(t)),'.png']);
    close(gcf);
end