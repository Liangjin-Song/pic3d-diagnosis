%% plot the energy dissipation
%% writen by Liangjin Song on 20210411
%%
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Overview\Energy\';

nx=4000;
ny=2000;
nz=1;
di=40;
norm=0.0013*384.620087*0.0125*0.0125;

Lx=nx/di;
Ly=ny/di;
% xrange=[0,Lx];
% yrange=[-Ly/2,Ly/2];
xrange=[30,70];
yrange=[-10,10];

tt=31;
nt=length(tt);

%% the loop
for t=1:nt
    %% read data
    cd(indir);
    E=pic3d_read_data('E',tt(t),nx,ny,nz);
    B=pic3d_read_data('B',tt(t),nx,ny,nz);
    J=pic3d_read_data('J',tt(t),nx,ny,nz);
    Vi=pic3d_read_data('Vl',tt(t),nx,ny,nz);
    Vic=pic3d_read_data('Vh',tt(t),nx,ny,nz);
    Ve=pic3d_read_data('Ve',tt(t),nx,ny,nz);
    Vice=pic3d_read_data('Vhe',tt(t),nx,ny,nz);
    Ve.x=Ve.x+Vice.x;
    Ve.y=Ve.y+Vice.y;
    Ve.z=Ve.z+Vice.z;
    ss=pic3d_read_data('stream',tt(t),nx,ny,nz);
    
    %% J dot (Vic cross B)
    Vic=calc_cross(Vic, B);
    Vic=calc_add(E, Vic);
    Vic=J.x.*Vic.x+J.y.*Vic.y+J.z.*Vic.z;
    
    %% J dot (Vi cross B)
    Vi=calc_cross(Vi, B);
    Vi=calc_add(E, Vi);
    Vi=J.x.*Vi.x+J.y.*Vi.y+J.z.*Vi.z;
    
    %% J dot (Vi cross B)
    Ve=calc_cross(Ve, B);
    Ve=calc_add(E, Ve);
    Ve=J.x.*Ve.x+J.y.*Ve.y+J.z.*Ve.z;
    
    %% figure
    f1=figure;
    plot_overview(Vi,ss,norm,Lx,Ly);
    xlim(xrange);
    ylim(yrange);
    caxis([-0.5,0.5]);
    title(['J \cdot (E + Vi x B),\Omega_{ci}t=',num2str(tt(t))]);
    set(gca,'FontSize',16);
    %% save
    cd(outdir)
    print(f1, '-dpng','-r300',['ions_dissipation_t',num2str(tt(t),'%06.2f'),'.png']);
    close(f1);
    
    f2=figure;
    plot_overview(Vic,ss,norm,Lx,Ly);
    caxis([-0.5,0.5]);
    xlim(xrange);
    ylim(yrange);
    title(['J \cdot (E + Vic x B),\Omega_{ci}t=',num2str(tt(t))]);
    set(gca,'FontSize',16);
    %% save
    cd(outdir)
    print(f2, '-dpng','-r300',['cold_ions_dissipation_t',num2str(tt(t),'%06.2f'),'.png']);
    close(f2);
    
    f3=figure;
    plot_overview(Ve,ss,norm,Lx,Ly);
    caxis([-3,3]);
    xlim(xrange);
    ylim(yrange);
    title(['J \cdot (E + Ve x B),\Omega_{ci}t=',num2str(tt(t))]);
    set(gca,'FontSize',16);
    %% save
    cd(outdir)
    print(f3, '-dpng','-r300',['electrons_dissipation_t',num2str(tt(t),'%06.2f'),'.png']);
    close(f3);
end