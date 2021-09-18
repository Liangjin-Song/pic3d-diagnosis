%% plot dTe/dt at the front
% writen by Liangjin Song on 20190810 
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/partial/';
tt=10:0.5:50;
dt=0.5;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
c=0.6;
grids=1;
wci=0.000250;

x0=4500;
y0=2250;
top=1.5*di;
bottom=1.5*di;
left=2*di;
right=2*di;

tthf=zeros(1,nt);
ttst=zeros(1,nt);
ttpn=zeros(1,nt);
ttbc=zeros(1,nt);
ttot=zeros(1,nt);
tdtt=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

    pp=read_data('prese',tp);
    np=read_data('Dense',tp);
    pn=read_data('prese',tn);
    nn=read_data('Dense',tn);

    p=read_data('prese',tm);
    qflux=read_data('qfluxe',tm);

    vx=read_data('vxe',tm);
    vy=read_data('vye',tm);
    vz=read_data('vze',tm);

    n=read_data('Dense',tm);

    [T,hfx,tst,tpn,bct]=calc_partial_T_t(p,qflux,vx,vy,vz,n,grids);

    [Ppxx,~,~,Ppyy,~,Ppzz]=reshap_pressure(pp,ndy,ndx);
    tppp=calc_scalar_temperature(Ppxx,Ppyy,Ppzz,np);
    [Pnxx,~,~,Pnyy,~,Pnzz]=reshap_pressure(pn,ndy,ndx);
    tppn=calc_scalar_temperature(Pnxx,Pnyy,Pnzz,nn);

    % integrating in a rectangle
    shfx=get_sub_matrix(hfx,x0,y0,top,bottom,left,right);
    stst=get_sub_matrix(tst,x0,y0,top,bottom,left,right);
    stpn=get_sub_matrix(tpn,x0,y0,top,bottom,left,right);
    sbct=get_sub_matrix(bct,x0,y0,top,bottom,left,right);

    stppp=get_sub_matrix(tppp,x0,y0,top,bottom,left,right);
    stppn=get_sub_matrix(tppn,x0,y0,top,bottom,left,right);
    tdtt(t)=(sum(sum(stppn))-sum(sum(stppp)))*wci;

    tthf(t)=sum(sum(shfx));
    ttst(t)=sum(sum(stst));
    ttpn(t)=sum(sum(stpn));
    ttbc(t)=sum(sum(sbct));
    ttot(t)=tthf(t)+ttst(t)+ttpn(t)+ttbc(t);
end
linewidth=2;
figure;
plot(tt,tthf,'r','LineWidth',linewidth); hold on
plot(tt,ttst,'g','LineWidth',linewidth);
plot(tt,ttpn,'b','LineWidth',linewidth);
plot(tt,ttbc,'c','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot(tt,tdtt,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
xlim([tt(1),tt(end)]);
legend('-2*\nabla \cdot q_{e}/3*n_{e}','-2*(P''_{e}\cdot \nabla) \cdot v_{e}/3*n_{e}','-2*p_{e}\nabla \cdot v_{e}/3*n_{e}','-v_{e}\cdot \nabla T_{e}','Sum','\partial T_{e}/\partial t','\partial T_{e}/\partial t=0','Location','Best');
xlabel('\Omega_{ci}t');
ylabel('\partial T_{e}/\partial t');
cd(outdir);
