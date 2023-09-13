% function plot_local_Alfven_speed
%% plot the local Alfven speed profiels
clear;
%% parameters 
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);
norm=1; % prm.value.vA;
tt=28;
xz=-0.66;
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
vAl = slj.Physics.local_Alfven_speed(B, prm.value.mi.*Nl.value, prm);
vAh = slj.Physics.local_Alfven_speed(B, prm.value.mi.*Nh.value, prm);
vAe = slj.Physics.local_Alfven_speed(B, prm.value.me.*Ne.value, prm);
vAi = slj.Physics.local_Alfven_speed(B, prm.value.mi.*Ni, prm);
%% get the line
lvl=vAl.get_line2d(xz, dir, prm, norm);
lvh=vAh.get_line2d(xz, dir, prm, norm);
lve=vAe.get_line2d(xz, dir, prm, norm);
lvi=vAi.get_line2d(xz, dir, prm, norm);

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
plot(ll, lvl, '-r', 'LineWidth', 2);
hold on
plot(ll, lvh, '-b', 'LineWidth', 2);
plot(ll, lve, '-m', 'LineWidth', 2);
plot(ll, lvi, '-k', 'LineWidth', 2);
legend('hot ion', 'cold ion', 'electron', 'ion');
xlim(xrange);
xlabel(extra.xlabel);
ylabel('v_A');
set(gca,'FontSize', FontSize);

cd(outdir);
% print('-dpng','-r300',['vA_t',num2str(tt,'%06.2f'),'_',pstr,'=',num2str(xz),'.png']);