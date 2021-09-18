%% analysis of Electric field, plot Ohm law at the DF
% writen by Liangjin Song on 20200704
clear;
prmfile='E:\Simulation\rec2d_M100SBg00Sx\out\JeE\parm.m';
run(prmfile);
norm=vA;


cd(indir);
ohm=read_data('ohmx',tt);
bz=read_data('Bz',tt);
bz=bz/c;

ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dv=ohm(:,4);
dp=ohm(:,5);
%%
ef=reshape(ef,nx,ny);
ef=ef';
evbi=reshape(evbi,nx,ny);
evbi=evbi';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
dv=reshape(dv,nx,ny);
dv=dv';
dp=reshape(dp,nx,ny);
dp=dp';

evbe=evbe-evbi;

ef=simu_filter2d(ef);
evbi=simu_filter2d(evbi);
evbe=simu_filter2d(evbe);
dv=simu_filter2d(dv);
dp=simu_filter2d(dp);

% line 
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
[lef,~]=get_line_data(ef,Lx,Ly,z0,norm,0);
[levbi,~]=get_line_data(evbi,Lx,Ly,z0,norm,0);
[levbe,~]=get_line_data(evbe,Lx,Ly,z0,norm,0);
[ldv,~]=get_line_data(dv,Lx,Ly,z0,norm,0);
[ldp,~]=get_line_data(dp,Lx,Ly,z0,norm,0);

nn=length(lx);
nzero=zeros(1,nn);

% figures
[ax,h1,h2]=plotyy(lx,[lef;levbi;levbe;ldv;ldp;nzero],lx,lbz);
fontsize=14;
linewidth=2;

% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','Ez','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','k','LineWidth',linewidth);
set(h1(2),'Color','c','LineWidth',linewidth);
set(h1(3),'Color','g','LineWidth',linewidth);
set(h1(4),'Color','b','LineWidth',linewidth);
set(h1(5),'Color','m','LineWidth',linewidth);
set(h2,'Color','r','LineWidth',linewidth);
% set legend
hl=legend([h1(1:5);h2],'Electric field','Frozen-in term','Hall term','Pressure gradient term','Electron inertia term','Bz');
% set(hl,'Orientation','horizon');
set(gca,'Position',[.15 .16 .75 .8]);

cd(outdir);
