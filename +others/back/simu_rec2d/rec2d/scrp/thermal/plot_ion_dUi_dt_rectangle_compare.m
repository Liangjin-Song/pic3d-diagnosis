%% writen by Liangjin Song on 20190522
% plot partial Ue/t line
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

ten=zeros(1,nt);
tht=zeros(1,nt);
tth=zeros(1,nt);
tco=zeros(1,nt);
tot=zeros(1,nt);
tpu=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    tp=tm-dt;
    tn=tm+dt;

    p=read_data('presi',tm);
    pp=read_data('presi',tp);
    pn=read_data('presi',tn);

    vx=read_data('vxi',tm);
    vy=read_data('vyi',tm);
    vz=read_data('vzi',tm);

    qflux=read_data('qfluxi',tm);

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

    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
    [qx,qy,qz]=reshape_qflux(qflux,ndy,ndx);

    [pxxp,~,~,pyyp,~,pzzp]=reshap_pressure(pp,ndy,ndx);
    Up=calc_thermal_energy(pxxp,pyyp,pzzp);
    [pxxn,~,~,pyyn,~,pzzn]=reshap_pressure(pn,ndy,ndx);
    Un=calc_thermal_energy(pxxn,pyyn,pzzn);

    [U,enp,htf,thp,con]=calc_dU_dt_vrf_timing(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,bzn,bzp,grids,Lx,Ly,z0,wci,di);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    shtf=get_sub_matrix(htf,x0,y0,top,bottom,left,right);
    sthp=get_sub_matrix(thp,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    [lbzp,~]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [~,x1]=max(lbzp);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);
    [~,x2]=max(lbzn);

    sup=get_sub_matrix(Up,x1,y0,top,bottom,left,right);
    sun=get_sub_matrix(Un,x2,y0,top,bottom,left,right);


    ten(t)=sum(sum(senp));
    tht(t)=sum(sum(shtf));
    tth(t)=sum(sum(sthp));
    tco(t)=sum(sum(scon));
    tot(t)=ten(t)+tht(t)+tth(t)+tco(t);
    tpu(t)=sum(sum(sun-sup))*wci;
end

linewidth=2;
figure;
plot(tt,ten,'g','LineWidth',linewidth); hold on
plot(tt,tht,'b','LineWidth',linewidth);
plot(tt,tth,'c','LineWidth',linewidth);
plot(tt,tco,'m','LineWidth',linewidth);
plot(tt,tot,'k','LineWidth',linewidth);
plot(tt,tpu,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
legend('-\nabla \cdot (u_{i}V_{i}+P_{i} \cdot V_{i})','-\nabla \cdot q_{i}','V_{i}\cdot (\nabla \cdot P_{i})','v_{RF}\cdot \nabla U_{i}','Sum','dU_{i}/dt','dU_{i}/dt=0','Location','Best');
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dU_{i}/dt');
cd(outdir);
% print('-r300','-dpng',['dUe_dt_average=',num2str(average),'.png']);
% close(gcf);
