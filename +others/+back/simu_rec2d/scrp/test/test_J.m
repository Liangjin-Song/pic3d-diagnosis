% test J
% writen by Liangjin Song on 20190530
clear
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
outdir='/data/simulation/rec2d_M25SBg00Sx/test/';
t=89;
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

[jpx,jpy,jpz]=calc_current_density(ni,ne,qi,qe,vix,viy,viz,vex,vey,vez);
[jbx,jby,jbz]=simu_curlB(bx,by,bz,grids,c);

% get line
% wp=jpx.*ex+jpy.*ey+jpz.*ez;
% wb=jbx.*ex+jby.*ey+jbz.*ez;

[lp,lx]=get_line_data(jpy,Lx,Ly,z0,1,0);
[lb,~]=get_line_data(jby,Lx,Ly,z0,1,0);


% plot
plot(lx,lp,'k','LineWidth',2); hold on
plot(lx,lb,'r','LineWidth',2);
legend('Jpy','Jby')
% legend('curlB\cdotE','J\cdotE')
xlabel('X')
title(['\Omegat=',num2str(t)]);
set(gca,'Fontsize',16)
cd(outdir)
