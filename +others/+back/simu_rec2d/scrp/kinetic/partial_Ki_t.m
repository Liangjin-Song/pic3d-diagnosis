%% plot time evolution of the ion bulk kinetic energy 
% writen by Liangjin Song on 20190519 
%
clear;
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Analysis\Ion';
tt=100;
di=20;
ndx=2000;
ndy=1000;
Lx=ndx/di;
Ly=ndy/di;
mi=0.035000;
q=0.000105;
wci=0.003000;
nt=length(tt)-1;
z0=25;
c=0.6;
% hx=2;
% hz=2;
grids=1;


%% get a mean value of a ractangle
inx=3000;
% inz=1800;
average=10;


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

    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    ph=read_data('presi',tt(t));

    %% bulk kinetic energy
    m=mi;
    Kp=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    Kn=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);

    [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);

    pK=(Kn-Kp)*wci;

    [lfx,xy]=get_line_data(fluxh,Lx,Ly,z0,1,0);
    [lwe,~]=get_line_data(weh,Lx,Ly,z0,1,0);
    [lwp,~]=get_line_data(wph,Lx,Ly,z0,1,0);
    [lpk,~]=get_line_data(pK,Lx,Ly,z0,1,0);


    in=inx-average/2;
    afx=lfx(in);
    awe=lwe(in);
    awp=lwp(in);
    apk=lpk(in);

    for i=1:average
        ini=in+i;
        afx=afx+lfx(ini);
        awe=awe+lwe(ini);
        awp=awp+lwp(ini);
        apk=apk+lpk(ini);
    end
    afx=afx/(average+1);
    awe=awe/(average+1);
    awp=awp/(average+1);
    apk=apk/(average+1);

    % [afx,~]=calc_submatrix_mean(fluxh,inx,inz,hx,hz);
    % [awe,~]=calc_submatrix_mean(weh,inx,inz,hx,hz);
    % [awp,~]=calc_submatrix_mean(wph,inx,inz,hx,hz);

    % [akt,~]=calc_submatrix_mean(pK,inx,inz,hx,hz);

    tfx(t)=afx;
    twe(t)=awe;
    twp(t)=awp;
    tot(t)=afx+awe+awp;
    pkt(t)=apk;
end
%}
% plot figure
ptt=50.5:97;
plot(ptt,tot,'k','LineWidth',2); hold on
plot(ptt,twe,'r','LineWidth',2);
plot(ptt,twp,'g','LineWidth',2);
plot(ptt,tfx,'b','LineWidth',2);
plot(ptt,pkt,'m','LineWidth',2);
legend('Total','Work by E field','Work by pressure','Flux','\partial Ki/\partial t','Location','Best');
xlabel('\Omega t');
ylabel('\partial Ki/\partial t near x-line');
set(gca,'FontSize',16);
cd(outdir);
