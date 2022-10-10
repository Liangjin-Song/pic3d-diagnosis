%% test divergence
% writen by Liangjin Song on 20190522
clear
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
t=80;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
grids=1;
z0=25;
mi=0.035000;

cd(indir);
n=read_data('Densi',t);
vx=read_data('vxi',t);
vy=read_data('vyi',t);
vz=read_data('vzi',t);

% bulk kinetic energy
K=calc_bulk_kinetic_energy(mi,n,vx,vy,vz);

% flux
flux=calc_bulk_kinetic_energy_flux(K,vx,vy,vz,grids);

% v dot gradient K
[gx,gy,gz]=calc_gradient(K,grids);
vgk=gx.*vx+gy.*vy+gz.*vz;

% K divergence v
div=calc_divergence(vx,vy,vz,grids);
kgv=div.*K;

% total
total=kgv+vgk;

% get line
[lf,lx]=get_line_data(flux,Lx,Ly,z0,1,0);
[lt,~]=get_line_data(total,Lx,Ly,z0,1,0);

%% all 
% plot(lx,lnpu,'g','LineWidth',2);
% plot(lx,lupn,'b','LineWidth',2);
plot(lx,lt,'k','LineWidth',2); hold on
plot(lx,lf,'r','LineWidth',2);
legend('v\cdot\nablaK+K\nabla\cdotv','\nabla\cdot(Kv)')
xlabel('X')
set(gca,'Fontsize',16)
