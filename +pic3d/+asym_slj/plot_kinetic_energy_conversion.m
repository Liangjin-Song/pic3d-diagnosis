% function plot_kinetic_energy_conversion
clear;
%% parameters
indir='E:\Asym\Cold2\data';
outdir='E:\Asym\Cold2\out\Energy';
prm=slj.Parameters(indir,outdir);

tt=22;
dt=1;
name='e';

xz=10;
dir=1;

nt=length(tt);

xrange=[-5,5];

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
else
    error('Parameters Error!');
end

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
norm=1;

%% calculation
[pKt, divKV, qVE, divPV] = slj.Physics.kinetic_energy_conversion(prm, name, tt, dt, q, m);

%% get line
lpkt=pKt.get_line2d(xz,dir,prm,norm);
ldivKV=divKV.get_line2d(xz,dir,prm,norm);
lqVE=qVE.get_line2d(xz,dir,prm,norm);
ldivPV=divPV.get_line2d(xz,dir,prm,norm);

%% smooth
% lpkt = smoothdata(lpkt);
% ldivKV = smoothdata(ldivKV);
% lqVE = smoothdata(lqVE);
% ldivPV = smoothdata(ldivPV);

ltot=ldivKV + ldivPV + lqVE;

%% plot figure
plot(ll, lpkt, '-k', 'LineWidth', 2); hold on
plot(ll, ldivKV, '-b', 'LineWidth', 2);
plot(ll, lqVE, '-m', 'LineWidth', 2);
plot(ll, ldivPV, '-r', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial K/\partial t', '-\nabla\cdot(KV)', 'qNV\cdot E', '- (\nabla\cdot P) \cdot V', 'Sum', 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial K',sfx,'/\partial t']);
title(['\Omega_{ci}t = ',num2str(tt),', profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',[sfx,'_bulk_kinetic_energy_t',num2str(tt),'_line_',pstr,'=',num2str(xz),'.png']);
% close(gcf);



% end