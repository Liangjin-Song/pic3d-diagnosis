% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\Asym\cb20\data';
outdir='E:\Asym\cb20\out';
prm=slj.Parameters(indir,outdir);
name='E';
component='y';
norm=prm.value.vA;
tt=13;
xz=25;
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
    extra.ylabel=[name,'_{x}'];
elseif component=='y'
    lf=lf.ly;
    extra.ylabel=[name,'_{y}'];
elseif component=='z'
    lf=lf.lz;
    extra.ylabel=[name,'_{z}'];
end
f=slj.Plot();
f.line(ll, lf, extra);
% f.png(prm,['Bz_t',num2str(tt)]);