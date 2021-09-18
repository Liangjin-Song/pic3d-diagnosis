%% test the parallel and perp pressure
% writen by Liangjin Song on 20191217
%{
clear;

indir='/data/simulation/M25SBg00Sx_low_vte/data/';
outdir='/data/simulation/M25SBg00Sx_low_vte/out/overview/';

c=0.6;
ndx=6000;
ndy=3000;
di=40;
Lx=ndx/di;
Ly=ndy/di;
tt=55;
z0=18.75;

cd(indir);
bx=read_data('Bx',tt);
bx=bx/c;
by=read_data('Bx',tt);
by=by/c;
bz=read_data('Bx',tt);
bz=bz/c;
p=read_data('presi',tt);
n=read_data('Densi',tt);

%% check
[taver,tperp,tpara,~]=calc_temperature(p,bx,by,bz,n);

%% unit magnetic field
b=sqrt(bx.^2+by.^2+bz.^2);
bx=bx./b;
by=by./b;
bz=bz./b;
bxx=bx.*bx;
bxy=bx.*by;
bxz=bx.*bz;
byy=by.*by;
byz=by.*bz;
bzz=bz.*bz;

[pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);

%% parallel pressure
para=pxx.*bxx+pyy.*byy+pzz.*pzz+(pxy.*bxy+pxz.*bxz+pyz.*byz)*2;

%% perpendicular pressure
bxx=(1-bxx)/2;
byy=(1-byy)/2;
bzz=(1-bzz)/2;
bxy=-bxy/2;
bxz=-bxz/2;
byz=-byz/2;

perp=pxx.*bxx+pyy.*byy+pzz.*pzz+(pxy.*bxy+pxz.*bxz+pyz.*byz)*2;

aver=(para+2*perp)/3;

para=para./n;
perp=perp./n;
aver=aver./n;

%}
[lpara,lx]=get_line_data(para,Lx,Ly,z0,1,0);
[cpara,~]=get_line_data(tpara,Lx,Ly,z0,1,0);

plot(lx,lpara,'k','LineWidth',2); hold on
plot(lx,cpara,'--r','LineWidth',2); hold off
