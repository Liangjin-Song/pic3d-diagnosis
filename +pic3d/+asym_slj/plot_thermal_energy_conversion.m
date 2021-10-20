% function plot_kinetic_energy_conversion
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Analysis\Electron';
prm=slj.Parameters(indir,outdir);

tt=100;
dt=1;
name='l';

xz=50;
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
[pUt, divPV, divQ, divH]= slj.Physics.thermal_energy_conversion(prm, name, tt, dt);

%% get line
lput=pUt.get_line2d(xz,dir,prm,norm);
ldivPV=divPV.get_line2d(xz,dir,prm,norm);
ldivQ=divQ.get_line2d(xz, dir, prm,norm);
ldivH=divH.get_line2d(xz, dir, prm,norm);

ltot = ldivPV + ldivQ + ldivH;

%% smooth
% lpkt = smoothdata(lpkt);
% ldivKV = smoothdata(ldivKV);
% lqVE = smoothdata(lqVE);
% ldivPV = smoothdata(ldivPV);


%% plot figure
figure;
plot(ll, lput, '-k', 'LineWidth', 2); hold on
plot(ll, ldivPV, '-r', 'LineWidth', 2);
plot(ll, ldivQ, '-b', 'LineWidth', 2);
plot(ll, ldivH, '-m', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial K/\partial t', '-\nabla\cdot(KV)', 'qNV\cdot E', '- (\nabla\cdot P) \cdot V', 'Sum', 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial K',sfx,'/\partial t']);
title(['profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',['J',sfx,'_E_B_t',num2str(tt(t)),'_line.png']);
% close(gcf);



% end
