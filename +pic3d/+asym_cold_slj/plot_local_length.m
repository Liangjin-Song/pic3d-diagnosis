% function plot_local_Alfven_speed
%% plot the local Alfven speed profiels
clear;
%% parameters 
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);
tt=28;
xz=-0.66;
dir=0;
xrange=[35,45];
FontSize=14;

%% read data
% density
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Ni = slj.Scalar(Nl.value + Nh.value);
% pressure
Pl=prm.read('Pl',tt);
Ph=prm.read('Ph',tt);
Pe=prm.read('Pe',tt);
Pi.xx = Pl.xx + Ph.xx;
Pi.xy = Pl.xy + Ph.xy;
Pi.xz = Pl.xz + Ph.xz;
Pi.yy = Pl.yy + Ph.yy;
Pi.yz = Pl.yz + Ph.yz;
Pi.zz = Pl.zz + Ph.zz;
Pi = slj.Tensor(Pi);

B = prm.read('B', tt);

%% calculate
% inertial length
dil = slj.Physics.local_inertial_length(Nl, prm.value.mi, prm.value.qi, prm);
dih = slj.Physics.local_inertial_length(Nh, prm.value.mi, prm.value.qi, prm);
die = slj.Physics.local_inertial_length(Ne, prm.value.me, abs(prm.value.qe), prm);
dii = slj.Physics.local_inertial_length(Ni, prm.value.mi, prm.value.qi, prm);
% debye length
dbl = slj.Physics.local_debye_length(Pl, Nl, prm.value.qi, prm);
dbh = slj.Physics.local_debye_length(Ph, Nh, prm.value.qi, prm);
dbi = slj.Physics.local_debye_length(Pi, Ni, prm.value.qi, prm);
dbe = slj.Physics.local_debye_length(Pe, Ne, abs(prm.value.qe), prm);
% gyroradius
lrl = slj.Physics.local_gyro_radius(Pl, Nl, B, prm.value.mi, prm.value.qi);
lrh = slj.Physics.local_gyro_radius(Ph, Nh, B, prm.value.mi, prm.value.qi);
lri = slj.Physics.local_gyro_radius(Pi, Ni, B, prm.value.mi, prm.value.qi);
lre = slj.Physics.local_gyro_radius(Pe, Ne, B, prm.value.me, prm.value.qi);
%% get the line
norm = 1;
ldil = dil.get_line2d(xz, dir, prm, norm);
ldih = dih.get_line2d(xz, dir, prm, norm);
ldie = die.get_line2d(xz, dir, prm, norm);
ldii = dii.get_line2d(xz, dir, prm, norm);
ldbl = dbl.get_line2d(xz, dir, prm, norm);
ldbh = dbh.get_line2d(xz, dir, prm, norm);
ldbi = dbi.get_line2d(xz, dir, prm, norm);
ldbe = dbe.get_line2d(xz, dir, prm, norm);

llrl = lrl.get_line2d(xz, dir, prm, norm);
llrh = lrh.get_line2d(xz, dir, prm, norm);
llri = lri.get_line2d(xz, dir, prm, norm);
llre = lre.get_line2d(xz, dir, prm, norm);

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
plot(ll, ldil, '-k', 'LineWidth', 2);
hold on
plot(ll, ldih, '-g', 'LineWidth', 2);
plot(ll, ldii, '-r', 'LineWidth', 2);
plot(ll, ldie, '-b', 'LineWidth', 2);
plot(ll, ldbl, '--k', 'LineWidth', 2);
plot(ll, ldbh, '--g', 'LineWidth', 2);
plot(ll, ldbi, '--r', 'LineWidth', 2);
plot(ll, ldbe, '--b', 'LineWidth', 2);
legend('d_{ih}', 'd_{ic}', 'd_i', 'd_e', '\lambda_{ih}', '\lambda_{ic}', '\lambda_{i}', '\lambda_e', 'Box', 'off');
xlim(xrange);
xlabel(extra.xlabel);
ylabel('inertial/debye length');
set(gca,'FontSize', FontSize);


figure;
plot(ll, llrl, '-b', 'LineWidth', 2);
hold on
plot(ll, llrh, '-g', 'LineWidth', 2);
plot(ll, llri, '-k', 'LineWidth', 2);
plot(ll, llre, '-r', 'LineWidth', 2);
legend('r_{ih}', 'r_{ic}', 'r_i', 'r_e', 'Box', 'off');
xlim(xrange);
xlabel(extra.xlabel);
ylabel('gyroradius');
set(gca,'FontSize', FontSize);


cd(outdir);
% print('-dpng','-r300',['length_t',num2str(tt,'%06.2f'),'_',pstr,'=',num2str(xz),'.png']);