indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Analysis\Electron';
nx=2000;
ny=1000;
nz=1;
di=20;

mi=4.493999;
me=0.179760;
n0=800.003418;

vthi=0.016137;
vthic=0.001614;
vthe=0.036084;

% norm=0.5*n0*mi*vthi*vthi;
norm =1;
Lx=nx/di;
Ly=ny/di;

cd(indir);
b=pic3d_read_data('B',tt,nx,ny,nz);
P=pic3d_read_data('Ph',tt,nx,ny,nz);
ss=pic3d_read_data('stream',tt,nx,ny,nz);
U=0.5*(P.xx+P.yy+P.zz);

% pic3d_plot_2D_base_field(U,Lx,Ly,norm); hold on
% cr=caxis;
% pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
% caxis(cr);
% title(['U_{e}, \Omega_{ci}t =',num2str(tt)]);
% xlim(xrange);
% ylim(yrange);

[lbz,lx]=get_line_data(b.z,Lx,Ly,z0,1,0);
[lu,~]=get_line_data(U,Lx,Ly,z0,norm,0);
[ax,h1,h2]=plotyy(lx,lu,lx,lbz);
% set axis
set(ax(1),'XColor','k','YColor','b','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);


% set label
set(get(ax(1),'Ylabel'),'String','Uic','FontSize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

% set line
set(h1,'Color','b','LineWidth',linewidth);
set(h2,'Color','r','LineWidth',linewidth);

% set figure
set(gcf,'color','white','paperpositionmode','auto');
set(gca,'Position',[.11 .17 .75 .8]);
cd(outdir);