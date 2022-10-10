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
Nh=pic3d_read_data('Nl',th,ndx,ndy,ndz);
Qh=pic3d_read_data('qfluxl',th,ndx,ndy,ndz);

Pn=pic3d_read_data('Pl',th+dt,ndx,ndy,ndz);
Nn=pic3d_read_data('Nl',th+dt,ndx,ndy,ndz);
Pp=pic3d_read_data('Pl',th-dt,ndx,ndy,ndz);
Np=pic3d_read_data('Nl',th-dt,ndx,ndy,ndz);

%% thermal energy
Tn = calc_scalar_temperature(Pn.xx,Pn.yy,Pn.zz,Nn);
Tp = calc_scalar_temperature(Pp.xx,Pp.yy,Pp.zz,Np);

[T,hfx,tst,tpn,bct]=calc_partial_T_t(Ph,Qh,Vh.x,Vh.y,Vh.z,Nh,grids);

pT=(Tn-Tp)*wci*2*dt;

[lptt,xy]=get_line_data(pT,Lx,Ly,z0,1,1);
[lhfx,~]=get_line_data(hfx,Lx,Ly,z0,1,1);
[ltst,~]=get_line_data(tst,Lx,Ly,z0,1,1);
[ltpn,~]=get_line_data(tpn,Lx,Ly,z0,1,1);
[lbct,~]=get_line_data(bct,Lx,Ly,z0,1,1);
ltot=lhfx + ltst+ ltpn + lbct;

figure;
plot(xy,lptt,'-k','LineWidth',2);
hold on
plot(xy, lhfx, '-b', 'LineWidth', 2);
plot(xy, ltst, '-r', 'LineWidth', 2);
plot(xy, ltpn, '-m', 'LineWidth', 2);
plot(xy, lbct, '-g', 'LineWidth', 2);
plot(xy, ltot, '--k', 'LineWidth', 2);

legend('Total','Work by E field','Work by pressure','Flux','\partial Ki/\partial t','Location','Best');


xlabel('\Omega t');
ylabel('\partial Ki/\partial t near x-line');
set(gca,'FontSize',16);
cd(outdir);
