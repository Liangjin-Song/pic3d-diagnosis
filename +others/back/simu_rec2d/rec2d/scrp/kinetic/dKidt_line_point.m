%% plot time evolution of the ion bulk kinetic energy  at the reconnection front
% writen by Liangjin Song on 20190518 
%
clear;
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/out/line/kinetic/time/';
tt=50:97;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
mi=0.035000;
q=0.000105;
wci=0.003000;
nt=length(tt)-1;
z0=25;
c=0.6;
hx=40;
hz=40;
grids=1;

shift=10;

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
    m=mi;
    Kp=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    Kn=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);
    
    [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);
    %% convective, which is defined at half grids in x and z directions
    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    vrx=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
    cvh=calc_convective(vrx,vxh,vyh,vzh,Kh,grids);

    %% get a mean value of a ractangle
    [lbzh,lx]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,in]=max(lbzh);
    in=in+shift;

    [lfx,~]=get_line_data(fluxh,Lx,Ly,z0,1,0);
    [lwe,~]=get_line_data(weh,Lx,Ly,z0,1,0);
    [lwp,~]=get_line_data(wph,Lx,Ly,z0,1,0);
    [lcv,~]=get_line_data(cvh,Lx,Ly,z0,1,0);
    ltot=lfx+lwe+lwp+lcv;

    afx=lfx(in);
    awe=lwe(in);
    awp=lwp(in);
    acv=lcv(in);
    atot=ltot(in);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,in1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,in2]=max(lbzn);
    [lKp,~]=get_line_data(Kp,Lx,Ly,z0,1,0);
    [lKn,~]=get_line_data(Kn,Lx,Ly,z0,1,0);
    in1=in1+shift;
    in2=in2+shift;
    aKp=lKp(in1);
    aKn=lKn(in2);

    tfx(t)=afx;
    twe(t)=awe;
    twp(t)=awp;
    tcv(t)=acv;
    tot(t)=atot;

    %% dK/dt
    aKn=aKn;
    aKp=aKp;
    pkt(t)=(aKn-aKp)*wci;
end
%
% plot figure
ptt=50.5:97;
plot(ptt,tot,'k','LineWidth',2); hold on
plot(ptt,twe,'r','LineWidth',2);
plot(ptt,twp,'g','LineWidth',2);
plot(ptt,tfx,'b','LineWidth',2);
plot(ptt,tcv,'c','LineWidth',2);
plot(ptt,pkt,'m','LineWidth',2);
legend('Total','Work by E field','Work by pressure','Flux','Convective','dKi/dt','Location','Best');
xlabel('\Omega t');
ylabel('dKi/dt at the RF');
set(gca,'FontSize',16);
cd(outdir);
