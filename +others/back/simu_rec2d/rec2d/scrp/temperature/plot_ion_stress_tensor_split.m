% plot stress tensor and its three components
% writen by Liangjin Song on 20190818
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

ttst=zeros(1,nt);
ttstx=zeros(1,nt);
ttsty=zeros(1,nt);
ttstz=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);
    p=read_data('presi',tm);

    vx=read_data('vxi',tm);
    vy=read_data('vyi',tm);
    vz=read_data('vzi',tm);

    n=read_data('Densi',tm);

    bz=read_data('Bz',tm);
    bz=bz/c;

    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
    [tst,tstx,tsty,tstz]=calc_temperature_stress_tensor(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,n,grids);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    stst=get_sub_matrix(tst,x0,y0,top,bottom,left,right);
    ststx=get_sub_matrix(tstx,x0,y0,top,bottom,left,right);
    ststy=get_sub_matrix(tsty,x0,y0,top,bottom,left,right);
    ststz=get_sub_matrix(tstz,x0,y0,top,bottom,left,right);

    ttst(t)=sum(sum(stst));
    ttstx(t)=sum(sum(ststx));
    ttsty(t)=sum(sum(ststy));
    ttstz(t)=sum(sum(ststz));
end
linewidth=2;
figure;
plot(tt,ttst,'k','LineWidth',linewidth); hold on
plot(tt,ttstx,'r','LineWidth',linewidth);
plot(tt,ttsty,'g','LineWidth',linewidth);
plot(tt,ttstz,'b','LineWidth',linewidth); hold off
xlim([tt(1),tt(end)]);
legend('Sum','x','y','z');
xlabel('\Omega_{ci}t');
ylabel('-2*(P''_{i}\cdot \nabla) \cdot v_{i}/3*n_{i}')
cd(outdir);

