%% plot dTe/dt at the front
% writen by Liangjin Song on 20190810 
%
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/dt/';
tt=25:0.5:60;
dt=0.5;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=12.5;
c=0.6;
grids=1;
wci=0.000250;

y0=2250;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

thfx=zeros(1,nt);
tenp=zeros(1,nt);
tvgp=zeros(1,nt);
ttnv=zeros(1,nt);
ttco=zeros(1,nt);
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

    bx=read_data('Bx',tm);
    bx=bx/c;
    by=read_data('By',tm);
    by=by/c;
    bz=read_data('Bz',tm);
    bz=bz/c;
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    ex=read_data('Ex',tm);
    ey=read_data('Ey',tm);
    ez=read_data('Ez',tm);

    vix=read_data('vxi',tm);
    viy=read_data('vyi',tm);
    viz=read_data('vzi',tm);

    % [T,hfx,tst,tpn,bct,con]=calc_dT_dt(p,qflux,vx,vy,vz,n,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0);
    % [T,hfx,tst,tpn,bct,con]=calc_dT_dt_v_RF_timing(p,qflux,vx,vy,vz,n,grids,Lx,Ly,z0,bzp,bzn,wci,di);
    % [T,hfx,tst,tpn,~]=calc_partial_T_t(p,qflux,vx,vy,vz,n,grids);
    [T,hfx,enp,vgp,tnv,con]=calc_dT_dt_from_thermal(p,qflux,vx,vy,vz,n,vix,viy,viz,grids);

    [Ppxx,~,~,Ppyy,~,Ppzz]=reshap_pressure(pp,ndy,ndx);
    tppp=calc_scalar_temperature(Ppxx,Ppyy,Ppzz,np);
    [Pnxx,~,~,Pnyy,~,Pnzz]=reshap_pressure(pn,ndy,ndx);
    tppn=calc_scalar_temperature(Pnxx,Pnyy,Pnzz,nn);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    [~,xp]=max(lbzp);
    [~,xn]=max(lbzn);
    % integrating in a rectangle
    shfx=get_sub_matrix(hfx,x0,y0,top,bottom,left,right);
    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    svgp=get_sub_matrix(vgp,x0,y0,top,bottom,left,right);
    stnv=get_sub_matrix(tnv,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    stppp=get_sub_matrix(tppp,xp,y0,top,bottom,left,right);
    stppn=get_sub_matrix(tppn,xn,y0,top,bottom,left,right);
    tdtt(t)=(sum(sum(stppn))-sum(sum(stppp)))*wci;

    thfx(t)=sum(sum(shfx));
    tenp(t)=sum(sum(senp));
    tvgp(t)=sum(sum(svgp));
    ttnv(t)=sum(sum(stnv));
    ttco(t)=sum(sum(scon));
    ttot(t)=thfx(t)+tenp(t)+tvgp(t)+ttnv(t)+ttco(t);
end
linewidth=2;
figure;
plot(tt,thfx,'r','LineWidth',linewidth); hold on
plot(tt,tenp,'g','LineWidth',linewidth);
plot(tt,tvgp,'b','LineWidth',linewidth);
plot(tt,ttnv,'c','LineWidth',linewidth);
plot(tt,ttco,'m','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot(tt,tdtt,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
xlim([tt(1),tt(end)]);
legend('-2*\nabla \cdot q_{e}/3*n_{e}','-2* \nabla \cdot (P_e \cdot v_e)/3*n_{e}','-2* v_e \cdot (\nabla \cdot P_{e})/3*n_{e}','T_e \nabla \cdot (nv_e)/n_e','v_{RF}\cdot \nabla T_{e}','Sum','\partial T_{e}/\partial t','\partial T_{e}/\partial t=0','Location','Best');
xlabel('\Omega_{ci}t');
ylabel('dT_{e}/dt');
cd(outdir);
