% function plot_temperature_energy_density_conversion
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Energy\Kinetic';
prm=slj.Parameters(indir,outdir);

tt=16;
dt=1;
name='h';

dir=0;
xz=0;
dx=20;

nt=length(tt);

xrange=[40,60];

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
    pstr2='z';
    [~, xz] = min(abs(prm.value.lx - xz));
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
    pstr2='x';
    [~, xz] = min(abs(prm.value.lz - xz));
end

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tem*prm.value.tle;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tem*prm.value.tle*prm.value.thl;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
% norm=2*dt*prm.value.wci*tm/prm.value.coeff;
norm=1;

%% calculation
[pTt, divQ, PddivV, pdivV, VdivT] = slj.Physics.energy_density_conversion(prm, name, tt, dt);

%% get line
% lpTt=pTt.get_line2d(xz,dir,prm,norm);
% ldivQ=divQ.get_line2d(xz, dir, prm,norm);
% lPddivV=PddivV.get_line2d(xz,dir,prm,norm);
% lpdivV=pdivV.get_line2d(xz, dir, prm,norm);
% lVdivT=VdivT.get_line2d(xz, dir, prm,norm);

if dir == 1
    lpTt = mean(pTt.value(:, xz-dx:xz+dx), 2)/norm;
    ldivQ = mean(divQ.value(:, xz-dx:xz+dx), 2)/norm;
    lPddivV = mean(PddivV.value(:, xz-dx:xz+dx), 2)/norm;
    lpdivV = mean(pdivV.value(:, xz-dx:xz+dx), 2)/norm;
    lVdivT = mean(VdivT.value(:, xz-dx:xz+dx), 2)/norm;
else
    lpTt = mean(pTt.value(xz-dx:xz+dx,:), 1)/norm;
    ldivQ = mean(divQ.value(xz-dx:xz+dx,:), 1)/norm;
    lPddivV = mean(PddivV.value(xz-dx:xz+dx,:), 1)/norm;
    lpdivV = mean(pdivV.value(xz-dx:xz+dx,:), 1)/norm;
    lVdivT = mean(VdivT.value(xz-dx:xz+dx,:), 1)/norm;
end


%% smooth
ldivQ = smoothdata(ldivQ, 'movmean',40);
lPddivV = smoothdata(lPddivV,'movmean',40);
lpdivV = smoothdata(lpdivV,'movmean',40);
lVdivT = smoothdata(lVdivT, 'movmean',40);
lpTt = smoothdata(lpTt, 'movmean',40);

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
    '-V\cdot\nabla T', 'Sum', 'Location', 'Best','Box', 'off');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial T',sfx,'/\partial t']);
title(['\Omega_{ci}t = ',num2str(tt),'  profiles   ', pstr2, ' = ', num2str(ll(xz))])
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_temperature_t',num2str(tt),'_line_', pstr,' = ',num2str(xz),'.png']);

% close(gcf);



% end

