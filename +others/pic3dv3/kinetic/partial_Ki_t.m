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
nh=pic3d_read_data('Nl',th,ndx,ndy,ndz);
vh=pic3d_read_data('Vl',th,ndx,ndy,ndz);

nn=pic3d_read_data('Nl',th+dt,ndx,ndy,ndz);
vn=pic3d_read_data('Vl',th+dt,ndx,ndy,ndz);
np=pic3d_read_data('Nl',th-dt,ndx,ndy,ndz);
vp=pic3d_read_data('Vl',th-dt,ndx,ndy,ndz);

eh=pic3d_read_data('E',th,ndx,ndy,ndz);

ph=pic3d_read_data('Pl',th,ndx,ndy,ndz);

%% bulk kinetic energy
Kp=calc_bulk_kinetic_energy(m,np,vp.x,vp.y,vp.z);
Kn=calc_bulk_kinetic_energy(m,nn,vn.x,vn.y,vn.z);

[Kh,fluxh,weh,wph]=calc_partial_t(q,m,nh,vh.x,vh.y,vh.z,eh.x,eh.y,eh.z,ph,grids);

pK=(Kn-Kp)*wci*2;

[lfx,xy]=get_line_data(fluxh,Lx,Ly,z0,1,0);
[lwe,~]=get_line_data(weh,Lx,Ly,z0,1,0);
[lwp,~]=get_line_data(wph,Lx,Ly,z0,1,0);
[lpk,~]=get_line_data(pK,Lx,Ly,z0,1,0);
tot=lfx + lwe + lwp;

plot(ptt,tot,'--k','LineWidth',2); hold on
plot(ptt,twe,'r','LineWidth',2);
plot(ptt,twp,'g','LineWidth',2);
plot(ptt,tfx,'b','LineWidth',2);
plot(ptt,pkt,'-k','LineWidth',2);
legend('Total','Work by E field','Work by pressure','Flux','\partial Ki/\partial t','Location','Best');


xlabel('\Omega t');
ylabel('\partial Ki/\partial t near x-line');
set(gca,'FontSize',16);
cd(outdir);
