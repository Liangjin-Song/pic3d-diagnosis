%% analysis of Je dot E, plot electron partial(nv/t)
% writen by Liangjin Song on 20200705
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);
norm=1;

%% read data
cd(indir);
n=read_data('Densi',tt);
vx=read_data('vxi',tt);
vy=read_data('vyi',tt);
vz=read_data('vzi',tt);

p=read_data('presi',tt);

ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

bx=read_data('Bx',tt);
bx=bx/c;
by=read_data('By',tt);
by=by/c;
bz=read_data('Bz',tt);
bz=bz/c;

% previous
tp=tt-dt;
np=read_data('Densi',tp);
vxp=read_data('vxi',tp);
vyp=read_data('vyi',tp);
vzp=read_data('vzi',tp);

% next
tn=tt+dt;
nn=read_data('Densi',tn);
vxn=read_data('vxi',tn);
vyn=read_data('vyi',tn);
vzn=read_data('vzi',tn);

%% partial nv / partial t
pnv.x=(nn.*vxn-np.*vxp)*wci;
pnv.y=(nn.*vyn-np.*vyp)*wci;
pnv.z=(nn.*vzn-np.*vzp)*wci;

%% RHS
[acl, dip, nvv]=calc_momentum_partial_nv_t(qi,mi,n,ex,ey,ez,vx,vy,vz,bx,by,bz,p,grids);

%% line
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
nzero=zeros(1,length(lx));

pnv=qi*mean(pnv.z(zd0-shift:zd0+shift,:),1)/norm;
acl=qi*mean(acl.z(zd0-shift:zd0+shift,:),1)/norm;
dip=qi*mean(dip.z(zd0-shift:zd0+shift,:),1)/norm;
nvv=qi*mean(nvv.z(zd0-shift:zd0+shift,:),1)/norm;
tot=acl+dip+nvv;

%% figure
fontsize=14;
linewidth=2;

[ax,h1,h2]=plotyy(lx,[pnv;acl;dip;nvv;tot;nzero],lx,lbz);
% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','\partial J_i/\partial t','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','k','LineStyle','-','LineWidth',linewidth);
set(h1(2),'Color','g','LineStyle','-','LineWidth',linewidth);
set(h1(3),'Color','b','LineStyle','-','LineWidth',linewidth);
set(h1(4),'Color','c','LineStyle','-','LineWidth',linewidth);
set(h1(5),'Color','k','LineStyle','--','LineWidth',linewidth);
set(h1(6),'Color','m','LineStyle','--','LineWidth',linewidth);
set(h2,'Color','r','LineStyle','-','LineWidth',linewidth);
% set legend
l=legend('\partial J_i/\partial t','q_i^2n_i(E+v_i\times B)/m_i','-q_i(\nabla \cdot P_i)/m_i','-q_i\nabla \cdot (n_iv_iv_i)','Sum');
set(l,'Fontsize',fontsize,'Box','off');
set(gca,'Position',[.18 .16 .7 .8]);

cd(outdir);
