%% writen by Liangjin Song on 20190522
% plot partial Ue/t line
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/thermal/electron/dUdt/';
tt=30:0.5:70;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;
grids=1;
wci=0.000750;

average=20;

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

    % get line
    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
    [lU,~]=get_line_data(U,Lx,Ly,z0,1,0);
    [lenp,~]=get_line_data(enp,Lx,Ly,z0,1,0);
    [lhtf,~]=get_line_data(htf,Lx,Ly,z0,1,0);
    [lthp,~]=get_line_data(thp,Lx,Ly,z0,1,0);
    [lcon,~]=get_line_data(con,Lx,Ly,z0,1,0);
    ltot=lenp+lhtf+lthp+lcon;

    lU(560:3600)=0;

    [~,in]=max(lU);
    ten0=lenp(in);
    tht0=lhtf(in);
    tth0=lthp(in);
    tco0=lcon(in);
    tot0=ltot(in);

    for m=1:average
        tin=in+m;
        if tin>ndx
            tin=tin-ndx;
        end
        ten0=ten0+lenp(tin);
        tht0=tht0+lhtf(tin);
        tth0=tth0+lthp(tin);
        tco0=tco0+lcon(tin);
        tot0=tot0+ltot(tin);
    end
    ten(t)=ten0/(average+1);
    tht(t)=tht0/(average+1);
    tth(t)=tth0/(average+1);
    tco(t)=tco0/(average+1);
    tot(t)=tot0/(average+1);
end
linewidth=2;
figure;
plot(tt,ten,'g','LineWidth',linewidth); hold on
plot(tt,tht,'b','LineWidth',linewidth);
plot(tt,tth,'c','LineWidth',linewidth);
plot(tt,tco,'m','LineWidth',linewidth);
plot(tt,tot,'k','LineWidth',linewidth);
legend('-\nabla \cdot (u_{e}V_{e}+P_{e} \cdot V_{e})','-\nabla \cdot q_{e}','V_{e}\cdot (\nabla \cdot P_{e})','v_{RF}\cdot \nabla U_{e}','Sum','Location','Best');
plot([0,100],[0,0],'--r','LineWidth',linewidth);
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('dU_{e}/dt');
cd(outdir);
% print('-r300','-dpng',['dUe_dt_average=',num2str(average),'.png']);
% close(gcf);
