% plot time evoluation of bulk kinetic energy of ion and electron
% writen by Liangjin Song on 20191124
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
mi=2.666618;
qi=0.000667;

% electron
me=0.026666;
qe=-0.000667;

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

    % ion
    nih=read_data('Densi',th);
    vixh=read_data('vxi',th);
    viyh=read_data('vyi',th);
    vizh=read_data('vzi',th);

    nin=read_data('Densi',tn);
    vixn=read_data('vxi',tn);
    viyn=read_data('vyi',tn);
    vizn=read_data('vzi',tn);

    nip=read_data('Densi',tp);
    vixp=read_data('vxi',tp);
    viyp=read_data('vyi',tp);
    vizp=read_data('vzi',tp);

    % electron
    neh=read_data('Dense',th);
    vexh=read_data('vxe',th);
    veyh=read_data('vye',th);
    vezh=read_data('vze',th);

    nen=read_data('Dense',tn);
    vexn=read_data('vxe',tn);
    veyn=read_data('vye',tn);
    vezn=read_data('vze',tn);

    nep=read_data('Dense',tp);
    vexp=read_data('vxe',tp);
    veyp=read_data('vye',tp);
    vezp=read_data('vze',tp);

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

    pih=read_data('presi',tt(t));
    peh=read_data('prese',tt(t));

    %% ion bulk kinetic energy
    Kip=calc_bulk_kinetic_energy(mi,nip,vixp,viyp,vizp);
    Kin=calc_bulk_kinetic_energy(mi,nin,vixn,viyn,vizn);

    [Kih,fluxih,weih,wpih,cvih]=calc_kinetic_dK_dt_vRF_timing(qi,mi,nih,vixh,viyh,vizh,exh,eyh,ezh,pih,grids,Lx,Ly,z0,bzp,bzn,wci,di);


    %% electron bulk kinetic energy
    Kep=calc_bulk_kinetic_energy(me,nep,vexp,veyp,vezp);
    Kep=simu_filter2d(Kep);
    Ken=calc_bulk_kinetic_energy(me,nen,vexn,veyn,vezn);
    Ken=simu_filter2d(Ken);

    [Keh,fluxeh,weeh,wpeh,cveh]=calc_kinetic_dK_dt_vRF_timing(qe,me,neh,vexh,veyh,vezh,exh,eyh,ezh,peh,grids,Lx,Ly,z0,bzp,bzn,wci,di);
    Keh=simu_filter2d(Keh);
    fluxeh=simu_filter2d(fluxeh);
    weeh=simu_filter2d(weeh);
    wpeh=simu_filter2d(wpeh);
    cveh=simu_filter2d(cveh);

    %% get a mean value of a ractangle
    [lbz,~]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    %% ion
    iafx=get_sub_matrix(fluxih,x0,y0,top,bottom,left,right);
    iawe=get_sub_matrix(weih,x0,y0,top,bottom,left,right);
    iawp=get_sub_matrix(wpih,x0,y0,top,bottom,left,right);
    iacv=get_sub_matrix(cvih,x0,y0,top,bottom,left,right);

    aKp=get_sub_matrix(Kip,x1,y0,top,bottom,left,right);
    aKn=get_sub_matrix(Kin,x2,y0,top,bottom,left,right);
    ipkt=sum(sum(aKn-aKp))*wci;

    %% electron
    eafx=get_sub_matrix(fluxeh,x0,y0,top,bottom,left,right);
    eawe=get_sub_matrix(weeh,x0,y0,top,bottom,left,right);
    eawp=get_sub_matrix(wpeh,x0,y0,top,bottom,left,right);
    eacv=get_sub_matrix(cveh,x0,y0,top,bottom,left,right);

    aKp=get_sub_matrix(Kep,x1,y0,top,bottom,left,right);
    aKn=get_sub_matrix(Ken,x2,y0,top,bottom,left,right);
    epkt=sum(sum(aKn-aKp))*wci;

    %% Sum
    tfx(t)=sum(sum(iafx+eafx));
    twe(t)=sum(sum(iawe+eawe));
    twp(t)=sum(sum(iawp+eawp));
    tcv(t)=sum(sum(iacv+eacv));
    tot(t)=tfx(t)+twe(t)+twp(t)+tcv(t);
    pkt(t)=ipkt+epkt;
end
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
legend('Sum','-n_{ie}q_{ie}V_{ie}\cdot E','-(\nabla\cdot P_{ie})\cdot V_{ie}','-\nabla\cdot(K_{ie}V_{ie})','V_{RF}\cdot\nabla K_{ie}','dKie/dt','dKie/dt=0','Location','Best');
xlabel('\Omega_{ci} t');
ylabel('dKie/dt');
cd(outdir);
