% function plot_energy_conversion_profiles
%% plot the cold ions density profiles
% clear;
%% parameters 
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
prm=slj.Parameters(indir,outdir);
tt=30;
xz=0;
dir=0;
xrange=[35,65];
norm=prm.value.vA*prm.value.vA;

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end
%% read data and calculation
nf=1;
sig=1;
E=prm.read('E',tt);
V=prm.read('Vh',tt);
JE=V.dot(E);
JE=JE.filter2d(nf);
JEh=slj.Scalar(sig.*JE.value);

sig=1;
V=prm.read('Vl',tt);
JE=V.dot(E);
JE=JE.filter2d(nf);
JEl=slj.Scalar(sig.*JE.value);

sig=-1;
V=prm.read('Ve',tt);
JE=V.dot(E);
JE=JE.filter2d(nf);
JEe=slj.Scalar(sig.*JE.value);

%% line
jeh=JEh.get_line2d(xz, dir, prm, norm);
jel=JEl.get_line2d(xz, dir, prm, norm);
jee=JEe.get_line2d(xz, dir, prm, norm);

f=figure;
plot(ll, jeh, '-r', 'LineWidth', 2);
hold on
plot(ll, jel, '-b', 'LineWidth', 2);
plot(ll, jee, '-k', 'LineWidth', 2);
title(['profiles ',pstr, '=', num2str(dir),', \Omega_{ci}t=',num2str(tt)]);
xlabel(labelx);
ylabel('J \cdot E / N');
legend('Cold Ion', 'Hot Ion', 'Electron', 'Location', 'Best');
set(gca,'FontSize', 14);
xlim(xrange);