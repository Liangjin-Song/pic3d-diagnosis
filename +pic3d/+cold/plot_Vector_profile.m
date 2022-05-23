% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\DF';
prm=slj.Parameters(indir,outdir);
name='E';
component='x';
norm=1;
norm=prm.value.vA;
tt=30;
xz=0;
dir=0;
extra.xrange=[0,100];
extra.LineStyle='-';
extra.LineColor='k';
% extra.title=['\Omega_{ci}t=',num2str(tt)];

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
elseif component=='y'
    lf=lf.ly;
elseif component=='z'
    lf=lf.lz;
end
extra.ylabel=[name,'_{',component,'}'];
% lf=mean(V.x(prm.value.nz/2-100:prm.value.nz/2+100, :));
lf=smoothdata(lf,'movmean',40);
f=slj.Plot();
f.line(ll, lf, extra);
% f.png(prm,['Bz_t',num2str(tt)]);