% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\line';
prm=slj.Parameters(indir,outdir);
name='E';
component='z';
norm=prm.value.vA;
% norm=1;
tt=30;
xz=25;
dir=1;
extra.xrange=[-10,10];
extra.LineStyle='-';
extra.LineColor='k';
extra.title=['\Omega_{ci}t=',num2str(tt)];
extra.Fontsize=16;

%% read data
V=prm.read(name,tt);
%% get the line
lf=V.get_line2d(xz, dir, prm, norm);
if dir==1
    ll=prm.value.lz;
    pstr='x';
    extra.xlabel='Z [c/\omega_{pi}]';
else
    ll=prm.value.lx;
    pstr='z';
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

extra.title=['profiles ',pstr,' = ',num2str(xz),',  \Omega_{ci}t=',num2str(tt)];

f=slj.Plot();
f.line(ll, lf, extra);
% f.png(prm,['Bx_t',num2str(tt),'_',pstr,num2str(xz)]);