%% plot the local temperature
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);
tt=40;
xz=-2;
dir=0;
xrange=[30,40];
FontSize=14;

%% load data
Ne=prm.read('Ne',tt);
Pe=prm.read('Pe',tt);
Te = (Pe.xx + Pe.yy + Pe.zz)/3;
Te = slj.Scalar(Te./Ne.value);

Pl=prm.read('Pl',tt);
Nl=prm.read('Nl',tt);
Tl = (Pl.xx + Pl.yy + Pl.zz)/3;
Tl = slj.Scalar(Tl./Nl.value);

Ph=prm.read('Ph',tt);
Nh=prm.read('Nh',tt);
Th = (Ph.xx + Ph.yy + Ph.zz)/3;
Th = slj.Scalar(Th./Nh.value);

Pi.xx = Pl.xx + Ph.xx;
Pi.yy = Pl.yy + Ph.yy;
Pi.zz = Pl.zz + Ph.zz;
Pi = (Pi.xx + Pi.yy + Pi.zz)/3;
Ni = Nl.value+Nh.value;
Ti = slj.Scalar(Pi./Ni);


N = (prm.value.mi*(Nl.value+Nh.value) + prm.value.me*Ne.value)./(prm.value.mi + prm.value.me);
P.xx = Pl.xx + Ph.xx + Pe.xx;
P.yy = Pl.yy + Ph.yy + Pe.yy;
P.zz = Pl.zz + Ph.zz + Pe.zz;
P = (P.xx + P.yy + P.zz)/3;
T = slj.Scalar(P./N);

%% plot
norm = prm.value.tem * prm.value.tle * prm.value.thl;
lte = Te.get_line2d(xz, dir, prm, norm);
ltl = Tl.get_line2d(xz, dir, prm, norm);
lth = Th.get_line2d(xz, dir, prm, norm);
lti = Ti.get_line2d(xz, dir, prm, norm);
lt = T.get_line2d(xz, dir, prm, norm);

if dir==1
    ll=prm.value.lz;
    pstr='x';
    extra.xlabel='Z [c/\omega_{pi}]';
else
    ll=prm.value.lx;
    pstr='z';
    extra.xlabel='X [c/\omega_{pi}]';
end

cd(outdir);
figure;
plot(ll, lt, '-k', 'LineWidth',2);
hold on;
plot(ll, ltl, '-r', 'LineWidth',2);
plot(ll, lth, '-b', 'LineWidth',2);
plot(ll, lte, '-g', 'LineWidth',2);
plot(ll, lti, '-m', 'LineWidth',2);
xlabel(extra.xlabel);
ylabel('T');
xlim(xrange);
legend('T','Tih','Tic','Te','Ti');
set(gca,'FontSize',FontSize);