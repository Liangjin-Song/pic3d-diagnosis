% function check_pressure_balance(indir, outdir)
%%
% @info: writen by Liangjin Song on 20210804
% @brief: check the pressure balance of the asym_rec_3s_slj model
%%
clear;
%% parameters
% input/output directory
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Global';
prm=slj.Parameters(indir,outdir);
% time
tt=0;
% the line
z0=5;
dir=1;
% figure style
extra.Visible=true;
extra.xrange=[prm.value.lx(1), prm.value.lx(end)];
extra.yrange=[prm.value.lz(1), prm.value.lz(end)];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

%% read data
B=prm.read('B',tt);
Pl=prm.read('Pl',tt);
Ph=prm.read('Ph',tt);
Pe=prm.read('Pe',tt);
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);

%% calculation
% pressure
Pb=B.sqre();
mu0=1/(prm.value.c*prm.value.c);
Pb=Pb.normalize(2*mu0);
Pl=(Pl.xx+Pl.yy+Pl.zz)/3;
% Pl=Pl.zz;
Pl=slj.Scalar(Pl);
Ph=(Ph.xx+Ph.yy+Ph.zz)/3;
% Ph=Ph.zz;
Ph=slj.Scalar(Ph);
Pe=(Pe.xx+Pe.yy+Pe.zz)/3;
% Pe=Pe.zz;
Pe=slj.Scalar(Pe);

% temperature
Tl=Pl/Nl;
Th=Ph/Nh;
Te=Pe/Ne;


%% get the line
pb=Pb.get_line2d(z0, dir, prm, 1);
ph=Ph.get_line2d(z0, dir, prm, 1);
pl=Pl.get_line2d(z0, dir, prm, 1);
pe=Pe.get_line2d(z0, dir, prm, 1);
al=pb+ph+pl+pe;

tl=Tl.get_line2d(z0, dir, prm, 1);
th=Th.get_line2d(z0, dir, prm, 1);
te=Te.get_line2d(z0, dir, prm, 1);

%% figure, pressure
ll=prm.value.lz;
f1=figure;
plot(ll,pb,'r','LineWidth', 2); hold on
plot(ll,ph,'g','LineWidth', 2);
plot(ll,pl,'b','LineWidth', 2);
plot(ll,pe,'m','LineWidth', 2);
plot(ll,al,'k','LineWidth', 2); hold off
legend('Pb','Pic','Pi','Pe','Sum');
ylabel('P');
xlabel('Z [c/\omega_{pi}]');
title(['\Omega_{ci}t = ',num2str(tt)]);
set(gca,'FontSize',16);
xlim(extra.yrange);
cd(outdir);
% end

%% figure, temperature
f2 = figure;
plot(ll, tl*prm.value.coeff, 'r', 'LineWidth',2); hold on
plot(ll, th*prm.value.coeff, 'g', 'LineWidth',2);
plot(ll, te*prm.value.coeff, 'b', 'LineWidth',2); hold off
legend('Hot Ions', 'Cold Ions', 'Electrons','Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
ylabel('Temperature * coeff');
set(gca,'FontSize',16);
xlim(extra.yrange);
cd(outdir);
print(f1,'-dpng','-r300',['P_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f2,'-dpng','-r300',['T_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);