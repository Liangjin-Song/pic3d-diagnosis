% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\PIC\Asym\data';
outdir='E:\PIC\Asym\out\Line';
prm=slj.Parameters(indir,outdir);
name='B';
component='y';
norm=1;
tt=100;
xz=40;
dir=1;
extra.xrange=[-20,20];
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
    sf='x';
else
    ll=prm.value.lx;
    extra.xlabel='X [c/\omega_{pi}]';
    sf='z';
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
f.png(prm,[name,component,'_t',num2str(tt,'%06.2f'),'_',sf,'=',num2str(xz)]);
% f.png(prm,['Bz_t',num2str(tt)]);