% function check_pressure_balance(indir, outdir)
%%
% @info: writen by Liangjin Song on 20210804
% @brief: check the pressure balance of the asym_rec_3s_slj model
%%
clear;
%% parameters
% input/output directory
indir='E:\Simulation\Test';
outdir='E:\Simulation\Test';
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
Pi=prm.read('Pi',tt);
Pe=prm.read('Pe',tt);
Ni=prm.read('Ni',tt);
Ne=prm.read('Ne',tt);

%% calculation
% pressure
Pb=B.sqre();
mu0=1/(prm.value.c*prm.value.c);
Pb=Pb.normalize(2*mu0);
% Pi=Pi.zz;
Pi=(Pi.xx+Pi.yy+Pi.zz)/3;
Pi=slj.Scalar(Pi);

% Pe=Pe.zz;
Pe=(Pe.xx+Pe.yy+Pe.zz)/3;
Pe=slj.Scalar(Pe);

% temperature
Ti=Pi/Ni;
Te=Pe/Ne;


%% get the line
pb=Pb.get_line2d(z0, dir, prm, 1);
pi=Pi.get_line2d(z0, dir, prm, 1);
pe=Pe.get_line2d(z0, dir, prm, 1);
al=pb+pi+pe;

ti=Ti.get_line2d(z0, dir, prm, 1);
te=Te.get_line2d(z0, dir, prm, 1);

%% figure, pressure
ll=prm.value.lz;
f1=figure;
plot(ll,pb,'r','LineWidth', 2); hold on
plot(ll,pi,'b','LineWidth', 2);
plot(ll,pe,'m','LineWidth', 2);
plot(ll,al,'k','LineWidth', 2); hold off
legend('Pb','Pi','Pe','Sum');
ylabel('P');
xlabel('Z [c/\omega_{pi}]');
title(['\Omega_{ci}t = ',num2str(tt)]);
set(gca,'FontSize',16);
xlim(extra.yrange);
cd(outdir);
% end

%% figure, temperature
f2 = figure;
plot(ll, ti*prm.value.coeff, 'r', 'LineWidth',2); hold on
plot(ll, te*prm.value.coeff, 'b', 'LineWidth',2); hold off
legend('Hot Ions', 'Electrons','Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
ylabel('Temperature * coeff');
set(gca,'FontSize',16);
xlim(extra.yrange);
cd(outdir);
print(f1,'-dpng','-r300',['P_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);
print(f2,'-dpng','-r300',['T_x=',num2str(z0),'_t',num2str(tt,'%06.2f'),'.png']);