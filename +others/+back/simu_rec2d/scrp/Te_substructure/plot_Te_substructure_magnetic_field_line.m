%% plot magnetic field line
% writen by Liangjin on 20190814 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/line/';
tt=43;
c=0.6;
di=40;
z0=15;
Lx=4800/di;
Ly=2400/di;
xrange=[70,110];

cd(indir);
stream=read_data('stream',tt);
bx=read_data('Bx',tt);
bx=bx/c;
by=read_data('By',tt);
by=by/c;
bz=read_data('Bz',tt);
bz=bz/c;
bt=sqrt(bx.^2+by.^2+bz.^2);

[lbx,lx]=get_line_data(bx,Lx,Ly,z0,1,0);
[lby,~]=get_line_data(by,Lx,Ly,z0,1,0);
[lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
[lbt,~]=get_line_data(bt,Lx,Ly,z0,1,0);

figure;
plot(lx,lbx,'r','LineWidth',2); hold on
plot(lx,lby,'g','LineWidth',2);
plot(lx,lbz,'b','LineWidth',2);
plot(lx,lbt,'k','LineWidth',2);
xlim(xrange);
legend('B_x','B_y','B_z','B_{total}','Location','Best');
set(gcf,'position',[100 100 600 250]);
cd(outdir);
