% function plot_kinetic_energy_conversion
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Energy\Kinetic';
prm=slj.Parameters(indir,outdir);

tt=16;
dt=1;
name='h';

% xz=16;
dir=0;
xz=0;
dx = 15;

nt=length(tt);

xrange=[40,60];

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

norm=1;
% norm=2*dt*prm.value.wci*prm.value.n0*tm/prm.value.coeff;


%% calculation
[pUt, divPV, divQ, divH]= slj.Physics.thermal_energy_conversion(prm, name, tt, dt);

%% get line
lput=pUt.get_line2d(xz,dir,prm,norm);
ldivPV=divPV.get_line2d(xz,dir,prm,norm);
ldivQ=divQ.get_line2d(xz, dir, prm,norm);
ldivH=divH.get_line2d(xz, dir, prm,norm);
% lput = mean(pUt.value(:, xz-dx:xz+dx), 2)/norm;
% ldivPV = mean(divPV.value(:, xz-dx:xz+dx),2)/norm;
% ldivQ = mean(divQ.value(:, xz-dx:xz+dx),2)/norm;
% ldivH = mean(divH.value(:, xz-dx:xz+dx), 2)/norm;


%% smooth
lput = smoothdata(lput, 'movmean', 40);
ldivPV = smoothdata(ldivPV, 'movmean', 40);
ldivQ = smoothdata(ldivQ, 'movmean', 40);
ldivH = smoothdata(ldivH, 'movmean', 40);

ltot = ldivPV + ldivQ + ldivH;

%% plot figure
figure;
plot(ll, lput, '-k', 'LineWidth', 2); hold on
plot(ll, ldivPV, '-r', 'LineWidth', 2);
plot(ll, ldivQ, '-b', 'LineWidth', 2);
plot(ll, ldivH, '-m', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-\nabla \cdot Q', '- \nabla \cdot (UV + P\cdot V)', 'Sum', 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
% title(['profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_thermal_energy_t',num2str(tt),'_line_', pstr,' = ',num2str(xz),'.png']);
% close(gcf);



% end
