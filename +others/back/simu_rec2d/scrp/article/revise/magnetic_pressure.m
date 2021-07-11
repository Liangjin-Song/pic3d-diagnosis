% plot magnetic pressure
% writen by Liangjin Song on 20200702
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);
normf=vA*mi*n0;

tt=45;

cd(indir);
bx=read_data('Bx',tt);
bx=bx/c;
by=read_data('By',tt);
by=by/c;
bz=read_data('Bz',tt);
bz=bz/c;

ss=read_data('stream',tt);

% magnetic pressure
mu0=c^(-2);
ndx=size(bx,2);
ndy=size(bx,1);
zr=zeros(ndy,ndx);

normf=1/(2*mu0);

b2=(bx.^2+by.^2+bz.^2)/(2*mu0);
[x,y,z]=calc_divergence_pressure(b2,zr,zr,b2,zr,b2,grids);
x=-x/normf;
y=-y/normf;
z=-z/normf;

[lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
[~,xa]=max(lbz);
xa=lx(xa);
left=left/di;
right=right/di;
bottom=bottom/di;
top=top/di;

map=mycolormap();

plot_overview(x,ss,1,Lx,Ly); hold on
colormap(map);


plot([xa-left,xa+right],[z0-bottom,z0-bottom],'-r','LineWidth',3);
plot([xa+right,xa+right],[z0-bottom,z0+top],'-r','LineWidth',3);
plot([xa+right,xa-left],[z0+top,z0+top],'-r','LineWidth',3);
plot([xa-left,xa-left],[z0+top,z0-bottom],'-r','LineWidth',3); hold off

xlim([75,100]);
ylim([5,20]);

