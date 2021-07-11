%% writen by Liangjin Song on 20190522
% plot partial Ue/t near the X line
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/thermal/electron/dUdt/';
tt=0:0.5:60;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
z0=15;
c=0.6;
grids=1;
wci=0.000750;

x0=3600;
y0=1800;
top=1.5*di;
bottom=1.5*di;
left=1.5*di;
right=1.5*di;

ten=zeros(1,nt);
tht=zeros(1,nt);
tth=zeros(1,nt);
tot=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    p=read_data('prese',tm);

    vx=read_data('vxe',tm);
    vy=read_data('vye',tm);
    vz=read_data('vze',tm);

    qflux=read_data('qfluxe',tm);

    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
    [qx,qy,qz]=reshape_qflux(qflux,ndy,ndx);

    [U,enp,htf,thp]=calc_partial_U_t(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,grids);

    % integrating in a rectangle
    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    shtf=get_sub_matrix(htf,x0,y0,top,bottom,left,right);
    sthp=get_sub_matrix(thp,x0,y0,top,bottom,left,right);

    ten(t)=sum(sum(senp));
    tht(t)=sum(sum(shtf));
    tth(t)=sum(sum(sthp));
    tot(t)=ten(t)+tht(t)+tth(t);
end

linewidth=2;
figure;
plot(tt,ten,'g','LineWidth',linewidth); hold on
plot(tt,tht,'b','LineWidth',linewidth);
plot(tt,tth,'r','LineWidth',linewidth);
plot(tt,tot,'k','LineWidth',linewidth);
plot([0,100],[0,0],'--r','LineWidth',linewidth);
legend('-\nabla \cdot (u_{e}V_{e}+P_{e} \cdot V_{e})','-\nabla \cdot q_{e}','V_{e}\cdot (\nabla \cdot P_{e})','Sum','dU_{e}/dt=0','Location','Best');
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('\partial U_{e}/\partial t near the X line');
cd(outdir);
% print('-r300','-dpng',['dUe_dt_average=',num2str(average),'.png']);
% close(gcf);
