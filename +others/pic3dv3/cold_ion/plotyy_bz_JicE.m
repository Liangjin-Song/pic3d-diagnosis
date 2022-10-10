indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\Energy';
nx=4000;
ny=2000;
nz=1;
di=40;

Lx=nx/di;
Ly=ny/di;

tt=16;
z0=0;
dir=0;

norm=384.620087*0.0125*0.0125;
cd(indir);

xrange=[40,60];

ylab='Jic \cdot E';

% set font size of axis label
fontsize=16;
% set line width
linewidth=2;
% set figures position
position=[100,100,900,700];


Vic=pic3d_read_data('Vh',tt,nx,ny,nz);
Nic=pic3d_read_data('Nh',tt,nx,ny,nz);
Jic.x=Nic.*Vic.x;
Jic.y=Nic.*Vic.y;
Jic.z=Nic.*Vic.z;
b=pic3d_read_data('B',tt,nx,ny,nz);
E=pic3d_read_data('E',tt,nx,ny,nz);

JicE=Jic.x.*E.x+Jic.y.*E.y+Jic.z.*E.z;

[lbz,lx]=get_line_data(b.z,Lx,Ly,z0,1,dir);
[ljice,~]=get_line_data(JicE,Lx,Ly,z0,1,dir);


[ax,h1,h2]=plotyy(lx,ljice/norm,lx,lbz);

% set axis
set(ax(1),'XColor','k','YColor','b','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);



% set label
set(get(ax(1),'Ylabel'),'String',ylab,'FontSize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

% set line
set(h1,'Color','k','LineWidth',linewidth);
set(h2,'Color','r','LineWidth',linewidth);
legend([h2;h1],'B_z', 'Jic \cdot E')

% set figure
set(gcf,'color','white','paperpositionmode','auto');
set(gca,'Position',[.15 .17 .7 .8]);
set(gca,'FontSize',16);
cd(outdir)




