indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Global';
nx=4000;
ny=2000;
nz=1;
di=40;

Lx=nx/di;
Ly=ny/di;

tt=31;
z0=45.6;
dir=1;

norm=1;
cd(indir);

xrange=[-20,20];

ylab='Vic';

% set font size of axis label
fontsize=16;
% set line width
linewidth=2;
% set figures position
position=[100,100,900,700];


Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
b=pic3d_read_data('B',tt,nx,ny,nz);

[lbz,lx]=get_line_data(b.z,Lx,Ly,z0,1,dir);
[lbx,lx]=get_line_data(b.x,Lx,Ly,z0,1,dir);
[lvx,~]=get_line_data(Vic.x,Lx,Ly,z0,1,dir);
[lvy,~]=get_line_data(Vic.y,Lx,Ly,z0,1,dir);
[lvz,~]=get_line_data(Vic.z,Lx,Ly,z0,1,dir);


[ax,h1,h2]=plotyy(lx',[lvx;lvy;lvz],lx',lbz);

% set axis
set(ax(1),'XColor','k','YColor','b','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
% set(ax,'XLim',xrange);


% set label
set(get(ax(1),'Ylabel'),'String',ylab,'FontSize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

% set line
set(h1(1),'Color','k','LineWidth',linewidth);
set(h1(2),'Color','b','LineWidth',linewidth);
set(h1(3),'Color','m','LineWidth',linewidth);
set(h2,'Color','r','LineWidth',linewidth);
legend([h2;h1],'B_z', 'Vicx','Vicy','Vicz')

% set figure
set(gcf,'color','white','paperpositionmode','auto');
set(gca,'Position',[.11 .17 .75 .8]);
cd(outdir)




