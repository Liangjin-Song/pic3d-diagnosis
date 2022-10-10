% function plot_temperature_energy_density_conversion
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

tt=30;
dt=0.5;
name='h';

xz=3;
dir=1;
xz=881;
dx = 10;

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
    tm=prm.value.tlm;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.thm;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
norm=2*dt*prm.value.wci*tm/prm.value.coeff;
% norm=1;

%% calculation
[pTt, divQ, PddivV, pdivV, VdivT] = slj.Physics.energy_density_conversion(prm, name, tt, dt);

%% get line
% lptt=pTt.get_line2d(xz,dir,prm,norm);
% ldivQ=divQ.get_line2d(xz, dir, prm,norm);
% lPddivV=PddivV.get_line2d(xz,dir,prm,norm);
% lpdivV=pdivV.get_line2d(xz, dir, prm,norm);
% lVdivT=VdivT.get_line2d(xz, dir, prm,norm);

lpTt = mean(pTt.value(:, xz-dx:xz+dx), 2)/norm;
ldivQ = mean(divQ.value(:, xz-dx:xz+dx), 2)/norm;
lPddivV = mean(PddivV.value(:, xz-dx:xz+dx), 2)/norm;
lpdivV = mean(pdivV.value(:, xz-dx:xz+dx), 2)/norm;
lVdivT = mean(VdivT.value(:, xz-dx:xz+dx), 2)/norm;


%% smooth
ldivQ = smoothdata(ldivQ, 'movmean',2);
lPddivV = smoothdata(lPddivV,'movmean',80);
lpdivV = smoothdata(lpdivV,'movmean',80);
lVdivT = smoothdata(lVdivT, 'movmean',80);
lpTt = smoothdata(lpTt, 'movmean',20);

ltot = ldivQ + lPddivV + lpdivV + lVdivT;
%% plot figure
figure;
plot(ll, lpTt, '-k', 'LineWidth', 2); hold on
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
title(['\Omega_{ci}t = ',num2str(tt),'  profiles   ', 'x = ', num2str(xz)])
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_temperature_t',num2str(tt),'_line_', pstr,' = ',num2str(xz),'.png']);

% close(gcf);



% end

