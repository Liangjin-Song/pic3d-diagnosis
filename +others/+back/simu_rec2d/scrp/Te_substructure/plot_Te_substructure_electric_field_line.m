%% plot magnetic field line
% writen by Liangjin on 20190814 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/line/';
tt=43;
di=40;
z0=15;
vA=0.03;
Lx=4800/di;
Ly=2400/di;
xrange=[70,110];

cd(indir);
stream=read_data('stream',tt);
ex=read_data('Ex',tt);
ey=read_data('Ey',tt);
ez=read_data('Ez',tt);

[lex,lx]=get_line_data(ex,Lx,Ly,z0,vA,0);
[ley,~]=get_line_data(ey,Lx,Ly,z0,vA,0);
[lez,~]=get_line_data(ez,Lx,Ly,z0,vA,0);

figure;
plot(lx,lex,'r','LineWidth',2); hold on
plot(lx,ley,'g','LineWidth',2);
plot(lx,lez,'b','LineWidth',2);
xlim(xrange);
legend('E_x','E_y','E_z','Location','Best');
set(gcf,'position',[100 100 600 250]);
cd(outdir);
