%% the overview of cold ions thermal energy
% writen by Liangjin Song on 20210319
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie25\data';
outdir='E:\PIC\Cold-Ions\mie25\out\Overview\Energy\thermal';
nx=1200;
ny=800;
nz=1;
di=20;

tt=0:50;

n0=1481.487305;
coeff=71111.390625;
norme=n0/coeff;
normi=5*n0/coeff;
normic=0.05*n0/coeff;

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
    Pi=pic3d_read_data('Pl',tt(t),nx,ny,nz);
    Pe=pic3d_read_data('Pe',tt(t),nx,ny,nz);
    Pic=pic3d_read_data('Ph',tt(t),nx,ny,nz);
    Pice=pic3d_read_data('Phe',tt(t),nx,ny,nz);
    %% calculation of thermal energy
    Ui=0.5*(Pi.xx+Pi.yy+Pi.zz);
    Ue=0.5*(Pe.xx+Pe.yy+Pe.zz);
    Uic=0.5*(Pic.xx+Pic.yy+Pic.zz);
    Uice=0.5*(Pice.xx+Pice.yy+Pice.zz);
    %% figure
    cd(outdir);
    % ions
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Ui,Lx,Ly,normi); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Ui, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Ui_t',num2str(tt(t)),'.png']);
    close(gcf);
    % electrons
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Ue,Lx,Ly,norme); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Ue, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Ue_t',num2str(tt(t)),'.png']);
    close(gcf);
    % cold ions
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Uic,Lx,Ly,normic); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Uic, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Uic_t',num2str(tt(t)),'.png']);
    close(gcf);
    % electrons associated with cold ions
    h1=figure;
    set(h1,'visible','off');
    pic3d_plot_2D_base_field(Uice,Lx,Ly,norme); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title(['Uice, \Omega_{ci}t =',num2str(tt(t))]);
    xlim(xrange);
    ylim(yrange);
    set(gca,'FontSize',14);
    print(h1,'-dpng','-r300',['Uice_t',num2str(tt(t)),'.png']);
    close(gcf);
end