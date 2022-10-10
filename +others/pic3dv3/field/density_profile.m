indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\';
nx=4000;
ny=2000;
nz=1;
di=40;

Lx=nx/di;
Ly=ny/di;

tt=31;
z0=0;

norm=384.620087;
cd(indir);

xrange=[30,45];

ylab='plasma density';

% set font size of axis label
fontsize=16;
% set line width
linewidth=2;
% set figures position
position=[100,100,900,700];


ni=pic3d_read_data('Nl',tt,nx,ny,nz);
nic=pic3d_read_data('Nh',tt,nx,ny,nz);
ne=pic3d_read_data('Ne',tt,nx,ny,nz);
nice=pic3d_read_data('Nhe',tt,nx,ny,nz);
b=pic3d_read_data('B',tt,nx,ny,nz);

[lbz,lx]=get_line_data(b.z,Lx,Ly,z0,1,0);
[lne,~]=get_line_data(ne,Lx,Ly,z0,norm,0);
[lni,~]=get_line_data(ni,Lx,Ly,z0,norm,0);
[lnic,~]=get_line_data(nic,Lx,Ly,z0,norm,0);
[lnice,~]=get_line_data(nice,Lx,Ly,z0,norm,0);
lne=lne+lnice;

[ax,h1,h2]=plotyy(lx,[lne;lni;lnic],lx,lbz);

% set axis
set(ax(1),'XColor','k','YColor','b','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);


% set label
set(get(ax(1),'Ylabel'),'String',ylab,'FontSize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

% set line
set(h1(1),'Color','k','LineWidth',linewidth);
set(h1(2),'Color','g','LineWidth',linewidth);
set(h1(3),'Color','b','LineWidth',linewidth);
set(h2,'Color','r','LineWidth',linewidth);
legend([h2;h1],'B_z', 'Ne','Ni','Nic')

% set figure
set(gcf,'color','white','paperpositionmode','auto');
set(gca,'Position',[.11 .17 .75 .8]);
cd(outdir)




