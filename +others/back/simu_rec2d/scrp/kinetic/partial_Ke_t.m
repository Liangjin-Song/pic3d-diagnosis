%% plot time evolution of the electron bulk kinetic energy 
% writen by Liangjin Song on 20190519 
%
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/line/kinetic/electron/time/';
tt=60:100;
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
hx=4;
hz=4;
grids=1;


%% get a mean value of a ractangle
inx=3600;
inz=1800;


tfx=zeros(1,nt);
twe=zeros(1,nt);
twp=zeros(1,nt);
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

    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    ph=read_data('prese',tt(t));

    %% bulk kinetic energy
    m=me;
    Kp=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    Kn=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);

    %% filter
    nh=simu_filter2d(nh);
    vxh=simu_filter2d(vxh);
    vyh=simu_filter2d(vyh);
    vzh=simu_filter2d(vzh);
    exh=simu_filter2d(exh);
    eyh=simu_filter2d(eyh);
    ezh=simu_filter2d(ezh);
    ph=simu_filter2d(ph);

    [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);


    [afx,~]=calc_submatrix_mean(fluxh,inx,inz,hx,hz);
    [awe,~]=calc_submatrix_mean(weh,inx,inz,hx,hz);
    [awp,~]=calc_submatrix_mean(wph,inx,inz,hx,hz);
    % wce=0.075;
    aK=(Kn-Kp)*wci;
    [akt,~]=calc_submatrix_mean(aK,inx,inz,hx,hz);
 %   afx=fluxh(inz,inx);
 %   awe=weh(inz,inx);
 %   awp=wph(inz,inx);
 %   aK=(Kn-Kp)*wci;
 %   akt=aK(inz,inx);

    tfx(t)=afx;
    twe(t)=awe;
    twp(t)=awp;
    tot(t)=afx+awe+awp;
    pkt(t)=akt;
end
%}
% plot figure
ptt=60.5:100;
plot(ptt,tot,'k','LineWidth',2); hold on
plot(ptt,twe,'r','LineWidth',2);
plot(ptt,twp,'g','LineWidth',2);
plot(ptt,tfx,'b','LineWidth',2);
plot(ptt,pkt,'m','LineWidth',2);
legend('Total','Work by E field','Work by pressure','Flux','\partial Ke/\partial t','Location','Best');
xlabel('\Omega t');
ylabel('\partial Ke/\partial t near x-line');
set(gca,'FontSize',16);
cd(outdir);
