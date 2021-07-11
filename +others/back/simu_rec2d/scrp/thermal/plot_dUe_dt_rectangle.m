%% writen by Liangjin Song on 20190522
% plot partial Ue/t line
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/thermal/electron/dUdt/';
tt=0:0.5:100;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;
grids=1;
wci=0.000750;

y0=1800;
top=1.5*di;
bottom=1.5*di;
left=0.5*di;
right=5*di;

ten=zeros(1,nt);
tht=zeros(1,nt);
tth=zeros(1,nt);
tco=zeros(1,nt);
tot=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    p=read_data('prese',tm);

    vx=read_data('vxe',tm);
    vy=read_data('vye',tm);
    vz=read_data('vze',tm);

    qflux=read_data('qfluxe',tm);

    bx=read_data('Bx',tm);
    bx=bx/c;
    by=read_data('By',tm);
    by=by/c;
    bz=read_data('Bz',tm);
    bz=bz/c;

    ex=read_data('Ex',tm);
    ey=read_data('Ey',tm);
    ez=read_data('Ez',tm);

    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
    [qx,qy,qz]=reshape_qflux(qflux,ndy,ndx);

    [U,enp,htf,thp,con]=calc_dU_dt(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,bx,by,bz,ex,ey,ez,grids,Lx,Ly,z0);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);
    % integrating in a rectangle
    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    shtf=get_sub_matrix(htf,x0,y0,top,bottom,left,right);
    sthp=get_sub_matrix(thp,x0,y0,top,bottom,left,right);
    scon=get_sub_matrix(con,x0,y0,top,bottom,left,right);

    ten(t)=sum(sum(senp));
    tht(t)=sum(sum(shtf));
    tth(t)=sum(sum(sthp));
    tco(t)=sum(sum(scon));
    tot(t)=ten(t)+tht(t)+tth(t)+tco(t);
end

linewidth=2;
figure;
plot(tt,ten,'g','LineWidth',linewidth); hold on
plot(tt,tht,'b','LineWidth',linewidth);
plot(tt,tth,'c','LineWidth',linewidth);
plot(tt,tco,'m','LineWidth',linewidth);
plot(tt,tot,'k','LineWidth',linewidth);
plot([0,100],[0,0],'--r','LineWidth',linewidth);
legend('-\nabla \cdot (u_{e}V_{e}+P_{e} \cdot V_{e})','-\nabla \cdot q_{e}','V_{e}\cdot (\nabla \cdot P_{e})','v_{RF}\cdot \nabla U_{e}','Sum','dU_{e}/dt=0','Location','Best');
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dU_{e}/dt');
cd(outdir);
% print('-r300','-dpng',['dUe_dt_average=',num2str(average),'.png']);
% close(gcf);
