% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\PIC\Test';
outdir='E:\PIC\Test';
prm=slj.Parameters(indir,outdir);
name='B';
component='x';
norm=1;
tt=0;
xz=5;
dir=1;
extra.xrange=[-10,10];
extra.LineStyle='-';
extra.LineColor='k';
extra.title=['\Omega_{ci}t=',num2str(tt)];

%% read data
V=prm.read(name,tt);
%% get the line
lf=V.get_line2d(xz, dir, prm, norm);
if dir==1
    ll=prm.value.lz;
    extra.xlabel='Z [c/\omega_{pi}]';
else
    ll=prm.value.lx;
    extra.xlabel='X [c/\omega_{pi}]';
end
if component=='x'
    lf=lf.lx;
    extra.ylabel='B_{x}';
elseif component=='y'
    lf=lf.ly;
    extra.ylabel='B_{y}';
elseif component=='z'
    lf=lf.lz;
    extra.ylabel='B_{z}';
end
f=slj.Plot();
f.line(ll, lf, extra);
% f.png(prm,['Bz_t',num2str(tt)]);