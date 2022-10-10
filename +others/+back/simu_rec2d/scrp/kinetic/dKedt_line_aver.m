%% plot time evolution of the ion bulk kinetic energy  at the reconnection front
% writen by Liangjin Song on 20190518 
%
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/line/kinetic/electron/time/';
tt=50:100;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
me=0.001667;
q=-0.000125;
wci=0.000750;
nt=length(tt)-1;
z0=15;
c=0.6;
grids=1;

average=100;

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
    
    [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);
    %% convective, which is defined at half grids in x and z directions
    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    vrx=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,1);
    cvh=calc_convective(vrx,vxh,vyh,vzh,Kh,grids);

    %% get a mean value of a ractangle
    [lbzh,lx]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,in]=max(lbzh);

    [lfx,~]=get_line_data(fluxh,Lx,Ly,z0,1,0);
    [lwe,~]=get_line_data(weh,Lx,Ly,z0,1,0);
    [lwp,~]=get_line_data(wph,Lx,Ly,z0,1,0);
    [lcv,~]=get_line_data(cvh,Lx,Ly,z0,1,0);
    ltot=lfx+lwe+lwp+lcv;
    in=in-average/2;

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

    in1=in1-average/2;
    in2=in2-average/2;
    aKp=lKp(in1);
    aKn=lKn(in2);

    for n=1:average
        nn=in+n;
        nn1=in1+n;
        nn2=in2+n;
        if nn>ndx
            nn=nn-ndx;
        end
        if nn1>ndx
            nn1=nn1-ndx;
        end
        if nn2>ndx
            nn2=nn2-ndx;
        end
        afx=afx+lfx(nn);
        awe=awe+lwe(nn);
        awp=awp+lwp(nn);
        acv=acv+lcv(nn);
        atot=atot+ltot(nn);

        aKp=aKp+lKp(nn1);
        aKn=aKn+lKn(nn2);
    end

    tfx(t)=afx/(average+1);
    twe(t)=awe/(average+1);
    twp(t)=awp/(average+1);
    tcv(t)=acv/(average+1);
    tot(t)=atot/(average+1);

    %% dK/dt
    aKn=aKn/(average+1);
    aKp=aKp/(average+1);
    pkt(t)=(aKn-aKp)*wci;
end
%
% plot figure
ptt=50.5:100;
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
