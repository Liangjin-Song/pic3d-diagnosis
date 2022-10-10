% function plot_energy_conversion_profiles
%% plot the cold ions density profiles
% clear;
%% parameters 
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Line\DF';
name='e';
tt=30;
xz=0;
dir=0;
extra.xlabel='Z [c/\omega_{pi}]';
extra.ylabel='J_{ic}\cdot E';
extra.xrange=[30,70];
% extra.yrange=[,0.1];
extra.LineStyle={'-','-','-','-'};
extra.LineColor={'k','r','g','b'};
extra.legend={'J\cdot E', 'JxEx','JyEy','JzEz'};

%% read data
prm=slj.Parameters(indir,outdir);
norm=prm.value.n0*prm.value.vA*prm.value.vA;
N=prm.read(['N',name],tt);
V=prm.read(['V',name],tt);
E=prm.read('E',tt);

%% calculation
sig=1;
if strcmp(name,'e') || strcmp(name,'he')
    sig=-1;
end


JEx=slj.Scalar(sig.*V.x.*E.x.*N.value);
JEx=JEx.filter2d(3);
JEy=slj.Scalar(sig.*V.y.*E.y.*N.value);
JEy=JEy.filter2d(3);
JEz=slj.Scalar(sig.*V.z.*E.z.*N.value);
JEz=JEz.filter2d(3);



JE=V.dot(E);
JE=JE*N;
JE=JE.filter2d(3);
JE=slj.Scalar(sig.*JE.value);

%% get the line
lf.sum=JE.get_line2d(xz, dir, prm, norm);
lf.x=JEx.get_line2d(xz, dir, prm, norm);
lf.y=JEy.get_line2d(xz, dir, prm, norm);
lf.z=JEz.get_line2d(xz, dir, prm, norm);
if dir==1
    ll=prm.value.lz;
else
    ll=prm.value.lx;
end
f=slj.Plot();
f.linen(ll, lf, extra);
% plot(ll,lf.x,'r'); hold on
% plot(ll,lf.y,'g');
% plot(ll,lf.z,'b');
% plot(ll,lf.sum,'k');
% legend('JxEx','JyEy','JzEz', 'J\cdot E');
xlim(extra.xrange);
% f.png(prm,'Nic_t13-16_cross_x-line');
% f.close();