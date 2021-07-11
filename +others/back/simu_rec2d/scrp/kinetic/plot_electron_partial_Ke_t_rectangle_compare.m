%% plot time evolution of the ion bulk kinetic energy 
% writen by Liangjin Song on 20190519 
%{
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
% electron
m=0.026666;
q=-0.000667;
wci=0.000250;
nt=length(tt);
c=0.6;
grids=1;

x0=4500;
y0=2250;
%{
top=1.5*di;
bottom=1.5*di;
left=2*di;
right=2*di;
%}
top=5*di;
bottom=5*di;
left=5*di;
right=5*di;

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
    Kp=calc_bulk_kinetic_energy(m,np,vxp,vyp,vzp);
    Kn=calc_bulk_kinetic_energy(m,nn,vxn,vyn,vzn);
    pK=(Kn-Kp)*wci;

    %% [Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);
    [Kh,fluxh,weh,wph]=calc_kinetic_partial_t(q,m,nh,vxh,vyh,vzh,exh,eyh,ezh,ph,grids);

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
%}
% plot figure
figure;
plot(tt,tot,'k','LineWidth',2); hold on
%{
plot(tt,twe,'r','LineWidth',2);
plot(tt,twp,'g','LineWidth',2);
plot(tt,tfx,'b','LineWidth',2);
%}
plot(tt,pkt,'--k','LineWidth',2);
plot([0,100],[0,0],'--y','LineWidth',2); hold off
xlim([tt(1),tt(end)]);
% legend('Total','-n_{e}q_{e}V_{e}\cdot E','-(\nabla\cdot P_{e})\cdot V_{e}','-\nabla\cdot(K_{e}V_{e})','\partial Ke/\partial t','\partial Ke/\partial t=0','Location','Best');
legend('Sum','\partial Ke/\partial t','\partial Ke/\partial t=0','Location','Best');
xlabel('\Omega t');
ylabel('\partial Ke/\partial t');
% set(gca,'FontSize',16);
cd(outdir);
