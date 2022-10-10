%% plot time evolution of the ion bulk kinetic energy  at the reconnection front
% writen by Liangjin Song on 20190518 
%
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/line/kinetic/time/';
tt=0:97;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
me=0.001400;
q=-0.000105;
wci=0.003000;
nt=length(tt)-1;
z0=25;
c=0.6;
hx=40;
hz=40;
grids=1;

tfx=zeros(1,nt);
twe=zeros(1,nt);
twp=zeros(1,nt);
tcv=zeros(1,nt);
tot=zeros(1,nt);
pkt=zeros(1,nt);

for t=1:nt
    cd(indir);
    tp=tt(t);
    tn=tt(t+1);
    th=(tp+tn)/2;

    nh=read_data('Dense',th);
    vxh=read_data('vxe',th);
    vyh=read_data('vye',th);
    vzh=read_data('vze',th);

    nn=read_data('Dense',tn);
    vxn=read_data('vxe',tn);
    vyn=read_data('vye',tn);
    vzn=read_data('vze',tn);

    np=read_data('Dense',tp);
    vxp=read_data('vxe',tp);
    vyp=read_data('vye',tp);
    vzp=read_data('vze',tp);

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

    ph=read_data('prese',tt(t));

    %% bulk kinetic energy
    m=me;
    Kp=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    Kn=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);
    
    [~,fluxh,weh,wph,cvh]=calc_dt(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,bxh,byh,bzh,ph,grids);

    %% get a mean value of a ractangle
    [lbz,lx]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,inx]=max(lbz);
    inz=1500;

    [afx,~]=calc_submatrix_mean(fluxh,inx,inz,hx,hz);
    [awe,~]=calc_submatrix_mean(weh,inx,inz,hx,hz);
    [awp,~]=calc_submatrix_mean(wph,inx,inz,hx,hz);
    [acv,~]=calc_submatrix_mean(cvh,inx,inz,hx,hz);

    tfx(t)=afx;
    twe(t)=awe;
    twp(t)=awp;
    tcv(t)=acv;
    tot(t)=afx+awe+awp+acv;

    %% dK/dt
    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,inxp]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,inxn]=max(lbzn);

    [aKp,~]=calc_submatrix_mean(Kp,inxp,inz,hx,hz);
    [aKn,~]=calc_submatrix_mean(Kn,inxn,inz,hx,hz);
    pkt(t)=(aKn-aKp)*wci;
end
%
% plot figure
ptt=0.5:97;
plot(ptt,tot,'k','LineWidth',2); hold on
plot(ptt,twe,'r','LineWidth',2);
plot(ptt,twp,'g','LineWidth',2);
plot(ptt,tfx,'b','LineWidth',2);
plot(ptt,tcv,'c','LineWidth',2);
plot(ptt,pkt,'m','LineWidth',2);
legend('Total','Work by E field','Work by pressure','Flux','Convective','dKe/dt','Location','Best');
xlabel('\Omega t');
ylabel('dKe/dt at the RF');
set(gca,'FontSize',16);
cd(outdir);
