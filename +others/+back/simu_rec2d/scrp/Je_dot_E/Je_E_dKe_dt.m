%% analysis of Je dot E, plot electric kinetic energy change at the DF
% writen by Liangjin Song on 20200704
clear;
prmfile='/data/simulation/rec2d_M100SBg00Sx/out/JeE/parm.m';
run(prmfile);

norm=0.5*me*n0*vA*vA;

tp=tt-dt;
tn=tt+dt;

cd(indir);

ne=read_data('Dense',tt);
vex=read_data('vxe',tt);
vey=read_data('vye',tt);
vez=read_data('vze',tt);

nen=read_data('Dense',tn);
vexn=read_data('vxe',tn);
veyn=read_data('vye',tn);
vezn=read_data('vze',tn);

nep=read_data('Dense',tp);
vexp=read_data('vxe',tp);
veyp=read_data('vye',tp);
vezp=read_data('vze',tp);

bz=read_data('Bz',tt);
bz=bz/c;

ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

pe=read_data('prese',tt);

%% electron bulk kinetic energy
Kp=calc_bulk_kinetic_energy(me,nep,vexp,veyp,vezp);
% Kep=simu_filter2d(Kep);
Kn=calc_bulk_kinetic_energy(me,nen,vexn,veyn,vezn);
pK=(Kn-Kp)*wci;

[~,flux,we,wp]=calc_kinetic_partial_t(qe,me,ne,vex,vey,vez,ex,ey,ez,pe,grids);

%% line 
[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
[lpk,~]=get_line_data(pK,Lx,Ly,z0,1,0);
[lfl,~]=get_line_data(flux,Lx,Ly,z0,1,0);
[lwe,~]=get_line_data(we,Lx,Ly,z0,1,0);
[lwp,~]=get_line_data(wp,Lx,Ly,z0,1,0);
lpk=lpk/norm;
lfl=lfl/norm;
lwe=lwe/norm;
lwp=lwp/norm;
lsm=lfl+lwe+lwp;

nzero=zeros(1,length(lx));

% figure
[ax,h1,h2]=plotyy(lx,[lpk;lfl;lwe;lwp;lsm;nzero],lx,lbz);
fontsize=14;
linewidth=2;

% set y axes
set(ax(1),'XColor','k','YColor','k','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','\partial Ke/\partial t','Fontsize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','Fontsize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);
% set line
set(h1(1),'Color','k','LineStyle','-','LineWidth',linewidth);
set(h1(2),'Color','g','LineStyle','-','LineWidth',linewidth);
set(h1(3),'Color','b','LineStyle','-','LineWidth',linewidth);
set(h1(4),'Color','c','LineStyle','-','LineWidth',linewidth);
set(h1(5),'Color','k','LineStyle','--','LineWidth',1);
set(h1(6),'Color','m','LineStyle','--','LineWidth',1);
set(h2,'Color','r','LineStyle','-','LineWidth',linewidth);
% set legend
hl=legend([h1(1:5);h2],'\partial Ke/\partial t','-\nabla \cdot (K_eV_e)','q_en_ev_e\cdot E','-(\nabla \cdot P_e) \cdot V_e','Sum','Bz');
% set(hl,'Orientation','horizon');
set(gca,'Position',[.15 .16 .7 .8]);

cd(outdir);
