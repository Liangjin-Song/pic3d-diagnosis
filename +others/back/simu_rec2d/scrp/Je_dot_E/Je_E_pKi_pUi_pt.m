%% analysis of Je dot E, plot ion partial(K/t)+partial(U/t)
% writen by Liangjin Song on 20200704
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);

% norm=0.5*mi*n0*vthi*vthi;
norm=1;

tp=tt-dt;
tn=tt+dt;

%% load electron data
cd(indir);
bz=read_data('Bz',tt);
bz=bz/c;

n=read_data('Densi',tt);
vx=read_data('vxi',tt);
vy=read_data('vyi',tt);
vz=read_data('vzi',tt);

ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

p=read_data('presi',tt);
q=read_data('qfluxi',tt);

nn=read_data('Densi',tn);
vxn=read_data('vxi',tn);
vyn=read_data('vyi',tn);
vzn=read_data('vzi',tn);

np=read_data('Densi',tp);
vxp=read_data('vxi',tp);
vyp=read_data('vyi',tp);
vzp=read_data('vzi',tp);

pn=read_data('presi',tn);
pp=read_data('presi',tp);

%% kinetic energy and thermal energy change
% kinetic energy
Kp=calc_bulk_kinetic_energy(mi,np,vxp,vyp,vzp);
Kn=calc_bulk_kinetic_energy(mi,nn,vxn,vyn,vzn);
pK=(Kn-Kp)*wci;

% thermal energy
[pxxp,~,~,pyyp,~,pzzp]=reshap_pressure(pp,ny,nx);
Up=calc_thermal_energy(pxxp,pyyp,pzzp);
[pxxn,~,~,pyyn,~,pzzn]=reshap_pressure(pn,ny,nx);
Un=calc_thermal_energy(pxxn,pyyn,pzzn);
pU=(Un-Up)*wci;

%% space change
% qnv dot E
we=qi.*n.*(vx.*ex+vy.*ey+vz.*ez);

% -nabla dot (Kv)
K=calc_bulk_kinetic_energy(mi,n,vx,vy,vz);
kv=-calc_divergence(K.*vx,K.*vy,K.*vz,grids);

% -nabla dot q
[qx,qy,qz]=reshape_qflux(q,ny,nx);
dq=-calc_divergence(qx,qy,qz,grids);

% -nabla dot (Uv+P dot v)
[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ny,nx);
U=calc_thermal_energy(pxx,pyy,pzz);
dh=calc_thermal_enthalpy_flux(U,vx,vy,vz,pxx,pxy,pxz,pyy,pyz,pzz,grids);

%% get the line
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
nzero=zeros(1,length(lx));
 
pU=mean(pU(zd0-shift:zd0+shift,:),1)/norm;
pK=mean(pK(zd0-shift:zd0+shift,:),1)/norm;

we=mean(we(zd0-shift:zd0+shift,:),1)/norm;
kv=mean(kv(zd0-shift:zd0+shift,:),1)/norm;
dq=mean(dq(zd0-shift:zd0+shift,:),1)/norm;
dh=mean(dh(zd0-shift:zd0+shift,:),1)/norm;

suml=pU+pK;
sumr=we+kv+dq+dh;

%% figure
fontsize=14;
linewidth=2;

% the sum of both side
f1=figure;
[ax,h1,h2]=plotyy(lx,[suml;sumr;nzero],lx,lbz);
% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','Energy Change','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','k','LineStyle','-','LineWidth',linewidth);
set(h1(2),'Color','k','LineStyle','--','LineWidth',linewidth);
set(h1(3),'Color','m','LineStyle','--','LineWidth',linewidth);
set(h2,'Color','r','LineStyle','-','LineWidth',linewidth);
set(gca,'Position',[.15 .16 .7 .75]);
% set legend
hl=legend([h1(1:2);h2],'LHS','RHS','Bz');
% set(hl,'Orientation','horizon');
set(gca,'Position',[.15 .16 .7 .8]);

% each term
f2=figure;
[ax,h1,h2]=plotyy(lx,[pK;pU;we;kv;dq;dh;nzero],lx,lbz);
% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','Energy Change','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','k','LineStyle','-','LineWidth',linewidth);
set(h1(2),'Color','g','LineStyle','-','LineWidth',linewidth);
set(h1(3),'Color','b','LineStyle','-','LineWidth',linewidth);
set(h1(4),'Color','c','LineStyle','-','LineWidth',linewidth);
set(h1(5),'Color','k','LineStyle','--','LineWidth',linewidth);
set(h1(6),'Color','b','LineStyle','--','LineWidth',linewidth);
set(h1(7),'Color','m','LineStyle','--','LineWidth',linewidth);
set(h2,'Color','r','LineStyle','-','LineWidth',linewidth);
set(gca,'Position',[.12 .16 .75 .75]);
% set legend
l1=legend(h1(1:3),'\partial Ki/\partial t','\partial Ui/\partial t','q_in_iV_i \cdot E');
set(l1,'Fontsize',fontsize,'Box','off');
ah=axes('position',get(gca,'position'),...
            'visible','off');
l2=legend(ah,[h1(4:6);h2],'-\nabla \cdot (K_iV_i)','-\nabla \cdot Q_i','-\nabla\cdot (U_iV_i+P_i\cdot V_i)','Bz');
set(l2,'Fontsize',fontsize,'Box','off');


cd(outdir);
