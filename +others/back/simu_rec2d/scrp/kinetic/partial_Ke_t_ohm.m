%% plot time evolution of the electron bulk kinetic energy 
% writen by Liangjin Song on 20190519 
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
me=0.001400;
q=-0.000105;
wci=0.003000;
nt=length(tt)-1;
z0=25;
c=0.6;
hx=1500;
hz=400;
grids=1;

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

    ohmx=read_data('ohmx',tt(t));
    ohmy=read_data('ohmy',tt(t));
    ohmz=read_data('ohmz',tt(t));

    %% bulk kinetic energy
    m=me;
    Kp=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    Kn=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);

    [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);

    %% ohm law calculate the divergence of electron pressure
    Px=ohmx(:,4);
    Px=reshape(Px,ndx,ndy);
    Px=Px';

    Py=ohmy(:,4);
    Py=reshape(Py,ndx,ndy);
    Py=Py';

    Pz=ohmz(:,4);
    Pz=reshape(Pz,ndx,ndy);
    Pz=Pz';

    wph=vxh.*Px+vyh.*Py+vzh.*Pz;
    wph=-wph.*(nh*q);

    %% get a mean value of a ractangle
    inx=3000;
    inz=1500;

    [afx,~]=calc_submatrix_mean(fluxh,inx,inz,hx,hz);
    [awe,~]=calc_submatrix_mean(weh,inx,inz,hx,hz);
    [awp,~]=calc_submatrix_mean(wph,inx,inz,hx,hz);
    aK=(Kn-Kp)*wci;
    [akt,~]=calc_submatrix_mean(aK,inx,inz,hx,hz);

    tfx(t)=afx;
    twe(t)=awe;
    twp(t)=awp;
    tot(t)=afx+awe+awp;
    pkt(t)=akt;
end
%}
% plot figure
ptt=50.5:97;
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
