%% plot time evolution of the ion bulk kinetic energy 
% writen by Liangjin Song on 20190519 
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/partial/';
tt=10:0.5:50;
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
c=0.6;
grids=1;

x0=4500;
y0=2250;
top=1.5*di;
bottom=1.5*di;
left=2*di;
right=2*di;

tfx=zeros(1,nt);
twe=zeros(1,nt);
twp=zeros(1,nt);
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

    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    ph=read_data('presi',tt(t));

    %% bulk kinetic energy
    Kp=calc_bulk_kinetic_energy_relativity(m,np,vxp,vyp,vzp,c);
    Kn=calc_bulk_kinetic_energy_relativity(m,nn,vxn,vyn,vzn,c);
    pK=(Kn-Kp)*wci;

    %% [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);
    % [Kh,fluxh,weh,wph]=calc_kinetic_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);
    [Kh,fluxh,weh,wph]=calc_kinetic_partial_t_relativity(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids,c);

    lfx=get_sub_matrix(fluxh,x0,y0,top,bottom,left,right);
    lwe=get_sub_matrix(weh,x0,y0,top,bottom,left,right);
    lwp=get_sub_matrix(wph,x0,y0,top,bottom,left,right);
    lpk=get_sub_matrix(pK,x0,y0,top,bottom,left,right);

    tfx(t)=sum(sum(lfx));
    twe(t)=sum(sum(lwe));
    twp(t)=sum(sum(lwp));
    pkt(t)=sum(sum(lpk));
    tot(t)=tfx(t)+twe(t)+twp(t);
end
% plot figure
figure;
plot(tt,tot,'k','LineWidth',2); hold on
plot(tt,twe,'r','LineWidth',2);
plot(tt,twp,'g','LineWidth',2);
plot(tt,tfx,'b','LineWidth',2);
plot(tt,pkt,'--k','LineWidth',2);
plot([0,100],[0,0],'--y','LineWidth',2); hold off
xlim([tt(1),tt(end)]);
legend('Total','-n_{i}q_{i}V_{i}\cdot E','-(\nabla\cdot P_{i})\cdot V_{i}','-\nabla\cdot(K_{i}V_{i})','\partial Ki/\partial t','\partial Ki/\partial t=0','Location','Best');
xlabel('\Omega t');
ylabel('\partial Ki/\partial t');
% set(gca,'FontSize',16);
cd(outdir);
