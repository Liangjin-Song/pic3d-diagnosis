%% plot multi thermal line for ion
% writen by Liangjin Song on 20190808
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/thermal/ion/';
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di; Ly=ndy/di;
z0=15;
c=0.6;
grids=1;
wci=0.000750;

t1=30;
t2=35;
t3=40;
t4=45;
t5=50;

cd(indir);
p1=read_data('presi',t1);
p2=read_data('presi',t2);
p3=read_data('presi',t3);
p4=read_data('presi',t4);
p5=read_data('presi',t5);

[pxx,~,~,pyy,~,pzz]=reshap_pressure(p1,ndy,ndx);
U1=calc_thermal_energy(pxx,pyy,pzz);
[lu1,lx]=get_line_data(U1,Lx,Ly,z0,1,0);

[pxx,~,~,pyy,~,pzz]=reshap_pressure(p2,ndy,ndx);
U2=calc_thermal_energy(pxx,pyy,pzz);
[lu2,~]=get_line_data(U2,Lx,Ly,z0,1,0);

[pxx,~,~,pyy,~,pzz]=reshap_pressure(p3,ndy,ndx);
U3=calc_thermal_energy(pxx,pyy,pzz);
[lu3,~]=get_line_data(U3,Lx,Ly,z0,1,0);

[pxx,~,~,pyy,~,pzz]=reshap_pressure(p4,ndy,ndx);
U4=calc_thermal_energy(pxx,pyy,pzz);
[lu4,~]=get_line_data(U4,Lx,Ly,z0,1,0);

[pxx,~,~,pyy,~,pzz]=reshap_pressure(p5,ndy,ndx);
U5=calc_thermal_energy(pxx,pyy,pzz);
[lu5,~]=get_line_data(U5,Lx,Ly,z0,1,0);

linewidth=2;
plot(lx,lu1,'r','LineWidth',linewidth); hold on
plot(lx,lu2,'g','LineWidth',linewidth);
plot(lx,lu3,'b','LineWidth',linewidth);
plot(lx,lu4,'k','LineWidth',linewidth);
plot(lx,lu5,'m','LineWidth',linewidth);
xlim([3*Lx/4,Lx]);
legend(['\Omega t=',num2str(t1)],['\Omega t=',num2str(t2)],['\Omega t=',num2str(t3)],['\Omega t=',num2str(t4)],['\Omega t=',num2str(t5)],'Location','Best');
xlabel('X[c/\omega_{pi}]');
ylabel('Ui');
cd(outdir);
