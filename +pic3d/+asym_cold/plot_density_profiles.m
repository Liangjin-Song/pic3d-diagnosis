% function plot_density_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\PIC\Asym\data';
outdir='E:\PIC\Asym\out\Line';
name='Nsph';
tt=100;
xz=40;
dir=1;
extra.xlabel='Z [c/\omega_{pi}]';
extra.ylabel='Nsp_{ic}';
extra.xrange=[-10,10];

%% read data
prm=slj.Parameters(indir,outdir);
norm=(prm.value.ntm+prm.value.nts)/2;
N=prm.read(name,tt);
N=N.filter2d(3);

%% get the line
ln=N.get_line2d(xz, dir, prm, norm);
if dir==1
    ll=prm.value.lz;
    sf='x';
else
    ll=prm.value.lx;
    sf='z';
end
f=slj.Plot();
f.line(ll, ln, extra);
f.png(prm,[name,'_t',num2str(tt,'%06.2f'),'_',sf,'=',num2str(xz)]);
f.close();