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

thfx=zeros(1,nt);
tenp=zeros(1,nt);
tvgp=zeros(1,nt);
ttnv=zeros(1,nt);
ttot=zeros(1,nt);
tdtt=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

    pp=read_data('presi',tp);
    np=read_data('Densi',tp);
    pn=read_data('presi',tn);
    nn=read_data('Densi',tn);

    p=read_data('presi',tm);
    qflux=read_data('qfluxi',tm);

    vx=read_data('vxi',tm);
    vy=read_data('vyi',tm);
    vz=read_data('vzi',tm);

    n=read_data('Densi',tm);

    % [T,hfx,tst,tpn,bct]=calc_partial_T_t(p,qflux,vx,vy,vz,n,grids);
    [T,hfx,enp,vgp,tnv]=calc_partial_T_t_from_thermal(p,qflux,vx,vy,vz,n,grids);

    [Ppxx,~,~,Ppyy,~,Ppzz]=reshap_pressure(pp,ndy,ndx);
    tppp=calc_scalar_temperature(Ppxx,Ppyy,Ppzz,np);
    [Pnxx,~,~,Pnyy,~,Pnzz]=reshap_pressure(pn,ndy,ndx);
    tppn=calc_scalar_temperature(Pnxx,Pnyy,Pnzz,nn);

    % integrating in a rectangle
    shfx=get_sub_matrix(hfx,x0,y0,top,bottom,left,right);
    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    svgp=get_sub_matrix(vgp,x0,y0,top,bottom,left,right);
    stnv=get_sub_matrix(tnv,x0,y0,top,bottom,left,right);

    stppp=get_sub_matrix(tppp,x0,y0,top,bottom,left,right);
    stppn=get_sub_matrix(tppn,x0,y0,top,bottom,left,right);
    tdtt(t)=(sum(sum(stppn))-sum(sum(stppp)))*wci;

    thfx(t)=sum(sum(shfx));
    tenp(t)=sum(sum(senp));
    tvgp(t)=sum(sum(svgp));
    ttnv(t)=sum(sum(stnv));
    ttot(t)=thfx(t)+tenp(t)+tvgp(t)+ttnv(t);
end
linewidth=2;
figure;
plot(tt,thfx,'r','LineWidth',linewidth); hold on
plot(tt,tenp,'g','LineWidth',linewidth);
plot(tt,tvgp,'b','LineWidth',linewidth);
plot(tt,ttnv,'c','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot(tt,tdtt,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
xlim([tt(1),tt(end)]);
legend('-2*\nabla \cdot q_{i}/3*n_{i}','-2* \nabla \cdot (P_i \cdot v_i)/3*n_{i}','-2* v_i \cdot (\nabla \cdot P_{i})/3*n_{i}','T_i \nabla \cdot (nv_i)/n_i','Sum','\partial T_{i}/\partial t','\partial T_{i}/\partial t=0','Location','Best');
xlabel('\Omega_{ci}t');
ylabel('\partial T_{i}/\partial t');
cd(outdir);
