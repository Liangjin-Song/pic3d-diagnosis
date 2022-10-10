%% plot time evolution of the ion bulk kinetic energy  at the reconnection front
% writen by Liangjin Song on 20190518 
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/dt/';
tt=25:0.5:60;
dt=0.5;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di;
Ly=ndy/di;
% ion
m=2.666618;
q=0.000667;
wci=0.000250;
nt=length(tt);
z0=12.5;
c=0.6;
grids=1;

y0=2250;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

tfx=zeros(1,nt);
twe=zeros(1,nt);
twp=zeros(1,nt);
tcv=zeros(1,nt);
tot=zeros(1,nt);
pkt=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tn=th+dt;
    tp=th-dt;

    nh=read_data('Densi',th);
    vxh=read_data('vxi',th);
    vyh=read_data('vyi',th);
    vzh=read_data('vzi',th);

    nn=read_data('Densi',tn);
    vxn=read_data('vxi',tn);
    vyn=read_data('vyi',tn);
    vzn=read_data('vzi',tn);

    np=read_data('Densi',tp);
    vxp=read_data('vxi',tp);
    vyp=read_data('vyi',tp);
    vzp=read_data('vzi',tp);

    bxh=read_data('Bx',th);
    bxh=bxh/c;
    byh=read_data('By',th);
    byh=byh/c;
    bzh=read_data('Bz',th);
    bzh=bzh/c;

    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    ph=read_data('presi',tt(t));

    %% bulk kinetic energy
    Kp=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    Kn=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);
    
    % [~,fluxh,weh,wph,cvh]=calc_dt(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,bxh,byh,bzh,ph,grids);
    [Kh,fluxh,weh,wph,cvh]=calc_kinetic_dK_dt_vRF_timing(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids,Lx,Ly,z0,bzp,bzn,wci,di);

    %% get a mean value of a ractangle
    [lbz,~]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    afx=get_sub_matrix(fluxh,x0,y0,top,bottom,left,right);
    awe=get_sub_matrix(weh,x0,y0,top,bottom,left,right);
    awp=get_sub_matrix(wph,x0,y0,top,bottom,left,right);
    acv=get_sub_matrix(cvh,x0,y0,top,bottom,left,right);

    tfx(t)=sum(sum(afx));
    twe(t)=sum(sum(awe));
    twp(t)=sum(sum(awp));
    tcv(t)=sum(sum(acv));
    tot(t)=sum(sum(afx+awe+awp+acv));

    %% dK/dt
    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    aKp=get_sub_matrix(Kp,x1,y0,top,bottom,left,right);
    aKn=get_sub_matrix(Kn,x2,y0,top,bottom,left,right);
    pkt(t)=sum(sum(aKn-aKp))*wci;
end
%}
% plot figure
figure;
plot(tt,tot,'k','LineWidth',2); hold on
plot(tt,twe,'r','LineWidth',2);
plot(tt,twp,'g','LineWidth',2);
plot(tt,tfx,'b','LineWidth',2);
plot(tt,tcv,'c','LineWidth',2);
plot(tt,pkt,'--k','LineWidth',2);
plot([0,100],[0,0],'--y','LineWidth',2); hold off
xlim([tt(1),tt(end)]);
legend('Total','-n_{i}q_{i}V_{i}\cdot E','-(\nabla\cdot P_{i})\cdot V_{i}','-\nabla\cdot(K_{i}V_{i})','V_{RF}\cdot\nabla K_{i}','dKi/dt','dKi/dt=0','Location','Best');
xlabel('\Omega t');
ylabel('dKi/dt');
cd(outdir);
