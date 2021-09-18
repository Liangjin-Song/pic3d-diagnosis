%% test curl b
% writen by Liangjin Song on 20190531
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
c=0.6;
z0=25;

% load data
cd(indir);
bx=read_data('Bx',t);
bx=bx/c;
by=read_data('By',t);
by=by/c;
bz=read_data('Bz',t);
bz=bz/c;

b=sqrt(bx.^2+by.^2+bz.^2);
bx=bx./b;
by=by./b;
bz=bz./b;
b=sqrt(bx.^2+by.^2+bz.^2);

% curl b
[cbx,cby,cbz]=simu_curlB(bx,by,bz,1,grids);

% first term
m=bx.*cbx+by.*cby+bz.*cbz;
mx=bx.*m;
my=by.*m;
mz=bz.*m;

% second term
%
[gx,gy,gz]=calc_gradient(bx,grids);
px=gx.*bx+gy.*by+gz.*bz;
[gx,gy,gz]=calc_gradient(by,grids);
py=gx.*bx+gy.*by+gz.*bz;
[gx,gy,gz]=calc_gradient(bz,grids);
pz=gx.*bx+gy.*by+gz.*bz;

[nx,ny,nz]=calc_cross(bx,by,bz,px,py,pz);

% gradient b
[gx,gy,gz]=calc_gradient(b,grids);
gx=gx.*b;
gy=gy.*b;
gz=gz.*b;

[px,py,pz]=calc_cross(gx,gy,gz,bx,by,bz);
%

% [nx,ny,nz]=calc_cross(bx,by,bz,cbx,cby,cbz);
% [nx,ny,nz]=calc_cross(nx,ny,nz,bx,by,bz);
%
% total 
bcx=mx+nx;
bcy=my+ny;
bcz=mz+nz;

pbcx=mx+nx+px;
pbcy=my+ny+py;
pbcz=mz+nz+pz;

% get line
[lcb,lx]=get_line_data(cby,Lx,Ly,z0,1,0);
[lbc,~]=get_line_data(bcy,Lx,Ly,z0,1,0);
[lpb,~]=get_line_data(pbcy,Lx,Ly,z0,1,0);
[lpy,~]=get_line_data(py,Lx,Ly,z0,1,0);

plot(lx,lbc,'g','LineWidth',3); hold on
plot(lx,lcb,'r','LineWidth',1);
plot(lx,lpb,'b','LineWidth',1);
legend('\nabla\timesb','b[b\cdot(\nabla\timesb)]+b\times(b\cdot\nabla)b','b[b\cdot(\nabla\timesb)]+b\nablab\timesb+b\times(b\cdot\nabla)b');
xlabel('X')
title(['\Omegat=',num2str(t)]);
set(gca,'Fontsize',16)
cd(outdir)
