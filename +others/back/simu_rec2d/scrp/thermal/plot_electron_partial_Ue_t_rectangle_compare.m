%% writen by Liangjin Song on 20190522
% plot partial Ue/t near the X line
%{
clear;
indir='/data/simulation/rec2d_M100SBg00Sx_ppn=1000/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx_ppn=1000/out/partial/';
tt=0.5:0.5:90;
dt=0.5;
di=40;
ndx=4000;
ndy=2000;
Lx=ndx/di; Ly=ndy/di;
nt=length(tt);
c=0.6;
grids=1;
wci=0.000750;

%{
x0=4500;
y0=2250;
top=1.5*di;
bottom=1.5*di;
left=2*di;
right=2*di;
%}
x0=3000;
y0=1500;
top=1.5*di;
bottom=1.5*di;
left=2*di;
right=2*di;

ten=zeros(1,nt);
tht=zeros(1,nt);
tth=zeros(1,nt);
tot=zeros(1,nt);
tpu=zeros(1,nt);

for t=1:nt
    cd(indir);
    th=tt(t);
    tp=th-dt;
    tn=th+dt;

    p=read_data('prese',th);
    pp=read_data('prese',tp);
    pn=read_data('prese',tn);

    vx=read_data('vxe',th);
    vy=read_data('vye',th);
    vz=read_data('vze',th);

    qflux=read_data('qfluxe',th);

    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
    [qx,qy,qz]=reshape_qflux(qflux,ndy,ndx);

    [pxxp,~,~,pyyp,~,pzzp]=reshap_pressure(pp,ndy,ndx);
    Up=calc_thermal_energy(pxxp,pyyp,pzzp);
    [pxxn,~,~,pyyn,~,pzzn]=reshap_pressure(pn,ndy,ndx);
    Un=calc_thermal_energy(pxxn,pyyn,pzzn);

    [U,enp,htf,thp]=calc_partial_U_t(pxx,pxy,pxz,pyy,pyz,pzz,qx,qy,qz,vx,vy,vz,grids);

    % integrating in a rectangle
    senp=get_sub_matrix(enp,x0,y0,top,bottom,left,right);
    shtf=get_sub_matrix(htf,x0,y0,top,bottom,left,right);
    sthp=get_sub_matrix(thp,x0,y0,top,bottom,left,right);
    sup=get_sub_matrix(Up,x0,y0,top,bottom,left,right);
    sun=get_sub_matrix(Un,x0,y0,top,bottom,left,right);

    ten(t)=sum(sum(senp));
    tht(t)=sum(sum(shtf));
    tth(t)=sum(sum(sthp));
    tot(t)=ten(t)+tht(t)+tth(t);
    tpu(t)=sum(sum(sun-sup))*wci;
end
linewidth=2;
%}
figure;
plot(tt,ten,'g','LineWidth',linewidth); hold on
plot(tt,tht,'b','LineWidth',linewidth);
plot(tt,tth,'r','LineWidth',linewidth);
plot(tt,tot,'k','LineWidth',linewidth);
plot(tt,tpu,'--k','LineWidth',linewidth);
plot([0,100],[0,0],'--y','LineWidth',linewidth); hold off
legend('-\nabla \cdot (u_{e}V_{e}+P_{e} \cdot V_{e})','-\nabla \cdot q_{e}','V_{e}\cdot (\nabla \cdot P_{e})','Sum','\partial U_{e}/\partial t','\partial U_{e}/\partial t=0','Location','Best');
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('\partial U_{e}/\partial t');
cd(outdir);
% print('-r300','-dpng',['dUe_dt_average=',num2str(average),'.png']);
% close(gcf);
