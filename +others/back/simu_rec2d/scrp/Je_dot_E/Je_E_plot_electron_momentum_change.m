%% analysis of Je dot E, plot electron partial(nv/t)
% writen by Liangjin Song on 20200705
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);

norm=1;

%% read data
cd(indir);
n=read_data('Dense',tt);
vx=read_data('vxe',tt);
vy=read_data('vye',tt);
vz=read_data('vze',tt);

p=read_data('prese',tt);

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
np=read_data('Dense',tp);
vxp=read_data('vxe',tp);
vyp=read_data('vye',tp);
vzp=read_data('vze',tp);

% next
tn=tt+dt;
nn=read_data('Dense',tn);
vxn=read_data('vxe',tn);
vyn=read_data('vye',tn);
vzn=read_data('vze',tn);

%% partial nv / partial t
pnv.x=(nn.*vxn-np.*vxp)*wci;
pnv.y=(nn.*vyn-np.*vyp)*wci;
pnv.z=(nn.*vzn-np.*vzp)*wci;

%% RHS
[acl, dip, nvv]=calc_momentum_partial_nv_t(qe,me,n,ex,ey,ez,vx,vy,vz,bx,by,bz,p,grids);

%% line
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
nzero=zeros(1,length(lx));

pnv=qe*mean(pnv.x(zd0-shift:zd0+shift,:),1)/norm;
acl=qe*mean(acl.x(zd0-shift:zd0+shift,:),1)/norm;
dip=qe*mean(dip.x(zd0-shift:zd0+shift,:),1)/norm;
nvv=qe*mean(nvv.x(zd0-shift:zd0+shift,:),1)/norm;
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
set(get(ax(1),'Ylabel'),'String','\partial J_e/\partial t','Fontsize',fontsize);
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
set(gca,'Position',[.15 .16 .7 .75]);
% set legend
l=legend('\partial J_e/\partial t','q_e^2n_e(E+v_e\times B)/m_e','-q_e(\nabla \cdot P_e)/m_e','-q_e\nabla \cdot (n_ev_ev_e)','Sum');
set(l,'Fontsize',fontsize,'Box','off');
set(gca,'Position',[.15 .16 .7 .8]);

cd(outdir);
