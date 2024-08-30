%% plot figure 2, the local parameters
%%
clear;
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper6';
prm = slj.Parameters(indir, outdir);

%% time
tt = 30;

%% profile position in z-direction
pz = -0.96;
dir = 0;
lx = prm.value.lx;

%% inertial length
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Ni = slj.Scalar(Nl.value + Nh.value);

dil = slj.Physics.local_inertial_length(Nl, prm.value.mi, prm.value.qi, prm);
dih = slj.Physics.local_inertial_length(Nh, prm.value.mi, prm.value.qi, prm);
die = slj.Physics.local_inertial_length(Ne, prm.value.me, abs(prm.value.qe), prm);
dii = slj.Physics.local_inertial_length(Ni, prm.value.mi, prm.value.qi, prm);

norm = prm.value.di;
ldil = dil.get_line2d(pz, dir, prm, norm);
ldih = dih.get_line2d(pz, dir, prm, norm);
ldie = die.get_line2d(pz, dir, prm, norm);
ldii = dii.get_line2d(pz, dir, prm, norm);

%% local frequency
B = prm.read('B', tt);
wci = slj.Physics.local_gyro_frequency(B, prm.value.qi, prm.value.mi, prm);
wpl = slj.Physics.local_plasma_frequency(Nl, prm.value.mi, prm.value.qi, prm);
wph = slj.Physics.local_plasma_frequency(Nh, prm.value.mi, prm.value.qi, prm);
wpi = slj.Physics.local_plasma_frequency(Ni, prm.value.mi, prm.value.qi, prm);

norm = prm.value.wci;
lwci = wci.get_line2d(pz, dir, prm, norm);
lwpl = wpl.get_line2d(pz, dir, prm, norm);
lwph = wph.get_line2d(pz, dir, prm, norm);
lwpi = wpi.get_line2d(pz, dir, prm, norm);

%% local temperature
Pe=prm.read('Pe',tt);
Pl=prm.read('Pl',tt);
Ph=prm.read('Ph',tt);
Pi.xx = Pl.xx + Ph.xx;
Pi.yy = Pl.yy + Ph.yy;
Pi.zz = Pl.zz + Ph.zz;
Pi = (Pi.xx + Pi.yy + Pi.zz)/3;

Te = (Pe.xx + Pe.yy + Pe.zz)/3;
Te = slj.Scalar(Te./Ne.value);
Tl = (Pl.xx + Pl.yy + Pl.zz)/3;
Tl = slj.Scalar(Tl./Nl.value);
Th = (Ph.xx + Ph.yy + Ph.zz)/3;
Th = slj.Scalar(Th./Nh.value);
Ti = slj.Scalar(Pi./Ni.value);

norm = prm.value.tem * prm.value.tle * prm.value.thl;
lte = Te.get_line2d(pz, dir, prm, norm);
ltl = Tl.get_line2d(pz, dir, prm, norm);
lth = Th.get_line2d(pz, dir, prm, norm);
lti = Ti.get_line2d(pz, dir, prm, norm);
% lt = T.get_line2d(pz, dir, prm, norm);

%% local Alfven velocity
vAl = slj.Physics.local_Alfven_speed(B, prm.value.mi.*Nl.value, prm);
vAh = slj.Physics.local_Alfven_speed(B, prm.value.mi.*Nh.value, prm);
vAe = slj.Physics.local_Alfven_speed(B, prm.value.me.*Ne.value, prm);
vAi = slj.Physics.local_Alfven_speed(B, prm.value.mi.*Ni.value, prm);

norm = prm.value.vA;
lvl=vAl.get_line2d(pz, dir, prm, norm);
lvh=vAh.get_line2d(pz, dir, prm, norm);
lve=vAe.get_line2d(pz, dir, prm, norm);
lvi=vAi.get_line2d(pz, dir, prm, norm);


%% plot figure
f = figure('Position',[500,100,1400,800]);
h = slj.Plot.subplot(2,2,[0.025,0.08],[0.1,0.05],[0.1,0.05]);
xrange = [30, 40];
fontsize=16;

%% local inertial length
axes(h(1));
plot(lx, ldil, '-r', 'LineWidth', 2);
hold on
plot(lx, ldih, '-b', 'LineWidth', 2);
plot(lx, ldii, '-k', 'LineWidth', 2);
plot(lx, ldie, '-m', 'LineWidth', 2);
ylabel('inertial length')
xlim(xrange);
legend('hot ion', 'cold ion', 'ion', 'electron', 'Box', 'Off', ...
    'Position',[0.240238096706924 0.582291670391957 0.085714284245457 0.131874996274709]);
set(gca,'XTicklabel',[], 'FontSize', fontsize);

%% local frequency
axes(h(2));
plot(lx, lwpl, '-r', 'LineWidth', 2);
hold on
plot(lx, lwph, '-b', 'LineWidth', 2);
plot(lx, lwpi, '-k', 'LineWidth', 2);
plot(lx, lwci, '-m', 'LineWidth', 2);
ylabel('frequency')
xlim(xrange);
legend('\omega_{pih}', '\omega_{pic}', '\omega_{pi}', '\omega_{ci}', 'Box', 'Off', ...
    'Position',[0.604523810226293 0.57104167158405 0.0599999992975166 0.171874995082617]);
set(gca,'XTicklabel',[], 'FontSize', fontsize);

%% local temperature
axes(h(3));
plot(lx, ltl, '-r', 'LineWidth', 2);
hold on
plot(lx, lth, '-b', 'LineWidth', 2);
plot(lx, lti, '-k', 'LineWidth', 2);
plot(lx, lte, '-m', 'LineWidth', 2);
ylabel('temperature')
xlim(xrange);
legend('hot ion', 'cold ion', 'ion', 'electron', 'Box', 'Off', ...
    'Position',[0.278809525278353 0.187291676538686 0.085714284245457 0.131874996274709]);
xlabel('X [c/\omega_{pi}]');
set(gca, 'FontSize', fontsize);

axes(h(4));
plot(lx, lvl, '-r', 'LineWidth', 2);
hold on
plot(lx, lvh, '-b', 'LineWidth', 2);
plot(lx, lvi, '-k', 'LineWidth', 2);
% plot(lx, lve, '-m', 'LineWidth', 2);
ylabel('Alfven velocity')
xlim(xrange);
xlabel('X [c/\omega_{pi}]');
legend('hot ion', 'cold ion', 'ion', 'Box', 'Off');
set(gca, 'FontSize', fontsize);

%% annotation
annotation(f,'textbox',...
    [0.0442857142857143 0.925250001005828 0.04035714186728 0.0462499989941716],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.515714285714285 0.926500001005827 0.0410714275602784 0.0462499989941716],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.0357142857142857 0.489000001005827 0.04035714186728 0.0462499989941716],...
    'String',{'(c)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

annotation(f,'textbox',...
    [0.510714285714286 0.486500001005827 0.0410714275602784 0.0462499989941716],...
    'String',{'(d)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

%% save figure
cd(outdir);
print('-dpng', '-r300', 'figure2.png');