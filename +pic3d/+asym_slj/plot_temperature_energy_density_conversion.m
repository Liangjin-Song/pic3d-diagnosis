% function plot_temperature_energy_density_conversion
clear;
%% parameters
indir='E:\Asym\Cold2\data';
outdir='E:\Asym\Cold2\out\Energy\Line';
prm=slj.Parameters(indir,outdir);

tt=30;
dt=1;
name='l';

xz=25;
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
[pTt, divQ, PddivV, pdivV, VdivT] = slj.Physics.energy_density_conversion(prm, name, tt, dt);

%% get line
lptt=pTt.get_line2d(xz,dir,prm,norm);
ldivQ=divQ.get_line2d(xz, dir, prm,norm);
lPddivV=PddivV.get_line2d(xz,dir,prm,norm);
lpdivV=pdivV.get_line2d(xz, dir, prm,norm);
lVdivT=VdivT.get_line2d(xz, dir, prm,norm);

ltot = ldivQ + lPddivV + lpdivV + lVdivT;

%% smooth
% lpkt = smoothdata(lpkt);
% ldivKV = smoothdata(ldivKV);
% lqVE = smoothdata(lqVE);
% ldivPV = smoothdata(ldivPV);


%% plot figure
figure;
plot(ll, lptt, '-k', 'LineWidth', 2); hold on
plot(ll, ldivQ, '-b', 'LineWidth', 2);
plot(ll, lPddivV, '-r', 'LineWidth', 2);
plot(ll, lpdivV, '-m', 'LineWidth', 2);
plot(ll, lVdivT, '-g', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial T/\partial t', '-2\nabla\cdot Q/3N', '- 2(P'' \cdot \nabla) \cdot V/3N', '-2p\nabla\cdot V/3N', ...
    '-V\cdot\nabla T', 'Sum', 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial T',sfx,'/\partial t']);
title(['profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',['J',sfx,'_E_B_t',num2str(tt(t)),'_line.png']);
% close(gcf);



% end

