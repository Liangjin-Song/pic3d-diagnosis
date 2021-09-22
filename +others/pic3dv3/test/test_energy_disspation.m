%% J dot (E + Ve x B)
indir='E:\PIC\Distribution\data';
outdir='E:\PIC\Distribution\out';
nx=500;
ny=300;
nz=1;
di=20;

tt=12;
z0=12.5;
dir=1;

Lx=nx/di;
Ly=ny/di;
norm=1;

%% read data
cd(indir)
J=pic3d_read_data('J',tt,nx,ny,nz);
E=pic3d_read_data('E',tt,nx,ny,nz);
Ve=pic3d_read_data('Ve',tt,nx,ny,nz);
B=pic3d_read_data('B',tt,nx,ny,nz);
ss=pic3d_read_data('stream',tt,nx,ny,nz);


%% calculation
Es.x=E.x+Ve.y.*B.z-Ve.z.*B.y;
Es.y=E.y+Ve.z.*B.x-Ve.x.*B.z;
Es.z=E.z+Ve.x.*B.y-Ve.y.*B.x;
js=J.x.*Es.x+J.y.*Es.y+J.z.*Es.z;

%% figure
h1=figure;
pic3d_plot_2D_base_field(js,Lx,Ly,norm); hold on
cr=caxis;
pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
caxis(cr);
title(['J \cdot (E + Ve x B), \Omega_{ci} t =',num2str(tt)]);
xlim(xrange);
ylim(yrange);
cd(outdir);
print(h1,'-dpng','-r300',['energy_disspation_t',num2str(tt,'%06.2f'),'.png']);

h2=figure;
[ljs,lx]=get_line_data(js,Lx,Ly,z0,1,dir);
plot(lx,ljs,'k','LineWidth',2);
xlabel('Z');
ylabel('J \cdot (E + Ve x B)');
cd(outdir);
print(h2,'-dpng','-r300',['energy_disspation_line_t',num2str(tt,'%06.2f'),'.png']);