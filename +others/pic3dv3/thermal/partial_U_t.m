%% plot time evolution of the ion bulk kinetic energy 
% writen by Liangjin Song on 20190519 
%
clear;
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Analysis\Ion';
th=100;
dt=1;
di=20;
ndx=2000;
ndy=1000;
ndz=1;
Lx=ndx/di;
Ly=ndy/di;
mi=4.493999;
q=0.003745;
wci=0.001250;
z0=50;
c=0.5;
% hx=2;
% hz=2;
grids=1;

m=mi;

cd(indir);
Ph=pic3d_read_data('Pl',th,ndx,ndy,ndz);
Vh=pic3d_read_data('Vl',th,ndx,ndy,ndz);
Qh=pic3d_read_data('qfluxl',th,ndx,ndy,ndz);

Pn=pic3d_read_data('Pl',th+dt,ndx,ndy,ndz);
Pp=pic3d_read_data('Pl',th-dt,ndx,ndy,ndz);

%% thermal energy
Up=calc_thermal_energy(Pp.xx,Pp.yy,Pp.zz);
Un=calc_thermal_energy(Pn.xx,Pn.yy,Pn.zz);

[U,enp,htf,thp]=calc_partial_U_t(Ph.xx,Ph.xy,Ph.xz,Ph.yy,Ph.yz,Ph.zz,Qh.x,Qh.y,Qh.z,Vh.x,Vh.y,Vh.z,grids);

pU=(Un-Up)*wci*2;

[lenp,xy]=get_line_data(enp,Lx,Ly,z0,1,1);
[lhtf,~]=get_line_data(htf,Lx,Ly,z0,1,1);
[lthp,~]=get_line_data(thp,Lx,Ly,z0,1,1);
[lput,~]=get_line_data(pU,Lx,Ly,z0,1,1);
tot=lenp + lhtf + lthp;

figure;
plot(xy,lput,'-k','LineWidth',2);
hold on
plot(xy,lthp,'-r','LineWidth',2);
plot(xy,lhtf,'-b','LineWidth',2);
plot(xy,lenp,'-m','LineWidth',2);
plot(xy,tot,'--k','LineWidth',2);

legend('Total','Work by E field','Work by pressure','Flux','\partial Ki/\partial t','Location','Best');


xlabel('\Omega t');
ylabel('\partial Ki/\partial t near x-line');
set(gca,'FontSize',16);
cd(outdir);
