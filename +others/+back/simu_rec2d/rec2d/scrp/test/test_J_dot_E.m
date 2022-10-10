% test J dot E
% writen by Liangjin Song on 20190530
clear
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/test/';
t=95;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
grids=1;
z0=25;
c=0.6;
qi=0.000105;
qe=-0.000105;

% load data
cd(indir)
bx=read_data('Bx',t);
by=read_data('By',t);
bz=read_data('Bz',t);

ex=read_data('Ex',t);
ey=read_data('Ey',t);
ez=read_data('Ez',t);

% ions
ni=read_data('Densi',t);
vix=read_data('vxi',t);
viy=read_data('vyi',t);
viz=read_data('vzi',t);

% electrons
ne=read_data('Dense',t);
vex=read_data('vxe',t);
vey=read_data('vye',t);
vez=read_data('vze',t);

% Ji dot E
wi=calc_work_by_efield(qi,ni,vix,viy,viz,ex,ey,ez);
we=calc_work_by_efield(qe,ne,vex,vey,vez,ex,ey,ez);
tot=wi+we;

[jx,jy,jz]=simu_curlB(bx,by,bz,grids,c);
w=jx.*ex+jy.*ey+jz.*ez;

% get line
[lw,lx]=get_line_data(w,Lx,Ly,z0,1,0);
[lt,~]=get_line_data(tot,Lx,Ly,z0,1,0);

% plot
plot(lx,lt,'k','LineWidth',2); hold on
plot(lx,lw,'r','LineWidth',2);
legend('curlB\cdotE','J\cdotE')
xlabel('X')
set(gca,'Fontsize',16)
cd(outdir)
