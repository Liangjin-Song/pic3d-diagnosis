% function plot_local_Alfven_speed
%% plot the local Alfven speed profiels
clear;
%% parameters 
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);
tt=28;
xz=-0.76;
dir=0;
xrange=[35,45];
FontSize=14;

%% read data
B = prm.read('B', tt);
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Ni = Nl.value + Nh.value;

%% calculate
% gyro-frequency
wci = slj.Physics.local_gyro_frequency(B, prm.value.qi, prm.value.mi, prm);
wce = slj.Physics.local_gyro_frequency(B, abs(prm.value.qe), prm.value.me, prm);
% plasma frequency
wpl = slj.Physics.local_plasma_frequency(Nl, prm.value.mi, prm.value.qi, prm);
wph = slj.Physics.local_plasma_frequency(Nh, prm.value.mi, prm.value.qi, prm);
wpi = slj.Physics.local_plasma_frequency(Ni, prm.value.mi, prm.value.qi, prm);
wpe = slj.Physics.local_plasma_frequency(Ne, prm.value.me, abs(prm.value.qe), prm);
%% get the line
norm = 1;
lwci = wci.get_line2d(xz, dir, prm, norm);
lwce = wce.get_line2d(xz, dir, prm, norm);
lwpl = wpl.get_line2d(xz, dir, prm, norm);
lwph = wph.get_line2d(xz, dir, prm, norm);
lwpi = wpi.get_line2d(xz, dir, prm, norm);
lwpe = wpe.get_line2d(xz, dir, prm, norm);

if dir==1
    ll=prm.value.lz;
    pstr='x';
    extra.xlabel='Z [c/\omega_{pi}]';
else
    ll=prm.value.lx;
    pstr='z';
    extra.xlabel='X [c/\omega_{pi}]';
end

figure;
plot(ll, lwci, '-k', 'LineWidth', 2);
hold on
plot(ll, lwce, '--k', 'LineWidth', 2);
plot(ll, lwpl, '-b', 'LineWidth', 2);
plot(ll, lwph, '-g', 'LineWidth', 2);
plot(ll, lwpi, '-r', 'LineWidth', 2);
plot(ll, lwpe, '--r', 'LineWidth', 2);
legend('\omega_{ci}', '\omega_{ce}', '\omega_{pih}', '\omega_{pic}', '\omega_{pi}', '\omega_{pe}', 'Box', 'off');
xlim(xrange);
xlabel(extra.xlabel);
ylabel('\omega');
set(gca,'FontSize', FontSize);

cd(outdir);
% print('-dpng','-r300',['omega_t',num2str(tt,'%06.2f'),'_',pstr,'=',num2str(xz),'.png']);