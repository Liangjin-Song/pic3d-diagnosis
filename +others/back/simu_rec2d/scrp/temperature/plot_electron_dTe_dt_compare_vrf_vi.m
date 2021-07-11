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

tthf=zeros(1,nt);
ttst=zeros(1,nt);
ttpn=zeros(1,nt);
ttbc=zeros(1,nt);
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

    vix=read_data('vxe',tm);
    viy=read_data('vye',tm);
    viz=read_data('vze',tm);

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

    % [T,hfx,tst,tpn,bct,con]=calc_dT_dt(p,qflux,vx,vy,vz,n,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0);
    % [T,hfx,tst,tpn,bct,con]=calc_dT_dt_v_RF_timing(p,qflux,vx,vy,vz,n,grids,Lx,Ly,z0,bzp,bzn,wci,di);
    % [T,hfx,tst,tpn,bct,con]=calc_dT_dt_ExB(p,qflux,vx,vy,vz,n,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0);
    [T,hfx,tst,tpn,bct,con]=calc_dT_dt_vi(p,qflux,vx,vy,vz,n,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0,vix,viy,viz);

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
    stst=get_sub_matrix(tst,x0,y0,top,bottom,left,right);
    stpn=get_sub_matrix(tpn,x0,y0,top,bottom,left,right);
    sbct=get_sub_matrix(bct,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    stppp=get_sub_matrix(tppp,xp,y0,top,bottom,left,right);
    stppn=get_sub_matrix(tppn,xn,y0,top,bottom,left,right);
    tdtt(t)=(sum(sum(stppn))-sum(sum(stppp)))*wci;

    tthf(t)=sum(sum(shfx));
    ttst(t)=sum(sum(stst));
    ttpn(t)=sum(sum(stpn));
    ttbc(t)=sum(sum(sbct));
    ttco(t)=sum(sum(scon));
    ttot(t)=tthf(t)+ttst(t)+ttpn(t)+ttbc(t)+ttco(t);
end
linewidth=2;
figure;
plot(tt,tthf,'r','LineWidth',linewidth); hold on
plot(tt,ttst,'g','LineWidth',linewidth);
plot(tt,ttpn,'b','LineWidth',linewidth);
plot(tt,ttbc,'c','LineWidth',linewidth);
plot(tt,ttco,'m','LineWidth',linewidth);
plot(tt,ttot,'k','LineWidth',linewidth);
plot(tt,tdtt,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
xlim([tt(1),tt(end)]);
legend('-2*\nabla \cdot q_{e}/3*n_{e}','-2*(P''_{e}\cdot \nabla) \cdot v_{e}/3*n_{e}','-2*p_{e}\nabla \cdot v_{e}/3*n_{e}','-v_{e}\cdot \nabla T_{e}','v_{RF}\cdot \nabla T_{e}','Sum','dT_{e}/dt','dT_{e}/dt=0','Location','Best');
xlabel('\Omega_{ci}t');
ylabel('dT_{e}/dt');
cd(outdir);
