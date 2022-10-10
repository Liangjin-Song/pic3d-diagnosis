indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out';
nx=1200;
ny=800;
nz=1;
di=20;

Lx=nx/di;
Ly=ny/di;

tt=36;
tt0=0;
z0=0;

norm=1481.487305;
cd(indir);

xrange=[0,Lx];

ylab='Nic';

% set font size of axis label
fontsize=16;
% set line width
linewidth=2;
% set figures position
position=[100,100,900,700];

nic=pic3d_read_data('Nh',tt,nx,ny,nz);
nic0=pic3d_read_data('Nh',tt0,nx,ny,nz);
b=pic3d_read_data('B',tt,nx,ny,nz);

[lbz,lx]=get_line_data(b.z,Lx,Ly,z0,1,0);
[lnic,~]=get_line_data(nic,Lx,Ly,z0,norm,0);
[lnic0,~]=get_line_data(nic0,Lx,Ly,z0,norm,0);

[ax,h1,h2]=plotyy(lx,[lnic;lnic0],lx,lbz);

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
set(h1(2),'Color','b','LineWidth',linewidth);
set(h2,'Color','r','LineWidth',linewidth);
legend([h2;h1],'B_z', ['\Omega_{ci}t=',num2str(tt)],['\Omega_{ci}t=',num2str(tt0)])

% set figure
set(gcf,'color','white','paperpositionmode','auto');
set(gca,'Position',[.11 .17 .75 .8]);
cd(outdir)




